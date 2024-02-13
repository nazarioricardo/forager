class Resume < ApplicationRecord
  validates :title, presence: true
  validates :google_drive_file_id, presence: true
  
  belongs_to :user

  has_many :jobs

  def google_drive_url
    "https://drive.google.com/file/d/#{self.google_drive_file_id}/view"
  end
end