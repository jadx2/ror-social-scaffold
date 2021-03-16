class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :sent_to, null: false, foreign_key: { to_table: :users }
      t.references :send_by, null: false, foreign_key: { to_table: :users } 
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
