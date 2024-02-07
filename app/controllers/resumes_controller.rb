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

  private

  def resume_params
    params.require(:resume).permit(:title, :subtitle, :pdf, :job_id)
  end
end