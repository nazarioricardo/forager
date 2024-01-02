class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates_format_of :link, with: /\A#{URI::regexp(['http', 'https'])}\z/, message: 'must be a valid URL'

  belongs_to :resume, optional: true
  belongs_to :letter, optional: true

  enum status: { created: 0, applied: 1, interviewing: 2, done: 3 }
end
