class Public::EndUsersController < ApplicationController
  before_action :set_user, only: [:favorites]
  def index
    @end_users = EndUser.all
  end
  
  def show
    @end_user = EndUser.find(params[:id])
    @nails = @end_user.nails.order(created_at: :desc)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
     @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def favorites
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:nail_id)
    @favorite_nails = Nail.find(favorites)
  end

  def unsubscribe
  end

  def withdraw
    @end_user = current_end_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :profile_image, :email)
  end
  
  def set_user
    @end_user = EndUser.find(params[:id])
  end
  
end
