class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'sent_by_id', inverse_of: 'sent_by', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'sent_to_id', inverse_of: 'sent_to',
                            dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) }, through: :friend_sent, source: :sent_to, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # review
  # has_many :confirmed_friendships, -> { where confirmed: true }, class_name: "Friendship"
  # has_many :friends, through: :confirmed_friendships

  # has_many :pending_friendships, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "user_id"
  # has_many :pending_friends, through: :pending_friendships, source: :friend

  # has_many :inverted_friendships, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "friend_id"
  # has_many :friend_requests, through: :inverted_friendships
end
