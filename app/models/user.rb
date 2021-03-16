class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friend_sent, foreign_key: 'sent_by_id',  class_name: 'Friendship', inverse_of: 'send_by', dependent: :destroy
  has_many :friend_request, foreign_key: 'send_to_id', class_name: 'Friendship', inverse_of: 'send_to', dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) }, through: :friend_sent, source: :sent_to 
  has_many :pending_requests, -> { merge(Friendship.not_friends) }, through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { merge(Friendship.not_friends) }, through: :friend_request, source: :send_by
end
