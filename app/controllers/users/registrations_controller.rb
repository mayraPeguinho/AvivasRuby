# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_not_authenticated, only: [:new, :create, :update]
  before_action :check_permissions, only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:new, :create, :update]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    if check_role_permission
      return
    end

    if resource.save
      redirect_to users_path, notice: "New User."
    else
      clean_up_passwords(resource)
      set_minimum_password_length
      render :new
      nil
    end
  end

  private

  # Redirige si el usuario no ha iniciado sesión
  def redirect_if_not_authenticated
    unless user_signed_in?
      redirect_to root_path, alert: "Debes iniciar sesión para registrarte."
    end
  end

  # Verifica que el usuario tenga permisos adecuados
  def check_permissions
    if current_user.role_id == 3
      redirect_to root_path, alert: "No tienes permiso para acceder a esta sección."
    end
  end

  # Chequea si el usuario tipo 2 intenta crear usuarios con rol 1
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

  # Configura los parámetros adicionales permitidos al registrarse
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:alias, :role_id, :entry_date, :tel])
  end

  # Configura los parámetros adicionales permitidos al actualizar
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:alias, :role_id, :entry_date, :tel])
  end
end