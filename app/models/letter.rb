class Letter < ApplicationRecord
  validates :title, presence: true
  validates :google_drive_file_id, presence: true

  belongs_to :user
  
  has_many :jobs

  def drive_url
    "https://drive.google.com/file/d/#{self.google_drive_file_id}/view"
  end

  def docs_url
    "https://docs.google.com/document/d/#{self.google_drive_file_id}/edit"
  end
end