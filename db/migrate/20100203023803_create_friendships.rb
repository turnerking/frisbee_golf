class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships, :force => true do |t|
      t.datetime :approved_at
      t.integer :requester_id
      t.integer :approver_id
      t.timestamps
    end
    
    create_table :friendships_users, :id => false, :force => true do |t|
      t.integer :user_id
      t.integer :friendship_id
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships_users
    drop_table :friendships
  end
end
