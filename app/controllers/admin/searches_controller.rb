class Admin::SearchesController < ApplicationController
  def search_sns
    @model = params[:model]
    @key_word = params[:key_word]
    if @model == "customer"
      records = Customer.search_for(@key_word)
      @records = Post.where(customer_id: records.map(&:id))
    elsif @model == "cafe"
      records = Cafe.search_post_for(@key_word, "partial")
      @records = Post.where(cafe_id: records.map(&:id))
    elsif @model == "post"
      @records = Post.search_for(@key_word)
    end
  end

  def search_review
  end

  def search_cafe
    @cafe_name =  params[:cafe_name]
    @is_deleted = params[:is_deleted]
    @cafes = Cafe.admin_search_for(@cafe_name)
  end

  def search_customer
    @name = params[:name]
    @email = params[:email]
    @customers = Customer.admin_search_for(@name, @email).page(params[:page])
  end

end
