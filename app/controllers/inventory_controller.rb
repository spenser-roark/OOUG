class InventoryController < ApplicationController
  def home
    @games = Games.all
    @test = params[:console] 
  end

  def inventory

    @user = User.all

  end

  def viewYourItems
  @remember_token = User.hash_token(cookies[:remember_token])
  @user = User.find_by(remember_token: @remember_token)

    if (params.has_key?(:console_id))
      @ownership = Ownership.where(user_id: @user).joins(:games => :console_general).where(:console_general => {:eng_name => params[:console_id]})

    else
      @ownership = Ownership.where(user_id: @user).all

    end
    
    @image = Image.all
    # console_id
    # @image = Image.where(user_id: 1)
  end

  def test
    @user = User.find_by(params[:id])
    @ownership = Ownership.where(user_id: 1).all
    @image = Image.all
  end

end
