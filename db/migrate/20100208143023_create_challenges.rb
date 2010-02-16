class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.integer :organizer_id
      t.integer :course_id
      t.datetime :play_from
      t.datetime :play_to
      t.datetime :submit_by
      t.timestamps
    end
    create_table :challengers, :force => true, :id => false do |t|
      t.integer :user_id
      t.integer :challenge_id
    end
  end

  def self.down
    drop_table :challengers
    drop_table :challenges
  end
end
