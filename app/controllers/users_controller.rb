class UsersController < ApplicationController
  before_action :logged_in_user, :load_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :address, :birthday,
      :gender, :password, :password_confirmation
  end

  def load_user
    return @user if @user = User.find_by(id: params[:id])
    flash[:danger] = t "misc.user_not_exists"
    redirect_to root_path
  end
end
