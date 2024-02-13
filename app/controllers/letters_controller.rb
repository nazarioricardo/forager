class LettersController < ApplicationController
  def new
    @letter = Letter.new
  end

  def create
    job_id = params[:letter][:job_id] if params[:letter]
    cleaned_params = letter_params.except(:job_id)
    @letter = current_user.letters.new(cleaned_params)

    if @letter.save
      if job_id = letter_params[:job_id]
        @job = Job.update(job_id, letter_id: @letter.id)
        redirect_to @job
      else
        redirect_to @letter
      end
    else
      puts @letter.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @letter = Letter.find(params[:id])
  end

  def download
    @letter = Letter.find(params[:id])
    google = GoogleService.new(current_user.google_token)

    # Copy the file and convert it to a Google Doc
    file_id = @letter.google_drive_file_id
    copy = google.drive.copy_file(file_id, Google::Apis::DriveV3::File.new(mime_type: 'application/vnd.google-apps.document'))
    doc_id = copy.id
    
    # Replace all instances of "Ricardo" with "George"
    requests = [Google::Apis::DocsV1::Request.new(replace_all_text: Google::Apis::DocsV1::ReplaceAllTextRequest.new(contains_text: Google::Apis::DocsV1::SubstringMatchCriteria.new(text: 'Ricardo', match_case: true), replace_text: 'George'))]
    google.docs.batch_update_document(doc_id, Google::Apis::DocsV1::BatchUpdateDocumentRequest.new(requests: requests))

    # Export the Google Doc as a PDF
    pdf_data = google.drive.export_file(doc_id, 'application/pdf')

    # Send the PDF data as a file download
    send_data pdf_data, filename: 'modified_letter.pdf', type: 'application/pdf'
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :subtitle, :google_drive_file_id, :job_id)
  end
end