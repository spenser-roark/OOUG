class UsersController < ApplicationController
  # before_action :signed_in_user, only: [:edit, :update, :show]
  # before_action :correct_user,   only: [:edit, :update, :show]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

private 

  def user_params
    params.require(:user).permit(:alias, :email, :password, :password_confirmation)
  end

 # Before filters

    def signed_in_user
      redirect_to signIn_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user, notice: "There is no " + current_user.alias + " only Zool."  unless current_user?(@user)
    end

end
