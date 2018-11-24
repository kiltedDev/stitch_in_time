class UsersController < ApplicationController
  before_action :set_user,   only: [:edit, :update]

  def index
  end

  def show
    @user = current_user
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      if user_params[:username].length <4
        flash.now[:error] = "Invalid username: too short"
      elsif user_params[:username].length >50
        flash.now[:error] = "Invalid username: too long"
      else
        flash.now[:error] = "Invalid username"
      end

      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
