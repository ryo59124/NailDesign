class Public::NailsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @nails_top = Nail.published.joins(:favorites).group(:nail_id).order('count(favorites.nail_id) desc').limit(3)
    @nails = if params[:tag_id].present?
      tag = Tag.find_by(id: params[:tag_id])
      if tag.nil?
        Nail.all
      else
        tag.nails
      end
    else
      Nail.all
    end
    @nails = @nails.joins(:end_user).where(end_user: { is_deleted: false }).published.page(params[:page]).per(6)
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
        redirect_to nails_path, notice:'投稿を公開しました！'
      else
        redirect_to confirm_end_user_path(current_end_user), notice: 'Draft Nailsに保存しました！'
      end
    else
      render :new
    end
  end

  def show
    @nail = Nail.find(params[:id])
    @comment = Comment.new
    @edit_user = @nail.end_user
    @nail_tags = @nail.tags
    if @nail.status == "draft" && current_end_user != @edit_user
      redirect_to nails_path
    end
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
        redirect_to nail_path(@nail), notice: '投稿を公開しました！'
      else
        redirect_to nail_path(@nail), notice: 'Draft Nailsに保存しました！'
      end
    else

      render :edit
    end
  end

  private

  def nail_params
    params.require(:nail).permit(:image, :title, :body, :tags, :status)
  end

  def is_matching_login_user
    @nail = Nail.find(params[:id])
    @edit_user = @nail.end_user
    redirect_to(nails_path) unless @edit_user == current_end_user
  end

end