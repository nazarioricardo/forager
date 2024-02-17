require 'signet/errors'

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
    rescue_from Signet::AuthorizationError, with: :handle_unauthorized
  end

  private
  
  def authenticate
    if current_user.nil?
      redirect_to "/"
      return
    end

    if current_user.google_token.nil?
      redirect_to omniauth_authorize_path(:user, :google_oauth2)
      return
    end

    if Time.now >= current_user.expires_at
      refresh_token(current_user)
    end
  end

  def handle_unauthorized
    if current_user.nil?
      redirect_to "/"
      return
    end

    if current_user.google_token.nil?
      redirect_to omniauth_authorize_path(:user, :google_oauth2)
      return
    end

    if Time.now >= current_user.expires_at
      refresh_token(current_user)
    end
  end

  def refresh_token(user)
    uri = URI.parse("https://oauth2.googleapis.com/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "client_id" => ENV['GOOGLE_OAUTH_CLIENT_ID'],
      "client_secret" => ENV['GOOGLE_OAUTH_CLIENT_SECRET'],
      "refresh_token" => user.refresh_token,
      "grant_type" => "refresh_token",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    auth = request.env['omniauth.auth']
    user.google_token = auth.credentials.token 
    user.refresh_token = auth.credentials.refresh_token
    user.expires_at = auth.credentials.expires_at 
    user.save
  end
end