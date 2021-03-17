class AddSeenToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notice_seen, :boolean, default: true
    add_column :notifications, :seen, :boolean, default: false
  end
end
