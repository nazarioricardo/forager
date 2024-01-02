class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :resume, optional: true
  belongs_to :letter, optional: true

  enum status: { created: 0, applied: 1, interviewing: 2, done: 3 }
end
