class Letter < ApplicationRecord
  validates :title, presence: true
  validates :google_drive_file_id, presence: true

  belongs_to :user
  
  has_many :jobs
end