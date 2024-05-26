class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    if request.path == "/books"
      redirect_to books_path
    else
      redirect_to book_path(book)
    end
#    if request.path.match?("/books/[0-9]+")正規表現
      # redirect_to book_path(book)
#    elsif request.path.match?("/books")
      # redirect_to books_path
    # end
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to book_path(book)
  end
  
end
