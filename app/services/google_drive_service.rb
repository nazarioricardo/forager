require 'google/apis/drive_v3'

class GoogleDriveService
  APPLICATION_NAME = 'Forager'
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE
  
  def initialize(access_token)
    @service = Google::Apis::DriveV3::DriveService.new
    @service.authorization = access_token
  end

  def list_files
    response = @service.list_files(page_size: 10, order_by: 'modifiedTime desc')

    files = []
    response.files.each do |file|
      files << {name: file.name, id: file.id}
    end
    files
  end
end