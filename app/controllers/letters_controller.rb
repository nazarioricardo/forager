class LettersController < ApplicationController
  include Authentication

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
        redirect_to dashboard_path
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
    @job = Job.find(params[:job_id])

    pdf_data = @letter.copy_and_export(@job.company, @job.role, current_user.google_token)    
    send_data pdf_data, filename: "#{@letter.title}.pdf", type: 'application/pdf'
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :subtitle, :google_drive_file_id, :job_id)
  end
end