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

  enum prefectures: {
    北海道: 0, 青森県: 1, 岩手県: 2, 秋田県: 3, 宮城県: 4, 山形県: 5, 福島県: 6,
    茨城県: 7, 栃木県: 8, 群馬県: 9, 埼玉県: 10, 東京都: 11, 千葉県: 12, 神奈川県: 13,
    山梨県: 14, 新潟県: 15, 長野県: 16, 静岡県: 17, 富山県: 18, 石川県: 19, 福井県: 20, 岐阜県: 21, 愛知県: 22,
    滋賀県: 23, 三重県: 24, 奈良県: 25, 和歌山県: 26, 京都府: 27, 大阪府: 28, 兵庫県: 29,
    鳥取県: 30, 岡山県: 31, 島根県: 32, 広島県: 33, 山口県: 34,
    香川県: 35, 徳島県: 36, 愛媛県: 37, 高知県: 38,
    福岡県: 39, 佐賀県: 40, 長崎県: 41, 大分県: 42, 熊本県: 43, 宮崎県: 44, 鹿児島県: 45, 沖縄県: 46
  }

  def address_display
    self.prefectures+self.address_after
  end

  def self.search_for(area, key_word)
    Cafe.where("prefectures LIKE ? OR address_after LIKE ?", "%" + area + "%",  "%" + area + "%").where("name LIKE ?", "%" + key_word + "%")
  end

end
