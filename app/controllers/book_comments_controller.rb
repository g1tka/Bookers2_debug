class BookCommentsController < ApplicationController

    def create
      @book = Book.find(params[:book_id])
      @book_comment = current_user.book_comments.new(book_comment_params)
      # comment = BookComment.new(book_comment_params)
      # comment.user_id = current_user.id この二つを↑一文で表せる。
      @book_comment.book_id = @book.id

      if @book_comment.save
        redirect_to book_path(@book)
      else
        
        @book_new = Book.new
        @user = @book.user
        
        render 'books/show', id: @book.id
        # redirect_to book_path(book, anchor: 'comment_form')
        # flash[:notice] = '!注意：空のコメントはできません！'
        # redirect_to book_path(book)
      end
    end

    def destroy
      BookComment.find(params[:id]).destroy
      redirect_to book_path(params[:book_id])
    end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(user_id: current_user.id, book_id: params[:book_id])
  end

end
