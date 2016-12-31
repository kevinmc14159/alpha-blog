class UsersController < ApplicationController

  # Call helper on actions that work with a specific user in database
  before_action :set_user, only: [:edit, :update, :show]

  # Protect users from being edited by others
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # Only admins can delete other users
  before_action :require_admin, only: [:destroy]

  def index
    # Show only 5 users at a time
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Sign up successful
    if @user.save
      # Immediately sign user in
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog, #{@user.username}"
      redirect_to user_path(@user)
    # Sign up unsuccessful
    else
      render 'new'
    end
  end

  def edit
  end

  # Attempt to update user data with new params
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    # Grab all user articles in paginated form
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # Method for admins to delete users
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end

  private
    # Whitelist username, email, and password parameters
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Helper to grant privileges to account owners
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end

    # Restrict admin capabilities
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end

end
