class Comment < ApplicationRecord
  
  belongs_to :end_user
  belongs_to :nail
  
end
