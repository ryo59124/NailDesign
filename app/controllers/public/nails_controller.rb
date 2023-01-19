class Public::NailsController < ApplicationController
  def index
    @nails = Nail.all
  end
  
  def new
    @nail = Nail.new
  end
  
  def create
    @nail = Nail.new(nail_params)
    @nail.end_user_id = current_end_user.id
    if @nail.save
      redirect_to nails_path
    else
      render :new
    end
  end

  def show
    @nail = Nail.find(params[:id])
    @comment = Comment.new
    @end_user = @nail.end_user
  end

  def edit
    @nail = Nail.find(params[:id])
  end

  def destroy
    @nail = Nail.find(params[:id])
    @nail.destroy
    redirect_to '/nails'
  end

  def update
    @nail = Nail.find(params[:id])
    if @nail.update(nail_params)
      redirect_to nail_path(@nail), notice: "You have updated nail successfully."
    else
      render :edit
    end
  end
  
  private

  def nail_params
    params.require(:nail).permit(:image, :title, :body)
  end
  
end
