class AddRatingsToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :difficulty, :integer
    add_column :reviews, :tree_interference, :integer
    add_column :reviews, :course_quality, :integer
  end

  def self.down
    remove_column :reviews, :course_quality
    remove_column :reviews, :tree_interference
    remove_column :reviews, :difficulty
  end
end
