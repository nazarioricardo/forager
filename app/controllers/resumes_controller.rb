class ResumesController < ApplicationController
  def new
    @resume = Resume.new
  end

  def create
    job_id = params[:resume][:job_id] if params[:resume]
    cleaned_params = resume_params.except(:job_id)
    @resume = current_user.resumes.new(cleaned_params)

    if @resume.save
      if job_id = resume_params[:job_id]
        @job = Job.update(job_id, resume_id: @resume.id)
        redirect_to @job
      else 
        redirect_to @resume
      end
    else
      puts @resume.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @resume = Resume.find(params[:id])
  end

  def download
    @resume = Resume.find(params[:id])
    google = GoogleService.new(current_user.google_token)

    # Copy the file and convert it to a Google Doc
    file_id = @resume.google_drive_file_id
    copy = google.drive.copy_file(file_id, Google::Apis::DriveV3::File.new(mime_type: 'application/vnd.google-apps.document'))
    doc_id = copy.id
    
    # Replace all instances of "Ricardo" with "George"
    requests = [Google::Apis::DocsV1::Request.new(replace_all_text: Google::Apis::DocsV1::ReplaceAllTextRequest.new(contains_text: Google::Apis::DocsV1::SubstringMatchCriteria.new(text: 'Ricardo', match_case: true), replace_text: 'George'))]
    google.docs.batch_update_document(doc_id, Google::Apis::DocsV1::BatchUpdateDocumentRequest.new(requests: requests))

    # Export the Google Doc as a PDF
    pdf_data = google.drive.export_file(doc_id, 'application/pdf')

    # Send the PDF data as a file download
    send_data pdf_data, filename: 'modified_resume.pdf', type: 'application/pdf'
  end

  private

  def resume_params
    params.require(:resume).permit(:title, :subtitle, :google_drive_file_id, :job_id)
  end
end