require 'zip'

class JobsController < ApplicationController
  def new
    @job = Job.new
    @resumes = current_user.resumes
    @letters = current_user.letters
  end

  def create
    @job = current_user.jobs.new(job_params)
    @resumes = current_user.resumes
    @letters = current_user.letters

    if @job.save
      redirect_to @job
    else
      puts @job.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @job = Job.find(params[:id])
    @resumes = current_user.resumes
    @letters = current_user.letters
  end

  def edit
    @job = Job.find(params[:id])
    @resumes = current_user.resumes
    @letters = current_user.letters
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to job_path(@job)
    else
      head :unprocessable_entity
    end
  end

  def download
    @job = Job.find(params[:id])
    doc_service = DocumentService.new(current_user.google_token)
    
    zip_stream = Zip::OutputStream.write_buffer do |zip|
      if @job&.resume&.google_drive_file_id
        resume_pdf_data = doc_service.generate_pdf(
          @job.resume.google_drive_file_id, 
          "#{@job.company} Resume", 
          "#{@job.company} - #{@job.role}"
        )

        zip.put_next_entry("#{@job.role} Resume.pdf")
        zip.write resume_pdf_data
      end
    
      if @job&.letter&.google_drive_file_id
        letter_pdf_data = doc_service.generate_pdf(
          @job.letter.google_drive_file_id, 
          "#{@job.role} Letter", 
          "#{@job.company} - #{@job.role}"
        )
        
        zip.put_next_entry("#{@job.role} Letter.pdf")
        zip.write letter_pdf_data
      end
    end
  
    zip_stream.rewind
    sanitized_title = @job.role.gsub(/[^0-9A-Za-z.\-]/, '_')
    send_data zip_stream.read, filename: "#{sanitized_title} Documents.zip", type: 'application/zip'
  end

  private

  def job_params
    params.require(:job).permit(:company, :role, :description, :resume_id, :letter_id, :status, :link)
  end
end