module ChallengeHelper
  def show_golf_score(score, par)
    versus_par = score - par
    versus_par < 0 ? versus_par.to_s : "+#{versus_par}"
  end
end