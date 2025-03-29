# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]
  before_action :block_if_admin_signed_in, only: [:new, :create]

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

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email])
  
    if @customer
      if @customer.valid_password?(params[:customer][:password])
        if @customer.active_for_authentication?
          # 顧客がアクティブな場合はそのままログイン
          # ここでログイン処理を行うなど
        else
          flash[:error] = "退会済みです。再度新規登録をしてご利用ください。"
          redirect_to new_customer_registration_path and return
        end
      else
        flash[:error] = "パスワードが間違っています。"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "該当するユーザーが見つかりません。"
      redirect_to new_customer_session_path
    end
  end

  private

  def block_if_admin_signed_in
    if admin_signed_in?
      flash[:alert] = "管理者としてログイン中は顧客ログインできません。"
      redirect_to admin_root_path
    end
  end
end
