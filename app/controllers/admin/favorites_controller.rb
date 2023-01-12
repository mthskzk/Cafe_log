class Admin::FavoritesController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find_by(post_id: @post.id)
  end
end
