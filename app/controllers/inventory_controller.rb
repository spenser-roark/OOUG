class InventoryController < ApplicationController
  before_action :signed_in_user, only: [:edit, :show, :update, :games]

  before_action :correct_user, only: [:edit, :update, :show, :games]

  ##
  # This is the games controller
  ##
  def games
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    # defaultParams.merge(params) Will keep defaults and new ones will overwrite dup keys

    if (!params[:order])
      params[:order] = ""
    end

    games = getInventoryFromSelector(Ownership, :games)

    if (params.has_key?(:console_id))
      @ownership = games.where(:console_general => {:eng_name => params[:console_id]})

    else # Make some config or user set results per page
      @ownership = games.all

    end
    @image = Image.all
    @gameConsoles = Ownership.where(user_id: @user).joins(:games => :console_general).order("eng_name").uniq.pluck(:eng_name)

  end

  def consoles
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    consoles = getInventoryFromSelector(ConsoleOwnership, :consoles)

    if (params.has_key?(:console_id))
      @ownership = consoles.where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = consoles.all

    end
    @image = Image.all

@consoleConsoles = ConsoleOwnership.where(user_id: @user).joins(:consoles => :console_general).order("eng_name").uniq.pluck("console_general.eng_name")
  end

  def accessories
    @remember_token = User.hash_token(cookies[:remember_token])
    @user = User.find_by(remember_token: @remember_token)

    if (!params[:order])
      params[:order] = ""
    end

    accessories = getInventoryFromSelector(AccessoriesOwnership, :accessories)

    if (params.has_key?(:console_id))
      @ownership = accessories.where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = accessories.all

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
