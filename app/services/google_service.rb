require 'google/apis/drive_v3'
require 'google/apis/docs_v1'

class GoogleService
  attr_reader :drive, :docs

  APPLICATION_NAME = 'Forager'
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE
  
  def initialize(access_token)
    Google::Apis.logger.level = Logger::ERROR
    @drive = Google::Apis::DriveV3::DriveService.new
    @drive.authorization = access_token
    @docs = Google::Apis::DocsV1::DocsService.new
    @docs.authorization = access_token
  end
end