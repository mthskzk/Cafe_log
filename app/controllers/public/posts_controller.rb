class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only:[:edit, :update, :destroy]

  def new
    @post = Post.new
    if params[:cafe_id].present?
      @cafe = Cafe.find(params[:cafe_id])
    end
  end

  def index
    @customer = current_customer
    @posts = Post.page(params[:page]).per(10)
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    # gsubで全角スペースを半角スペースに変換しgsubで半角スペースを削除
    tag_list = params[:post][:tag_name].gsub(/　/," ").gsub(" ","").split(',')
    # 既存のカフェを選択して投稿された場合
    if params[:post][:cafe_number] == "1"
      @post.cafe_id = params[:post][:cafe_id]
    # 新しいカフェを選択して投稿された場合
    elsif params[:post][:cafe_number] == "2"
      cafe_name = params[:post][:cafe_name]
      # フォームに入力されたカフェ名が既にあるか確認
      cafe_exist = Cafe.find_by(name: cafe_name)
      # 未登録のカフェの場合
      if cafe_exist.nil?
        cafe = Cafe.new(name: cafe_name, prefectures: "", address_after: "", nearest_station: "", telephone_number: "", business_hours: "", regular_holiday: "")
        cafe.save
        @post.cafe_id = cafe.id
      # 登録済みカフェの場合
      else
        @post.cafe_id = cafe_exist.id
      end
    end
    if @post.save
      @post.save_tags(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
       @post.save_tags(tag_list)
       redirect_to posts_path
    else
      render:edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # SNS検索画面
  def searche
  end

  private

  def post_params
    params.require(:post).permit(:body, :status, :image)
  end

  def ensure_correct_customer
    post1 = Post.find(params[:id])
    @customer = Customer.find_by(id: post1.customer_id)
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

end
