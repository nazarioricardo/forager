class DashboardController < ApplicationController
  def show
    # Add your logic here
    drive_service = GoogleDriveService.new(current_user.google_token)
    files = drive_service.list_files
    # print files
  end
end