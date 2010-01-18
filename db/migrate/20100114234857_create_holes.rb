class CreateHoles < ActiveRecord::Migration
  def self.up
    create_table :holes do |t|
      t.integer :number
      t.integer :par
      t.integer :distance_in_ft
      t.integer :course_id
      t.timestamps
    end
  end

  def self.down
    drop_table :holes
  end
end
