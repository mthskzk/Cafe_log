class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def index
    @customer = current_customr

  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to reviews_path, notice: "レビューしました"
    else
      render :new
    end
  end

  def destroy
  end
end
