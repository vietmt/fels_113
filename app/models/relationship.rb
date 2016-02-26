class Relationship < ActiveRecord::Base

  before_create :create_activity
  before_destroy :update_activity

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def create_activity
    follower.activities.create state: :follow, target_id: followed.id
  end

  def update_activity
    follower.activities.create state: :unfollow, target_id: followed.id
  end
end
