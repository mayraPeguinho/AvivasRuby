class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: %i[edit update activate deactivate]

  def index
    @users = User.order(active: :desc)
  end
  

  def edit
    # Verifica si el usuario está activo antes de permitir la edición
    if @user.active == false
      redirect_to users_path, alert: "You cannot edit an inactive user."
    end
  end

  def update
    # Verifica si el usuario está activo antes de permitir la actualización
    if @user.active == false
      redirect_to users_path, alert: "You cannot update an inactive user."
      return
    end

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
      redirect_to users_path, notice: "User successfully deactivated and password reset."
    else
      redirect_to users_path, alert: "The user could not be deactivated."
    end
  end

  def activate
    if @user.update(active: true, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      redirect_to users_path, notice: "User activated correctly."
    else
      flash[:alert] = "The user could not be activated."
      render :edit
    end
  end

  def destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:alias, :email, :phone, :password, :role_id, :entry_date)
  end
end
