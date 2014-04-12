class InventoryController < ApplicationController
  before_action :signed_in_user, only: [:edit, :show, :update]
  before_action :correct_user,   only: [:edit, :update, :show]


  def home
    @games = Games.all
    @test = params[:console] 
  end

  def inventory
    @user = User.all
  end

  def show

    if (params.has_key?(:console_id))
      @ownership = Ownership.where(user_id: params[:id]).joins(:games => :console_general).where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = Ownership.where(user_id: params[:id]).all

    end
    
    @image = Image.all
  end

  def test
    @user = User.find_by(params[:id])
    @ownership = Ownership.where(user_id: 1).all
    @image = Image.all
  end

  def index
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    @ownership = Ownership.where(user_id: @user).all
    
    # @image = Image.all
  end


private 

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user, notice: "There is no " + current_user.alias + " only Zool."  unless current_user?(@user)
    end 


end
