class Admin::PostsController < ApplicationController
  def index
  end

  def confirm
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_homes_top_path
  end
end
