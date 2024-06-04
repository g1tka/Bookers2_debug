class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    
    # ここからユーザー同士のDMルーム機能について。
    @currentUserEntry = Entry.where(user_id: current_user.id)    #roomがcreateされたら現在のユーザーと
    @userEntry = Entry.where(user_id: @user.id)                  #「チャットへボタンを押された」ユーザー両方をEntriesテーブルに記録する。
    unless @user.id == current_user.id                  # ログインしているユーザーではないこと
      @currentUserEntry.each do |cu|                    
        @userEntry.each do |u|                          # 
          if cu.room_id == u.room_id then               # true:すでにroomが作成されているならば、使いたい
            @isRoom = true                              # Entireテーブル内にあるroom_idが共通のユーザーに対して
            @roomID = cu.room_id                        # ←この変数を指定。
          end
        end
      end
      unless @isRoom                                    # false:あたらしくroom作成して、使いたい
        @room = Room.new
        @entry = Entry.new                                # Entryテーブルを作成、記録。
      end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
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