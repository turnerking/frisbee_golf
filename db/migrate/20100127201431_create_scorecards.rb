class CreateScorecards < ActiveRecord::Migration
  def self.up
    create_table :scorecards, :force => true do |t|
      t.integer :user_id
      t.integer :course_id
      t.string  :weather
      t.string :temperature
      t.datetime :played_at
      t.string :ground_conditions
      t.float :hours_to_play
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :scorecards
  end
end
