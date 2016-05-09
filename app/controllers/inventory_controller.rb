class InventoryController < ApplicationController
  before_action :signed_in_user, only: [:edit, :show, :update, :games]

  before_action :correct_user,   only: [:edit, :update, :show, :games]

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

  def games
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    if (params.has_key?(:order))
      if (params[:order] != "eng_title" && params[:order] != "")
        params[:order] = ""
      end
    end
    
    if (params.has_key?(:console_id))
      @ownership = Ownership.where(user_id: params[:id]).joins(:games => :console_general).order(params[:order]).where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = Ownership.where(user_id: params[:id]).joins(:games => :console_general).order(params[:order]).all

    end
    @image = Image.all
    @gameConsoles = Ownership.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)

  end

  def consoles
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    if (params.has_key?(:console_id))
      @ownership = ConsoleOwnership.where(user_id: params[:id]).joins(:consoles => :console_general).order("consoles.eng_name").where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = ConsoleOwnership.where(user_id: params[:id]).joins(:consoles => :console_general).order("consoles.eng_name").all

    end
    @image = Image.all

@consoleConsoles = ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general).order("eng_name").uniq.pluck("console_general.eng_name")
  end

  def accessories
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    if (params.has_key?(:order))
      if (params[:order] != "eng_title" && params[:order] != "")
        params[:order] = ""
      end
    end


    if (params.has_key?(:console_id))
      @ownership = AccessoriesOwnership.where(user_id: params[:id]).joins(:accessories => :console_general).order(params[:order]).where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = AccessoriesOwnership.where(user_id: params[:id]).joins(:accessories => :console_general).order(params[:order]).all

    end
    @image = Image.all

    @accessoryConsoles = AccessoriesOwnership.where(user_id: @user).joins(:accessories => :console_general).order("eng_name").uniq.pluck("console_general.eng_name")
  end

  def test
    @user = User.find_by(params[:id])
    @ownership = Ownership.where(user_id: 1).all
    @image = Image.all
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
