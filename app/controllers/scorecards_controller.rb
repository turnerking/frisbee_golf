class ScorecardsController < ApplicationController
  def create
    Scorecard.create(params[:scorecard])
    redirect_to "/"
  end
end