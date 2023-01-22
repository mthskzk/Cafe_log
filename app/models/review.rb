class Review < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe

  validates :rate, presence: true


# レビューのキーワード検索は部分一致のみ
  def self.search_for(content)
      Review.where('body LIKE ?', '%'+content+'%')
  end

end
