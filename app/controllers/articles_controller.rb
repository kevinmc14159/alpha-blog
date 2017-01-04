class ArticlesController < ApplicationController

  # Call helper on actions that work with a specific article in database
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  # New, edit, create, update, & destroy actions need a user to call them
  before_action :require_user, except: [:index, :show]

  # Actions only owners of articles can call
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # Grab 5 articles in database at a time
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    # Instance variable for new Article
    @article = Article.new
  end

  def edit
  end

  def create
    # New instance variable with title, description, and categories
    @article = Article.new(article_params)

    # Assign owner of article
    @article.user = current_user

    # Validation passed
    if @article.save
      # Flash green
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    # Validation failed
    else
      render 'new'
    end
  end

  def update
    # Validation passed
    if @article.update(article_params)
      # Flash green
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    # Validation failed
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    # Find and delete article
    @article.destroy

    # Notify user (flash red) and redirect to listing
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private 
  # Helper that creates instance variable and sets to specific article
  def set_article
    @article = Article.find(params[:id])
  end

  # Whitelist title, description, and categories parameters
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  # Protect articles from users other than creator and admin
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
    
end
