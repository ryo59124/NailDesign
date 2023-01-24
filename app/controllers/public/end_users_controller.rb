class Public::EndUsersController < ApplicationController
  before_action :set_user, only: [:favorites]
  before_action :is_matching_login_user, only: [:edit, :update, :confirm, :withdraw, :unsubscribe]
  
  def index
    @end_users = EndUser.all
  end
  
  def show
    @end_user = EndUser.find(params[:id])
    @nails = @end_user.nails.published.order(created_at: :desc).page(params[:page]).per(6)
  end
  
  def confirm
    @end_user = EndUser.find(params[:id])
    @nails = @end_user.nails.draft.order('created_at DESC')
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
  
  def is_matching_login_user
    end_user_id = params[:id].to_i
    unless end_user_id == current_end_user.id
      redirect_to nails_path
    end
  end

end