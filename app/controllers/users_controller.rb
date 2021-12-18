class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @two_days_ago_books = @books.created_2days_ago
    @three_days_ago_books = @books.created_3days_ago
    @four_days_ago_books = @books.created_4days_ago
    @five_days_ago_books = @books.created_5days_ago
    @six_days_ago_books = @books.created_6days_ago
  end
  
  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
