# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_not_authenticated, only: [:new, :create, :update, ]
  skip_before_action :require_no_authentication, only: [:new, :create, :update]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only: [:edit, :update]

  # # GET /resource/edit
  # def edit
  #   super
  # end

  # # PUT /resource
  # def update
  #   if @user.update(user_params)
  #     redirect_to users_path, notice: 'Usuario actualizado correctamente.'
  #   else
  #     render :edit
  #   end
  # end  

  private

  def redirect_if_not_authenticated
    unless user_signed_in?
      redirect_to root_path, alert: 'Debes iniciar sesión para registrarte.'
    end
  end
  
  # def set_user
  #   puts "User ID: #{params[:id]}"  
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.require(:user).permit(:alias, :role_id, :entry_date, :tel, :email)
  # end
  

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:alias, :role_id, :entry_date, :tel])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:alias, :role_id, :entry_date, :tel])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
