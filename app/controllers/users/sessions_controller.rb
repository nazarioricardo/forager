class Users::SessionsController < Devise::SessionsController
  def destroy
    current_user.update(google_token: nil, refresh_token: nil, expires_at: nil) if current_user
    super
  end
end