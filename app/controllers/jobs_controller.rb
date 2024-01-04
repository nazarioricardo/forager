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
    @letters = Letter.all
  end

  def update
    print "updating ", params, "\n"
    @job = Job.find(params[:id])
    print "found job ", @job, "\n"
    if @job.update(job_params)
      print "updated job ", @job, "\n"
      redirect_to @job
    else
      print "failed to update job ", @job.errors.full_messages, "\n"
      @resumes = Resume.all
      @letters = Letter.all
      render :show
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :resume_id, :letter_id, :status, :link)
  end
end