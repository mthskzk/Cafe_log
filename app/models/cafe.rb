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

  # 住所を基準に緯度経度を算出
  geocoded_by :address_display

  # 住所変更時に緯度経度も変更
  after_validation :geocode

  def get_image
    (image.attached?) ? image: "no_image.png"
  end

  def address_display
    self.prefectures+self.address_after
  end

  def self.search_for(area, key_word)
    Cafe.where("prefectures LIKE ? OR address_after LIKE ?", "%" + area + "%",  "%" + area + "%").where("name LIKE ?", "%" + key_word + "%")
  end

end
