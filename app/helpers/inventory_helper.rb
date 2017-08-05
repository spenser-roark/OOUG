module InventoryHelper

  def getInventoryFromSelector(database, joinsFilter)
    return database.paginate(:page => params[:page], :per_page => 10).where(user_id: params[:id]).joins(joinsFilter => :console_general).order(params[:order])
  end

end
