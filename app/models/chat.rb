class Chat < ApplicationRecord
  
  belongs_to :end_user
  belongs_to :room
  
  validates :message, presence: true
  
end
