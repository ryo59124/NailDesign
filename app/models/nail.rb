class Nail < ApplicationRecord
  
  has_one_attached :image
  
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :body,presence:true
  
end
