class Job < ApplicationRecord
  validates :company, presence: true
  validates :role, presence: true
  validates :description, presence: true
  validates_format_of :link, with: /\A#{URI::regexp(['http', 'https'])}\z/, message: 'must be a valid URL', allow_blank: true

  belongs_to :resume, optional: true
  belongs_to :letter, optional: true

  enum status: { created: 0, applied: 1, interviewing: 2, done: 3 }

  before_create :set_default_status

  def name
    "#{self.company} #{self.role}"
  end

  private

  def set_default_status
    self.status ||= :created
  end
end
