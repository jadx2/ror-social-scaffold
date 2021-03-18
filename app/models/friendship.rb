class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id', dependent: :destroy
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id', dependent: :destroy

  scope :friends, -> { where('status =?', true) }
  scope :not_friends, -> { where('status =?', false) }
end
