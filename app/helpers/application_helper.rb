# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_golf_score(final_score)
    final_score < 0 ? final_score.to_s : "+#{final_score}"
  end
  
  def display_gender(gender)
    gender =~ /^m/i ? "Male" : "Female"
  end
end
