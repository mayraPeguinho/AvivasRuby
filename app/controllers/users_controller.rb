class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: %i[ edit update activate deactivate]
  
    def index
      @users = User.all
    end

    def edit
    end
  
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def deactivate
      if @user.update(active: false, password: SecureRandom.hex(10))
        redirect_to users_path, notice: 'Usuario desactivado correctamente y contraseña reseteada.'
      else
        redirect_to users_path, alert: 'No se pudo desactivar el usuario.'
      end
    end

    def activate
      if @user.update(active: true, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        redirect_to users_path, notice: 'Usuario activado correctamente.'
      else
        flash[:alert] = 'No se pudo activar el usuario.'
        render :edit # O la vista que uses para activar
      end
    end

    def destroy
    end

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.expect(user: [ :alias, :email, :phone, :password, :role_id, :entry_date ])
    end
end
