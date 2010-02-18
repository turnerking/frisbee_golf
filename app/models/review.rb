class Review < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  def self.recent_review_for(user, course)
    return nil if user.nil? || course.nil?
    Review.find(:first, :conditions => ["user_id = ? AND course_id = ?", user.id, course.id], :order => "created_at DESC")
  end
end
