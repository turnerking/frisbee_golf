class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.string :address
      t.string :tee_type
      t.integer :difficulty
      t.integer :tree_interference
      t.string :hole_type
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
