class Public::NailsController < ApplicationController
  def index
    @nails_top = Nail.published.joins(:favorites).group(:nail_id).order('count(favorites.nail_id) desc').limit(3)
    @nails = params[:tag_id].present? ? Tag.find(params[:tag_id]).nails : Nail.published.order(created_at: :desc)
  end

  def new
    @nail = Nail.new
  end

  def create
    @nail = Nail.new(nail_params)
    @nail.end_user_id = current_end_user.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:nail][:name].split(',')
    @nail.save_tag(tag_list)
    if @nail.save
      if params[:nail][:status] == "published"
        redirect_to nails_path, notice:'投稿完了しました:)'
      else
        redirect_to confirm_end_user_path(current_end_user), notice: '下書きに登録しました!'
      end
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
      if params[:nail][:status] == "published"
        @old_relations=NailTag.where(nail_id: @nail.id)
        # それらを取り出し、消す。消し終わる
        @old_relations.each do |relation|
        relation.delete
        end
        @nail.save_tag(tag_list)
        redirect_to nail_path(@nail), notice: '投稿完了しました:)'
      else
        redirect_to nail_path(@nail), notice: '下書きに登録しました!'
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