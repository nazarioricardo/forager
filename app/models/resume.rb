class Resume < ApplicationRecord
  has_one_attached :pdf
  belongs_to :user
end