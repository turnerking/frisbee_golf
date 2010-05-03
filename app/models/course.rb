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
    @recent_reviews ||= reviews.find(:all, :conditions => ["created_at > ?", 1.year.ago])
  end
  
  def total_par
    holes.map(&:par).sum
  end
  
  def total_distance
    holes.map(&:distance_in_ft).sum
  end
  
  def course_quality
    course_quality_reviews = recent_unique_reviews.map(&:course_quality).compact
    round_rating_array(course_quality_reviews)
  end
  
  def community_difficulty
    difficulty_reviews = recent_unique_reviews.map(&:difficulty).compact
    round_rating_array(difficulty_reviews)
  end
  
  def community_tree_interference
    tree_interference_reviews = recent_unique_reviews.map(&:tree_interference).compact
    round_rating_array(tree_interference_reviews)
  end
  
  def best_scores_from(play_from, play_to, number_to_return = 1)
    where_statement = "played_at > ? AND played_at < ? AND course_id = ?"
    conditions = [where_statement, play_from, play_to, self.id]
    
    Scorecard.top_scores(:conditions => conditions)[0, number_to_return]
  end
  
  private
  
  def round_rating_array(ratings)
    return "N/A" if ratings.empty?
    (((ratings.sum / ratings.size.to_f)*100.0).round)/100.0
  end
end
