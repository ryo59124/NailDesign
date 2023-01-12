class Public::FavoritesController < ApplicationController
  def create
    nail = Nail.find(params[:nail_id])
    favorite = current_end_user.favorites.new(nail_id: nail.id)
    favorite.save
    redirect_to nail_path(nail)
  end

  def destroy
    nail = Nail.find(params[:nail_id])
    favorite = current_end_user.favorites.find_by(nail_id: nail.id)
    favorite.destroy
    redirect_to nail_path(nail)
  end
end
