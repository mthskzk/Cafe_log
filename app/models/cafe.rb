class Cafe < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :keep_caves, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :is_deleted, inclusion: { in: [true, false] }

  # 住所を基準に緯度経度を算出
  geocoded_by :address_display

  # 住所変更時に緯度経度も変更
  after_validation :geocode

  def get_image
    (image.attached?) ? image: "no_image.png"
  end

  def address_display
    self.prefectures.to_s+self.address_after.to_s
  end

  def self.search_for(area, key_word)
    if area == "京都"
      Cafe.where("prefectures LIKE ?", area + "%")
    else
      Cafe.where("prefectures LIKE ? OR address_after LIKE ?", "%" + area + "%",  "%" + area + "%").where("name LIKE ?", "%" + key_word + "%")
    end
  end

  def self.search_post_for(content, method)
    if method == 'perfect'
      cafes = Cafe.where(name: content)
    elsif method == 'partial'
      cafes = Cafe.where('name LIKE ?', '%' + content + '%')
    end
     # 検索結果のカフェに紐づくpost_idを返す
     return cafes.inject(init = []) {|result, cafe| result + cafe.posts}
  end

  # 管理者側のカフェ検索
  def self.admin_search_for(cafe_name, method)
    if method == 'perfect'
      Cafe.where(name: cafe_name)
    elsif method == 'partial'
      Cafe.where('name LIKE ?', '%' + cafe_name + '%')
    end
  end

  # 会員側で登録されていないカフェを投稿・レビューに紐づけできるようにバリデーションを切った
  # そのため管理者側でカフェの登録・編集するときに空がないこを確認する
  def search_blank
    if self.name.blank? or self.prefectures.blank? or self.address_after.blank? or self.nearest_station.blank? or self.telephone_number.blank? or self.business_hours.blank? or self.regular_holiday.blank?
      return false
    else
      return true
    end
  end

  # 会員側で登録されていないカフェを投稿・レビューに紐づけできるようにバリデーションを切った
  # 1つでも空白があるものは管理者のトップページに表示されるようにする
  def self.blank_exist
    Cafe.where(prefectures: "").or(Cafe.where(address_after: "")).or(Cafe.where(nearest_station: "")).or(Cafe.where(telephone_number: "")).or(Cafe.where(business_hours: "")).or(Cafe.where(regular_holiday: ""))
  end

  # カフェが保存されているかどうかの確認
  def keep_by?(customer)
    keep_caves.exists?(customer_id: customer.id)
  end

end
