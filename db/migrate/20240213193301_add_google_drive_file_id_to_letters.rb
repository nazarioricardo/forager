class AddGoogleDriveFileIdToLetters < ActiveRecord::Migration[7.1]
  def change
    add_column :letters, :google_drive_file_id, :string
  end
end
