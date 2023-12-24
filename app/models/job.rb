class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :resume, optional: true
  belongs_to :letter, optional: true
end
