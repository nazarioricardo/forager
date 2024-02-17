class ResumesController < ApplicationController
  include Authentication

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
    @job = Job.find(params[:job_id])

    pdf_data = @resume.copy_and_export(@job.company, @job.role, current_user.google_token)    
    send_data pdf_data, filename: "#{@resume.title}.pdf", type: 'application/pdf'
  end

  private

  def resume_params
    params.require(:resume).permit(:title, :subtitle, :google_drive_file_id, :job_id)
  end
end