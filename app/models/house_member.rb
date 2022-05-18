class HouseMember < ApplicationRecord
  belongs_to :user
  
  validates :name, presence:true, length: { maximum: 30 }
  validates :introduction, presence:true, length: { maximum: 250 }
  validates :position, presence:true
  
  #シェアハウスメンバー職業
  enum position:{
    "---":0,
    会社員:1,学生:2,フリーター:3,その他:4
  }, _prefix: true
end
