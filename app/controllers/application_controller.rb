class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make methods available to views
  helper_method :current_user, :logged_in?

  # Return current user if it already exists, otherwise find user based on user_id
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Return true if a user is in session, false otherwise
  def logged_in?
    !!current_user
  end

  # Method that allows us to enable certain actions to those logged in
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end
