class SearchController < ApplicationController

  def index
    @search = params[:search]
    wildcard_search = "%#{@search}%"
    
    @results = Games.where("eng_title like :search or ean like :search", search: wildcard_search).all
    
    @count = @results.count;
  end

end
