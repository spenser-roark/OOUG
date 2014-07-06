class AccessoriesController < ApplicationController
  before_action :signed_in_user, only: [:new, :edit, :update]

  def index
    @console = ConsoleGeneral.order("eng_name").uniq.pluck(:eng_name)
  end

  def show
    @accessory = Accessories.find(params[:id])
  end

  def new
    @accessory = Accessories.new
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|console| [console.eng_name, console.console_id]}
    @console_array.insert(0, "")
  end

  def edit
    @accessory = Accessories.find(params[:id])
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|console| [console.eng_name, console.console_id]}
    @console_array.insert(0, "")
    
  end

  def update
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|console| [console.eng_name, console.console_id]}
    @console_array.insert(0, "")

    @accessory = Accessories.find(params[:id])
    if @accessory.update_attributes(accessory_params)
      redirect_to @accessory
    else
      # flash.now[:error] = "Some fields were left blank"
      render "edit"
    end    

  end
  
  def create
    @region_array = Region.all.map {|region| [region.region_title, region.region_id]}
    @region_array.insert(0, "")

    @console_array = ConsoleGeneral.all.map {|console| [console.eng_name, console.console_id]}
    @console_array.insert(0, "")

    @accessory = Accessories.new(accessory_params)
    if @accessory.save
      redirect_to @accessory
    else
      # flash.now[:error] = "Some fields were left blank"
      render "new"
    end    
  end

  def destroy
    Accessories.delete(params[:id])
    AccessoriesOwnership.where(accessories_id: params[:id]).destroy_all
    redirect_to browse_accessories_path
  end

  private
  
  def accessory_params
    params.require(:accessories).permit(:accessories_ean, :eng_title, :jap_title, :console_general_id, :region_id)
  end

 # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signIn_url, notice: "Please sign in."
      end
    end
end
