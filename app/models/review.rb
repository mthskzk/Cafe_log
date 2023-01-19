class Review < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe

  validates :rate, presence: true

end
