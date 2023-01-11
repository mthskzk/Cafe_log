class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @customer = current_customer
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    # tag_list = params[:post][:tag_name].split(',') ←タグ機能のやつ
    if @post.save
      # @post.save_tags(tag_list)
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
