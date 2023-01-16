class Public::SearchesController < ApplicationController
  def search_sns
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "tag"
      records = Tag.search_post_for(@content, @method)
      # array型の配列をActive Recordに変換
      @records = Post.where(id: records.map(&:id))
    elsif @model == "post"
      @records = Post.search_for(@content)
    elsif @model == "customer"
      @records = Customer.search_for(@content)
    end
  end

  def search_review
  end

  def search_cafe
    @area = params[:area]
    @key_word = params[:key_word]
    @cafes = Cafe.search_for(@area, @key_word)
  end
end
