class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_nail_path(params[:nail_id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
