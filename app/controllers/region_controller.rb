class RegionController < ApplicationController

  def show
    @region = Region.find(params[:id])
  end

end
