module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private
  
  def authenticate
    if current_user.nil?
      redirect_to "/"
    end

    if current_user.google_token.nil?
      redirect_to "/users/auth/google_oauth2"
    end
  end
end