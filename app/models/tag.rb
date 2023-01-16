class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  scope :merge_posts, -> (tags){ }

  validates :name, uniqueness: true, presence: true

  def self.search_post_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'partial'
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end
    # 検索結果のタグに紐づくpost_idを返す
    return tags.inject(init = []) {|result, tag| result + tag.posts}

  end

end
