module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the new challenge page/
      new_challenge_path

    when /the new friend page/
      new_friend_path

    when /the new review page/
      new_review_path

    when /the new scorecard page/
      new_scorecard_path

    when /the new course page/
      new_admin_course_path
    when /the admin courses page/
      admin_courses_path
    when /^the profile page of (.+)/
      user_path(User.find_by_login($1))
    when /^the edit profile page of (.+)/
      edit_user_path(User.find_by_login($1))
    when /^the edit page for (.+)/
      edit_admin_course_path(Course.find_by_name($1))  
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
