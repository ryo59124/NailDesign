# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
before_action :end_user_state, only: [:create]

   protected

    def after_sign_in_path_for(resource)
      nails_path
    end

    def after_sign_out_path_for(resource)
      new_end_user_session_path
    end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def end_user_state
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
        flash[:notice] = "このアカウントは退会済みです。再度ご登録をお願いいたします。"
        redirect_to new_end_user_registration_path
      else
        flash[:notice] = "もう一度お試しください。"
      end
    end
  end
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
