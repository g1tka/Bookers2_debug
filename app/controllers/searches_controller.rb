class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    @method = params[:method]
    
    if @model == "user"
      @records = User.search_for(@word, @method)
      # @users = User.looks(params[:search], params[:word])
      # render "/searches/search"
    else
      @records = Book.search_for(@word, @method)
      # @books = Book.looks(params[:search], params[:word])
      # render "/searches/search"
    end
  
  
    # respond_to do |format|
    #   format.html # この行が必要です
    # end
    
    # render 'search_for'
  end
end
