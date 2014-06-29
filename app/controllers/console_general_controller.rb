class ConsoleGeneralController < ApplicationController

  def show
    @console = ConsoleGeneral.find(params[:id])
  end

  def new
    @console = ConsoleGeneral.new
  end

  def index
    @console = ConsoleGeneral.all
  end

  def edit
    @console = ConsoleGeneral.find(params[:id])
  end

  def update
    @console = ConsoleGeneral.find(params[:id])
    if @console.update_attributes(console_params)
      redirect_to @console
    else
      # flash.now[:error] = "Some fields were left blank"
      render "edit"
    end    

  end
  
  def create
    @console = ConsoleGeneral.new(console_params)    
    if @console.save
      redirect_to @console
    else
      # flash.now[:error] = "Some fields were left blank"
      render "new"
    end    
  end

  def destroy
    ConsoleGeneral.delete(params[:id])
    redirect_to console_general_index_path
  end

  private
  def console_params
    params.require(:console_general).permit(:eng_name, :jap_name)
  end

  def delete_params
    params.require(:console_general).permit(:id, :ean, :eng_title, :jap_title, :system, :region, :image)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end


end
