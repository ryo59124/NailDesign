class Public::GuestsController < ApplicationController
  def new_guest
    end_user = EndUser.find_or_create_by!(name: 'Guest', email: 'guest@guest.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
    # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in end_user
    redirect_to nails_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
