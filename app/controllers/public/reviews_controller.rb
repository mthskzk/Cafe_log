class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    if params[:cafe_id].present?
      @cafe = Cafe.find(params[:cafe_id])
    end
  end

  def index
    customer = Customer.find(params[:customer_id])
    @reviews = customer.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    cafe_name = params[:review][:cafe_name]
    cafe_exist = Cafe.find_by(name: cafe_name)
    if cafe_exist.nil?
      cafe = Cafe.new(name: cafe_name, prefectures: "", address_after: "", nearest_station: "", telephone_number: "", business_hours: "", regular_holiday: "")
      cafe.save
      @review.cafe_id = cafe.id
    else
      @review.cafe_id = cafe_exist.id
    end
    if @review.save
      redirect_to customer_reviews_path(current_customer.id), notice: "レビューしました"
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to customer_reviews_path(current_customer.id)
  end

  def edit
    @review = Review.find(params[:id])
    @cafe = Cafe.find(@review.cafe_id)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to customer_reviews_path(current_customer.id)
    else
      render :edit
    end
  end

  def cafe_index
    @cafe = Cafe.find(params[:cafe_id])
    @reviews = @cafe.reviews
  end

  private

  def review_params
    params.require(:review).permit(:body, :rate)
  end
end
