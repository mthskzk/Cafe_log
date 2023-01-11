class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :book_tags

end
