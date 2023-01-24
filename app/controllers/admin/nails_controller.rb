class Admin::NailsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @nails_top = Nail.published.joins(:favorites).group(:nail_id).order('count(favorites.nail_id) desc').limit(3)
    @nails = Nail.published.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @nail = Nail.find(params[:id])
    @edit_user = @nail.end_user
    if @nail.status == "draft"
      redirect_to admin_nails_path
    end
  end

  def destroy
    @nail = Nail.find(params[:id])
    @nail.destroy
    redirect_to '/admin/nails'
  end
  
  
  private

  def nail_params
    params.require(:nail).permit(:image, :title, :body)
  end
  
end
