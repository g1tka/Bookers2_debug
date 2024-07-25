class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    @books = Book.all
    
    current_user.view_counts.create(book_id: @book.id)
  end

  def index
#    @books = Book.all
    @book = Book.new
    @user = current_user
    @book_comment = BookComment.new
    
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort_by {|x| x.favorites.where(created_at: from...to).size}.reverse
   
    # @books = Book.includes(:favorited_users).
    #   sort_by {|x|
    #     x.favorited_users.includes(:favorites).where(created_at: from...to).size
    #   }.reverse
      # sort {|a,b|
      #   a.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
      #   b.favorited_users.includes(:favorotes).where(created_at: from...to).size
      # }.reverse
    current_user.view_counts.create(book_id: @book.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
      # @book = Book.find(params[:id])
    
  end

  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
end
