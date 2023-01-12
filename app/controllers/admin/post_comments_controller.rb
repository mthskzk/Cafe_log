class Admin::PostCommentsController < ApplicationController
  def index
     @post = Post.find(params[:post_id])
  end

  def confirm
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to  admin_post_post_comments_path(params[:post_id])
  end
end
