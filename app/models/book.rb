class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @book = Book.where("title LIKE?", "#{word}")
  #   elsif search == "forward_match"
  #     @book = Book.where("title LIKE?", "#{word}%")
  #   elsif search == "backward_match"
  #     @book = Book.where("title LIKE?", "%#{word}")
  #   elsif search == "partial_match"
  #     @book = Book.where("title LIKE?", "%#{word}%")
  #   else
  #     @book = Book.all
  #   end
  # end
  def self.search_for(word, method)
    if method == 'perfect'
      Book.where(title: word)
    elsif method == 'forward'
      Book.where('title LIKE ?', word+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+word)
    else
      Book.where('title LIKE ?', '%'+word+'%')
    end
  end
  
  
end
