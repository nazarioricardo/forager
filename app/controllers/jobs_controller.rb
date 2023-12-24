class JobsController < ApplicationController
  def new
    @job = Job.new
    @resumes = Resume.all
    @letters = Letter.all
  end

  def create
    @job = current_user.jobs.new(job_params)
    if @job.save
      redirect_to @job
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
    @resumes = Resume.all
    @letters = Letter.all
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to @job
    else
      render :edit
    end
  end

  
  def update_resume
    @job = Job.find(params[:id])
    if @job.update(resume_id: params[:resume_id])
      redirect_to @job
    else
      render :edit
    end
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :resume_id, :letter_id)
  end
end