class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search_sns
    @model = params[:model]
    @key_word = params[:key_word]
    @method = params[:method]
    if @model == "customer"
      records = Customer.search_for(@key_word)
      @records = Post.where(customer_id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "cafe"
      records = Cafe.admin_search_for(@key_word, @method)
      @records = Post.where(cafe_id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "post"
      @records = Post.search_for(@key_word).page(params[:page]).per(10)
    elsif @model == "tag"
      records = Tag.search_post_for(@key_word, @method)
      @records = Post.where(id: records.map(&:id)).page(params[:page]).per(10)
    end
  end

  def search_review
    @model = params[:model]
    @key_word = params[:key_word]
    @method = params[:method]
    if @model == "customer"
      records = Customer.search_for(@key_word)
      @records = Review.where(customer_id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "cafe"
      records = Cafe.admin_search_for(@key_word,@method)
      @records = Review.where(cafe_id: records.map(&:id)).page(params[:page]).per(10)
    elsif @model == "review"
      @records = Review.search_for(@key_word).page(params[:page]).per(10)
    end
  end

  def search_cafe
    @cafe_name =  params[:cafe_name]
    @is_deleted = params[:is_deleted]
    @cafes = Cafe.admin_search_for(@cafe_name,"partial").page(params[:page]).per(10)
  end

  def search_customer
    @name = params[:name]
    @email = params[:email]
    @customers = Customer.admin_search_for(@name, @email).page(params[:page]).page(params[:page]).per(10)
  end

end
