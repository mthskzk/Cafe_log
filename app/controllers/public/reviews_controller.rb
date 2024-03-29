class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!, except: [:cafe_index]
  before_action :ensure_correct_customer, only:[:destroy, :edit, :update]

  def new
    @review = Review.new
    if params[:cafe_id].present?
      @cafe = Cafe.find(params[:cafe_id])
    end
  end

  def index
    @customer = Customer.find(params[:customer_id])
    @reviews = @customer.reviews.page(params[:page]).per(10)
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    # 既存のカフェを選択して投稿された場合
    if params[:review][:cafe_number] == "1"
      @review.cafe_id = params[:review][:cafe_id]
    # 新しいカフェを選択して投稿された場合
    elsif params[:review][:cafe_number] == "2"
      cafe_name = params[:review][:cafe_name]
      # フォームに入力されたカフェ名が既にあるか確認
      cafe_exist = Cafe.find_by(name: cafe_name)
      # 未登録のカフェの場合
      if cafe_exist.nil?
        cafe = Cafe.new(name: cafe_name, prefectures: "", address_after: "", nearest_station: "", telephone_number: "", business_hours: "", regular_holiday: "")
        cafe.save
        @review.cafe_id = cafe.id
      # 登録済みのカフェの場合
      else
        @review.cafe_id = cafe_exist.id
      end
    end
    if @review.save
      redirect_to customer_reviews_path(current_customer.id)
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
    @reviews = @cafe.reviews.page(params[:page]).per(10)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rate)
  end

  def ensure_correct_customer
    review = Review.find(params[:id])
    @customer = Customer.find_by(id: review.customer_id)
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
