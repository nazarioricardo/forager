class LettersController < ApplicationController
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
        redirect_to @letter
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
    doc_service = DocumentService.new(current_user.google_token)

    pdf_data = google.drive.export_file(@letter.google_drive_file_id, 'application/pdf')
    send_data pdf_data, filename: "#{@letter.title} Letter.pdf", type: 'application/pdf'
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :subtitle, :google_drive_file_id, :job_id)
  end
end