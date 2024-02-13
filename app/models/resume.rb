class Resume < ApplicationRecord
  validates :title, presence: true
  # validate :pdf_attached
  validates :google_drive_file_id, presence: true
  
  # has_one_attached :pdf
  belongs_to :user

  has_many :jobs

  # def pdf_attached
  #   errors.add(:pdf, "must be attached") unless pdf.attached?
  # end
end