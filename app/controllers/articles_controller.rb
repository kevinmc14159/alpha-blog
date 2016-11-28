class ArticlesController < ApplicationController

  # @article = Article.find(params[:id])
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    # Grab all articles in database
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create

    # New instance variable
    @article = Article.new(article_params)

    # Validation passed
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    # Validation failed
    else
      render 'new'
    end

  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    # Find and delete article
    @article.destroy

    # Notify user and redirect to listing
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end

  private 

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

end