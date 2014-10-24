class ConsolesController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update]

  def index
    @console = ConsoleGeneral.order("eng_name").uniq.pluck(:eng_name)
  end

  def show
    @console = Consoles.find(params[:id])
  end

  def new
    @console = Consoles.new
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.order("eng_name").map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")
  end

  def edit
    @console = Consoles.find(params[:id])
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.order("eng_name").map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")
    
  end

  def update
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.order("eng_name").map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")

    @console = Consoles.find(params[:id])
    if @console.update_attributes(console_params)
      redirect_to @console
    else
      # flash.now[:error] = "Some fields were left blank"
      render "edit"
    end    

  end
  
  def create
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.order("eng_name").map {|consoles| [consoles.eng_name, consoles.console_id]}
    @console_array.insert(0, "")

    @console = Consoles.new(console_params)
    if @console.save
      redirect_to @console
    else
      # flash.now[:error] = "Some fields were left blank"
      render "new"
    end    
  end

  def destroy
    Consoles.delete(params[:id])
    ConsoleOwnership.where(consoles_id: params[:id]).destroy_all
    redirect_to browse_consoles_path
  end

  private
  
  def console_params
    params.require(:consoles).permit(:console_ean, :eng_name, :jap_name, :console_general_id, :region_id)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end

end
