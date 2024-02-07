class LettersController < ApplicationController
  def new
    @letter = Letter.new
  end

  def create
    job_id = params[:letter][:job_id] if params[:letter]
    letter_params_without_job_id = letter_params.except(:job_id)
    @letter = current_user.letters.new(letter_params_without_job_id)

    if @letter.save
      if job_id = letter_params[:job_id]
        @job = Job.update(job_id, letter_id: @letter.id)
        redirect_to @job
      else
        redirect_to @letter
      end
    else
      puts @letter.errors.full_messages
      render :new
    end
  end

  def show
    @letter = Letter.find(params[:id])
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :subtitle, :pdf, :job_id)
  end
end