class Letter < ApplicationRecord
  validates :title, presence: true
  validate :pdf_attached

  has_one_attached :pdf
  belongs_to :user
  
  has_many :jobs

  def pdf_attached
    errors.add(:pdf, "must be attached") unless pdf.attached?
  end
end