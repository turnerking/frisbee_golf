class UsersController < ApplicationController 

  def index
    @users = User.find(:all, :conditions => ["login LIKE ? OR name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%"])
  end

  def new
    #redirect_to user_path(current_user) and return if current_user
    @user = User.new
  end
 
  def create
    #redirect_to user_path(current_user) and return if current_user
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    unless current_user && (current_user == @user || @user.friends_with?(current_user))
      flash[:error] = "You don't have access to this page"
      redirect_to "/" and return
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless current_user && (current_user == @user)
      flash[:error] = "You don't have access to this page"
      redirect_to "/" and return
    end
  end
  
  def update
    @user = User.find(params[:id])
    unless current_user && (current_user == @user)
      flash[:error] = "You don't have access to this page"
      redirect_to "/" and return
    end
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      render :template => "users/edit"
    end
  end
end
