class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  # 複数枚の画像を取り込み
  has_many_attached :images

end
