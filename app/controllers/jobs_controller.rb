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

  def edit
    @job = Job.find(params[:id])
    @resumes = Resume.all
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to @job
    else
      render :show
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :resume_id, :letter_id)
  end
end