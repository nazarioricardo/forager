module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private
  
  def authenticate
    user = User.find(params[:user_id])
    if user.google_token.nil?
      redirect_to "/"
    end
  end
end