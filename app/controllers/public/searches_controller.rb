class Public::SearchesController < ApplicationController
  def search_sns
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "tag"
      records = Tag.search_post_for(@content, @method)
      # array型の配列をActive Recordに変換
      @records = Post.where(id: records.map(&:id))
    elsif @model == "cafe"
      records = Cafe.search_post_for(@content, @method)
      @records = Post.where(Cafe_id: records.map(&:id))
    elsif @model == "post"
      @records = Post.search_for(@content)
    elsif @model == "customer"
      @records = Customer.search_for(@content)
    end
  end

  def search_cafe
    @area = params[:area]
    @key_word = params[:key_word]
    @cafes = Cafe.search_for(@area, @key_word)
    # sort = params[:sort]
    # if sort == "rate" or sort == nil
      # @cafes = Cafe.search_for(@area, @key_word).order("rate DESC")
    # elsif sort == "review"
      # @cafes = Cafe.search_for(@area, @key_word).joins(:reviews).order("count(cafe_id) DESC")
    # end
  end
end
