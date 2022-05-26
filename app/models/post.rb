class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :image
  
  validates :body, presence:true, length:{ maximum: 300 }
  validates :image, presence:true
  validate :image_type
 
 def image_type
   extension = ['image/png', 'image/jpg', 'image/jpeg']
   errors.add(:image, "の拡張子が間違っています") unless image.content_type.in?(extension)
 end
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def create_notification_favorite!(current_user)
    #いいねされているか調べている
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    #いいねされていない場合の処理
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      #自分の投稿に対するいいねの場合は、通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_user, post_comment_id)
    #コメントをしているユーザー全員に通知を送る
    # temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids = PostComment.where(post_id: id).where.not(user_id: current_user.id).distinct.pluck(:user_id)
    temp_ids << user_id
    temp_ids = temp_ids.uniq
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id)
    end
    #誰もコメントしていない場合に投稿者にのみ通知
     save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  #コメントを送るたびに通知
  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    #自分に対するコメントは通知済みにする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
