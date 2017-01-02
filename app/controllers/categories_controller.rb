class CategoriesController < ApplicationController

  # Call helper on actions that work with a specific category in database
  before_action :set_category, only: [:edit, :update, :show]

  # Limit category privileges to admins
  before_action :require_admin, except: [:index, :show]

  def index
    # Grab 5 categories in database at a time
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    # Instance variable for new Category
    @category = Category.new
  end

  def create
    # New instance variable with name
    @category = Category.new(category_params)
    # Category created
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    # Errors while creating category
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    # Validation passed
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    # Validation failed
    else
      render 'edit'
    end
  end

  def show
    # Display 5 categories at a time
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private
  # Whitelist name param
  def category_params
    params.require(:category).permit(:name)
  end

  # Helper that creates instance variable and sets to specific category
  def set_category
    @category = Category.find(params[:id])
  end

  # Method to restrict certain category actions to admins
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end

end
