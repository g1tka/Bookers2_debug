class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
#    redirect_back(fallback_location: books_path)
    
    # if request.referrer.present?
    #   redirect_to request.referrer
    # else
    #   redirect_to books_path
    # end
    

    # redirect_to request.referer
    
    # if request.path == "/books"
    #   redirect_to books_path
    # else
    #   redirect_to book_path(book)
    # end
    
    # if request.path.match?("/books/[0-9]+$")
    #   redirect_to book_path(book)
    # elsif request.path.match?("/books")
    #   redirect_to books_path
    # end
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
#     redirect_back(fallback_location: books_path)
    # redirect_to request.referer
  end
  
end
