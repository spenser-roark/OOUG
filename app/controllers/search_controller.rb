class SearchController < ApplicationController

  def index
    @search = params[:search]
    wildcard_search = "%#{@search}%"
    
    @results1 = Games.where("eng_title like :search or ean like :search", search: wildcard_search).all
    @results2 = Accessories.where("eng_title like :search or accessories_ean like :search", search: wildcard_search).all

    @count1 = @results1.count
    @count2 = @results2.count
  end

end
