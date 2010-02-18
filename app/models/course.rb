class Course < ActiveRecord::Base
  TEE_TYPES = ["Gravel", "Concrete", "Sand"]
  HOLE_TYPES = ["Basket", "Target", "Mixed"]
  
  has_many :holes, :order => :number
  has_many :scorecards
  has_many :reviews, :order => "created_at DESC"
  has_many :challenges
  
  accepts_nested_attributes_for :holes, :allow_destroy => true, :reject_if => proc {|attributes| attributes["number"].blank? || attributes["par"].blank? || attributes["distance_in_ft"].blank?}
  
  validates_presence_of :name
  
  def recent_unique_reviews
    @recent_reviews ||= Review.find(:all, :conditions => ["course_id = ? AND created_at > ?", self.id, 1.year.ago], :order => "created_at DESC")
  end
  
  def total_par
    holes.map(&:par).sum
  end
  
  def total_distance
    holes.map(&:distance_in_ft).sum
  end
  
  def course_quality
    course_quality_reviews = recent_unique_reviews.map(&:course_quality).compact
    (((course_quality_reviews.sum / course_quality_reviews.size.to_f)*100.0).round)/100.0
  end
  
  def community_difficulty
    difficulty_reviews = recent_unique_reviews.map(&:difficulty).compact
    (((difficulty_reviews.sum / difficulty_reviews.size.to_f)*100.0).round)/100.0
  end
  
  def community_tree_interference
    tree_interference_reviews = recent_unique_reviews.map(&:tree_interference).compact
    (((tree_interference_reviews.sum / tree_interference_reviews.size.to_f)*100.0).round)/100.0
  end
end
