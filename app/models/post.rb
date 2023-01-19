class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :cafe
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :images, presence: true

  # 複数枚の画像を取り込み
  has_many_attached :images

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  # タグを保存する関数
  def save_tags(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在存在しているタグから送られてきた新しいタグを引いたものを古いタグとする。古いタグは削除。
    old_tags = current_tags - sent_tags
    # 今回送られてきたタグの中で現在登録されていないタグを新しいタグとする。新しいタグは保存。
    new_tags = sent_tags - current_tags

    # 古いタグの削除
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name:old_tag)
    end

    # 新しいタグを保存
    new_tags.each do |new_tag|
      new_post_tag = Tag.find_or_create_by(name:new_tag)
      self.tags << new_post_tag
    end
  end

# 投稿のキーワード検索は部分一致のみ
  def self.search_for(content)
      Post.where('body LIKE ?', '%'+content+'%')
  end

  def self.search_cafe_for(content, method)
    if method == 'perfect'
      Post.includes(:cafe).where(caves: {name: content})
    elsif method == 'partial'
      Post.joins(:cafe).where('cafe.name LIKE ?', '%' + content + '%')
    end
  end

end
