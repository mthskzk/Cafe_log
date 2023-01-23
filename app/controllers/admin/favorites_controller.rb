class Admin::FavoritesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post = Post.find(params[:post_id])
    @favorite = Favorite.find_by(post_id: @post.id)
  end
end
