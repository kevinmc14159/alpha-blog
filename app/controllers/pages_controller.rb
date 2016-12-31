class PagesController < ApplicationController

  def home
    # Disable home page for logged in users
    redirect_to articles_path if logged_in?
  end

  def about
  end
  
end
