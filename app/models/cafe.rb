class Cafe < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :keep_caves, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :prefectures, presence: true
  validates :address_after, presence: true
  validates :nearest_station, presence: true
  validates :telephone_number, presence: true
  validates :business_hours, presence: true
  validates :regular_holiday, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }

end
