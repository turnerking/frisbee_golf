class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new(:organizer_id => current_user.id, :course_id => params[:course_id])
  end
  
  def create
    challenge = Challenge.create(params[:challenge])
    redirect_to course_path(challenge.course)
  end
  
  def show
    @challenge = Challenge.find(params[:id])
  end
end