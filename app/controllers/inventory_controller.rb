class InventoryController < ApplicationController
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

private 
end
