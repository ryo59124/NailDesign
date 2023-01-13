class Public::CommentsController < ApplicationController
  def create
    nail = Nail.find(params[:nail_id])
    comment = current_end_user.comments.new(comment_params)
    comment.nail_id = nail.id
    comment.save
    redirect_to nail_path(nail)
  end
  
  def destroy
    Nail.find(params[:id]).destroy
    redirect_to nail_path(params[:nail_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
