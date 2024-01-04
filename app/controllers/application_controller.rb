class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    '/dashboard'
  end

  def after_sign_out_path_for(scope)
    session.delete(:first_visit)
    '/'
  end
end
