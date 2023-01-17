class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "You have updated end_user successfully."
      redirect_to admin_end_user_path(@end_user)
    else
      render :edit
    end
  end
  
  
  private

  def end_user_params
    params.require(:end_user).permit(:is_deleted)
  end
  
end
