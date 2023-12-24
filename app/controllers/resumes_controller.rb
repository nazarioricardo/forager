class ResumesController < ApplicationController
  def new
    @resume = Resume.new
  end

  def create
    @resume = current_user.resumes.new(resume_params)
    if @resume.save
      redirect_to @resume
    else
      render 'new'
    end
  end

  def show
    @resume = Resume.find(params[:id])
  end

  private

  def resume_params
    params.require(:resume).permit(:title, :subtitle, :pdf)
  end
end