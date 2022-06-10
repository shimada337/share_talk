class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :board
  
  validates :body, presence: true, length: { maximum: 150 }
end
