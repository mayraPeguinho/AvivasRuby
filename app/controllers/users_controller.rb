class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: %i[ edit update ]
  
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

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.expect(user: [ :alias, :email, :phone, :password, :role_id, :entryDate ])
    end
end
