class ArticlesController < ApplicationController

  def new
    @article = Article.new
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

  def show
    @article = Article.find(params[:id])
  end

  private 
    def article_params
      params.require(:article).permit(:title, :description)
    end

end