class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'sent_by_id', inverse_of: 'sent_by', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'sent_to_id', inverse_of: 'sent_to', dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship', foreign_key: 'sent_by_id'
  has_many :friends, through: :confirmed_friendships, source: :sent_to

  # Users who needs to confirm friendship
  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'sent_to_id'
  has_many :pending_friends, through: :pending_friendships, source: :sent_by

  # Users who requested to be friends (needed for notifications)
  has_many :inverted_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'sent_by_id'
  has_many :friend_requests, through: :inverted_friendships, source: :sent_to

  def confirm_friend(sender)
    friend = Friendship.find_by(sent_by_id: sender.id, sent_to_id: id)
    friend.status = true
    friend.save
    Friendship.create!(sent_by_id: id, sent_to_id: sender.id, status: true)
  end

  def friends_and_own_posts
    Post.where(user: friends_ids)
    # Post.where(user: (self.friends.to_a << self))
  end

  def friends_ids
    f_ids = friends.map(&:id)
    f_ids << id
  end
end
