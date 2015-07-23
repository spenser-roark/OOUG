class SearchController < ApplicationController

	before_action :empty_search, only: [:index]

	def index
		@search = params[:search]
		wildcard_search = "%#{@search}%"

		@results1 = Games.where("eng_title like :search or ean like :search", search: wildcard_search).all
		@results2 = Accessories.where("eng_title like :search or accessories_ean like :search", search: wildcard_search).all
		@results3 = Consoles.where("eng_name like :search or console_ean like :search", search: wildcard_search).all

		@count1 = @results1.count
		@count2 = @results2.count
		@count3 = @results3.count
	end

	private

	def empty_search
		if params[:search] == ''
			session[:return_to] ||= request.referer
			redirect_to session.delete(:return_to), notice: "Please enter a search query"
		end
	end
end