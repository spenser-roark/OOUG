class RegionController < ApplicationController
  before_action :correct_user, only: [:index, :new, :update, :edit, :create, :destroy]

  def show
    @region = Region.find(params[:id])
  end
  
  def index
    @region = Region.all
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to @region
    else
    end    
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
   @region = Region.find(params[:id])
    if @region.update_attributes(region_params)
      flash[:success] = @region.region_title + " Successfully Updated"
   redirect_to @region
    else
      render 'edit'
    end
  end

  def destroy
    Region.delete(params[:id])
    redirect_to region_index_path
  end

  private
  
  def correct_user
    @user = User.find(1)
    redirect_to root_path unless current_user?(@user)
  end 

  def region_params
    params.require(:region).permit(:region_title, :region_country)
  end

end
