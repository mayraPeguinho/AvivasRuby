# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_not_authenticated, only: [ :new, :create, :update ]
  skip_before_action :require_no_authentication, only: [ :new, :create, :update ]
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  def create
    build_resource(sign_up_params)

    if check_role_permission
      return
    end

    if resource.save
      redirect_to users_path, notice: "Nuevo usuario agregado."
    else
      clean_up_passwords(resource)
      set_minimum_password_length
      render :new
      nil
    end
  end


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
      redirect_to root_path, alert: "Debes iniciar sesión para registrarte."
    end
  end

  def check_role_permission
    if current_user.role_id == 2 && params[:user][:role_id] == "1"
      resource.errors.add(:role_id, "No puedes crear usuarios con rol de administrador.")
      clean_up_passwords(resource)
      set_minimum_password_length
      render :new
      return true
    end
    false
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :alias, :role_id, :entry_date, :tel ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :alias, :role_id, :entry_date, :tel ])
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
