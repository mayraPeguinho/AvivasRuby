# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :redirect_if_not_authenticated, only: [:new, :create, :update]
  before_action :check_permissions, only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:new, :create, :update]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    # Valida si el recurso (usuario) es válido y lo guarda
    if resource.save
      if resource.active_for_authentication?
        redirect_to users_path, notice: 'User created successfully'
      else
        set_flash_message!(:notice, :inactive_signed_up)
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with resource
    end
  end

  private

  # Redirige si el usuario no ha iniciado sesión
  def redirect_if_not_authenticated
    unless user_signed_in?
      redirect_to root_path, alert: "You must be logged in to complete this action."
    end
  end

  # Verifica que el usuario tenga permisos adecuados
  def check_permissions
    if current_user.role_id == 3
      redirect_to root_path, alert: "You do not have permission to access this section."
    end
  end

  # Chequea si el usuario tipo 2 intenta crear usuarios con rol 1
  def check_role_permission
    if current_user.role_id == 2 && params[:user][:role_id] == "1"
      resource.errors.add(:role_id, "You cannot create users with an administrator role.")
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
  puts "Configurando parámetros de sign_up"
  devise_parameter_sanitizer.permit(:sign_up, keys: [:alias, :role_id, :entry_date, :tel])
  puts "Parámetros permitidos: #{devise_parameter_sanitizer.sanitize(:sign_up).inspect}"
end

  # Configura los parámetros adicionales permitidos al actualizar
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:alias, :role_id, :entry_date, :tel])
  end
end