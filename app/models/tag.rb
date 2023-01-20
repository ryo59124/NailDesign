class Tag < ApplicationRecord
  has_many :nail_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :nails, through: :nail_tags, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true
  
end