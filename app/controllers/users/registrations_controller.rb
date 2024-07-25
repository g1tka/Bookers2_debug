class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_guest, only: :destroy

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end

end

# <!--ゲストユーザーが削除できないようにした。用意していないが。-->