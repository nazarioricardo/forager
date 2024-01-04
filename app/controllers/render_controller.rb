class RenderController < ApplicationController
  before_action :redirect_if_first_visit

  def index
  end

  private

  def redirect_if_first_visit
    if user_signed_in? && session[:first_visit].nil?
      session[:first_visit] = true
      redirect_to '/dashboard'
    end
  end
end
