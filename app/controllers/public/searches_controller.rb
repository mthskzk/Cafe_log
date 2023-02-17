class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!, except: [:search_cafe]

  def search_sns
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "tag"
      # 複数検索に対応させる
      split_tag = @content.split(/[[:blank:]]+/)
      records = []
      split_tag.each do |tag|
        next if tag == ""
        records += Tag.search_post_for(tag, @method)
      end
      records.uniq!
      # array型の配列をActive Recordに変換
      @records = Post.where(id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "cafe"
      records = Cafe.search_post_for(@content, @method)
      @records = Post.where(id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "post"
      # 複数検索に対応させる
      split_content = @content.split(/[[:blank:]]+/)
      records = []
      split_content.each do |content|
        records += Post.search_for(content)
      end
      @records = Post.where(id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "customer"
      @records = Customer.search_for(@content)
    end
  end

  def search_cafe
    @area = params[:area]
    @key_word = params[:key_word]
    @cafes = Cafe.search_for(@area, @key_word).page(params[:page]).per(10)
    if @area == ""
      @area = "全国"
    end
  end
end
