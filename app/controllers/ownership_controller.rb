class OwnershipController < ApplicationController

  def show
    @game = Ownership.find_by(id: params[:id])
    # @box_condition = Ownership.where(id: params[:id]).joins(:quality)
  end

  def new
    @ownership = Ownership.new
  end
  
  def create
    @ownership = Ownership.new(game_params)    
    if @ownership.save
      redirect_to @ownership
    else
    end    
  end

def edit
end

  private
  def ownership_params
    # params.require(:games).permit(:ean, :eng_title, :jap_title, :system, :region, :image)
  end

end
