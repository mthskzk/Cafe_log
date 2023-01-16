class Public::FavoritesController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find_by(post_id: @post.id)
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
    render "replace_favorite"
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
    render "replace_favorite"
  end

  # ログインユーザーがいいねした投稿の一覧画面
  def like
    @customer = current_customer
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @posts = Post.where(id: favorites)
  end

end
