require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :first_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :first_name,     :maximum => 100
  
  validates_format_of       :last_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :last_name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  has_many :scorecards
  has_many :reviews
  has_and_belongs_to_many :challenges, :join_table => "challengers"
  has_many :organized_challenges, :class_name => "Challenge", :foreign_key => :organizer_id
  has_and_belongs_to_many :friendships, :conditions => "approved_at IS NOT NULL"
  has_many :unapproved_friendships, :class_name => "Friendship", :foreign_key => :requester_id, :conditions => "approved_at IS NULL"
  has_many :friendships_to_approve, :class_name => "Friendship", :foreign_key => :approver_id, :conditions => "approved_at IS NULL"

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :first_name, :last_name, :password, :password_confirmation, :gender, :birth_date, :age, :state

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def friends
    self.friendships.collect do |f|
      f.users - Array.new(1, self)
    end.flatten
  end
  
  def friends_ids
    self.friendships.collect do |f|
      f.user_ids - Array.new(1, self.id)
    end.flatten
  end
  
  def friends_with?(user)
    friends.include?(user)
  end

  def best_scores_for_friends(play_from, play_to, course_id, number_to_return = 1)
    return [] if friends_ids.empty?
    
    where_statement = "played_at > ? AND played_at < ? AND course_id = ? AND user_id IN (#{friends_ids.join(",")})"
    conditions = [where_statement, play_from, play_to, course_id]
    
    all_scorecards = Scorecard.find(:all, :conditions => conditions)
    sorted_scorecards(all_scorecards)[0, number_to_return]
  end
  
  def best_scores_for(play_from, play_to, course_id, number_to_return = 1)
    all_scorecards = self.scorecards.find(:all, :conditions => ["played_at > ? AND played_at < ? AND course_id = ?", play_from, play_to, course_id])
    sorted_scorecards(all_scorecards)[0, number_to_return]
  end
  
  def best_score_for(play_from, play_to, course_id, number_to_return = 1)
    best_scores_for(play_from, play_to, course_id, number_to_return).first
  end
  
  def age
    return nil unless birth_date
    ((Time.now - birth_date.at_beginning_of_day)/(60*60*24*365)).floor
  end
  
  def age=(number)
    write_attribute(:birth_date, Time.now.years_ago(number.to_i))
  end
  
  def name
    return "" if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}"
  end

  private
  
  def sorted_scorecards(scorecards)
    return [] if scorecards.empty?
    scorecards.sort {|a,b| a.final_score <=> b.final_score}
  end

end
