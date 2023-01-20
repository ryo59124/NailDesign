class Public::NailsController < ApplicationController
  def index
    @nails = Nail.published.order(created_at: :desc)
    @tag_list=Tag.all
  end

  def new
    @nail = Nail.new
  end

  def create
    @nail = Nail.new(nail_params)
    @nail.end_user_id = current_end_user.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:nail][:name].split(',')
    if @nail.save
      @nail.save_tag(tag_list)
      redirect_to nails_path, notice:'投稿完了しました:)'
    else
      render :new
    end
  end

  def show
    @nail = Nail.find(params[:id])
    @comment = Comment.new
    @end_user = @nail.end_user
    @nail_tags = @nail.tags
  end

  def edit
    @nail = Nail.find(params[:id])
    @tag_list = @nail.tags.pluck(:name).join(',')
  end

  def destroy
    @nail = Nail.find(params[:id])
    @nail.destroy
    redirect_to '/nails'
  end

  def update
    @nail = Nail.find(params[:id])
    tag_list = params[:nail][:name].split(',')
    if @nail.update(nail_params)
      if params[:nail][:status]== "公開"
        @old_relations=NailTag.where(nail_id: @nail.id)
        @old_relations.each do |relation|
        relation.delete
        end
        @nail.save_tag(tag_list)
        redirect_to nail_path(@nail), notice: "You have updated nail successfully."
      else
        redirect_to nails_path, notice: '下書きに登録しました。'
      end
    else
      render :edit
    end
  end

  private

  def nail_params
    params.require(:nail).permit(:image, :title, :body, :tags, :status)
  end

end