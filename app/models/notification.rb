class Notification < ApplicationRecord
  belongs_to :user
  scope :friend_request, -> { where('notice_type = friendRequest') }
end
