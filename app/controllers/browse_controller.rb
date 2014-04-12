class BrowseController < ApplicationController

  def index
    @console = Games.joins(:console_general).order("eng_name").uniq.pluck(:eng_name)
  end

  def show
    
  end

end
