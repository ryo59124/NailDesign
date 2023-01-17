class Admin::NailsController < ApplicationController
  def index
    @nails = Nail.all
  end

  def show
    @nail = Nail.find(params[:id])
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
