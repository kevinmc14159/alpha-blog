class ArticlesController < ApplicationController

  # Call helper on actions that work with a specific article in database
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    # Grab all articles in database
    @articles = Article.all
  end

  def new
    # Instance variable for new Article
    @article = Article.new
  end

  def edit
  end

  def create
    debugger
    # New instance variable with title and description
    @article = Article.new(article_params)

    # Hardcode user for now
    @article.user = User.first

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

    # Whitelist title and description parameters
    def article_params
      params.require(:article).permit(:title, :description)
    end
    
end
