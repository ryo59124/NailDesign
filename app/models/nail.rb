class Nail < ApplicationRecord
  
  has_one_attached :image
  
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :nail_tags, dependent: :destroy
  has_many :tags, through: :nail_tags, dependent: :destroy

  validates :title, presence: true
  validates :body, presence:true
  validates :image, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
  def self.looks(search, word)
    if search != ""
      @nail = Nail.where("body LIKE? OR title LIKE?","%#{word}%","%#{word}%")
    else
      @nail = Nail.all
    end
  end
  
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end
    
  

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end
  
  enum status: { draft: 0, published: 1 }
  validates :status, inclusion: { in: Nail.statuses.keys }
  
end
