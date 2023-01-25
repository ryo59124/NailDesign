class Public::FavoritesController < ApplicationController

  def create
    @nail = Nail.find(params[:nail_id])
    favorite = @nail.favorites.new(end_user_id: current_end_user.id)
    favorite.save
  end

  def destroy
    @nail = Nail.find(params[:nail_id])
    favorite = @nail.favorites.find_by(end_user_id: current_end_user.id)
    favorite.destroy
  end

  def index
    @end_user = EndUser.find(params[:end_user_id])
    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:nail_id)
    @favorite_nails = Nail.order(created_at: :desc).find(favorites)
  end

end
