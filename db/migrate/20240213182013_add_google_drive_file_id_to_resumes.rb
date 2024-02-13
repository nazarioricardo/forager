class AddGoogleDriveFileIdToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :google_drive_file_id, :string
  end
end
