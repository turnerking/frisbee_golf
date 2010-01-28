class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores, :force => true do |t|
      t.integer :scorecard_id
      t.integer :shots
      t.integer :par
      t.integer :number
      t.integer :distance_in_ft
      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
