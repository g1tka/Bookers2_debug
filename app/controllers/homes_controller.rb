class HomesController < ApplicationController
  def top
  end
  
  def about
  end
  
  def guest_sign_in
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      # ゲストユーザー作製に必要な情報↓name,pw
      user.password = SecureRandom.urlsafe_base64
      user.name = "guest"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
end
