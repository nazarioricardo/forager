class LettersController < ApplicationController
  def new
    @letter = Letter.new
  end

  def create
    @letter = current_user.letters.new(letter_params)
    if @letter.save
      redirect_to @letter
    else
      render 'new'
    end
  end

  def show
    @letter = Letter.find(params[:id])
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :subtitle, :pdf)
  end
end