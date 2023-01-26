class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post = Post.find(params[:post_id])
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end
end
