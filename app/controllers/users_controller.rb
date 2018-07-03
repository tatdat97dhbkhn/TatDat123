class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      # Handle a successful save.
      flash[:success] = t "user.show.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_ATTRS
  end
end
