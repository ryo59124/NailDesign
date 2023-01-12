class Nail < ApplicationRecord
  
  has_one_attached :image
  
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :body,presence:true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @nail = Nail.where("body LIKE?","#{word}")
    elsif search == "forward_match"
      @nail = Book.where("body LIKE?","#{word}%")
    elsif search == "backward_match"
      @nail = Book.where("body LIKE?","%#{word}")
    elsif search == "partial_match"
      @nail = Book.where("body LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end
  
end
