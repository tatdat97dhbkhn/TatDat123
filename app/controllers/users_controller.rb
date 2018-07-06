class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    redirect_to(root_url) && return unless @user
  end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".delete"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit User::USER_ATTRS
  end

  def logged_in_user
    return false if logged_in?
    store_location
    flash[:danger] = t ".login"
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
  end
end
