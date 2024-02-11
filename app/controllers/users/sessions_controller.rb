class Users::SessionsController < Devise::SessionsController
  def destroy
    current_user.update(google_token: nil) if current_user
    super
  end
end