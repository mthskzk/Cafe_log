class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  def customer_index
    @customer = Customer.find(params[:customer_id])
    @posts = Post.where(customer_id: @customer.id).page(params[:page]).per(10)
  end

end
