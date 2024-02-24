require 'zip'

class JobsController < ApplicationController
  include Authentication
  
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
      redirect_to dashboard_path
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

  def update_status
    @job = Job.find(params[:id])
    if @job.update(status: params[:status])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def download
    @job = Job.find(params[:id])
    doc_service = DocumentService.new(current_user.google_token)
    full_name = current_user.full_name

    zip_stream = Zip::OutputStream.write_buffer do |zip|
      if @job&.resume&.google_drive_file_id
        resume_pdf_data = @job.resume.copy_and_export(@job.company, @job.role, current_user.google_token)
        zip.put_next_entry("#{full_name} Resume.pdf")
        zip.write resume_pdf_data
      end
    
      if @job&.letter&.google_drive_file_id
        letter_pdf_data = @job.letter.copy_and_export(@job.company, @job.role, current_user.google_token)
        zip.put_next_entry("#{full_name} Letter.pdf")
        zip.write letter_pdf_data
      end
    end
  
    zip_stream.rewind
    sanitized_name = @job.name.gsub(/[^0-9A-Za-z.\-]/, ' ')
    send_data zip_stream.read, filename: "#{sanitized_name}.zip", type: 'application/zip'
  end

  private

  def job_params
    params.require(:job).permit(:company, :role, :description, :resume_id, :letter_id, :status, :link)
  end
end