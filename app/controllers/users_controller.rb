class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @game_count = Ownership.where(user_id: @user.id).all.count
    @console_count = ConsoleOwnership.where(user_id: @user.id).all.count
    @accessory_count = AccessoriesOwnership.where(user_id: @user.id).all.count
  end

  def new
    @user = User.new
  end

  def signIn
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to OOUG!"
      redirect_to @user
    else
      render 'new'
    end
  end

private 

  def user_params
    params.require(:user).permit(:alias, :email, :password, :password_confirmation)
  end

end
