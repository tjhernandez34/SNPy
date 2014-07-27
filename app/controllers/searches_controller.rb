class SearchesController < ApplicationController
# @searches = current_user.searches.all

	def search
		search = params[:search].titleize!
		@risks = current_user.genomes.last.reports.last.risks
		@results = []	
		Category.where('name LIKE ?', "%#{search}%").each do |result|
			@results << result
		end
		Disease.where('name LIKE ?', "%#{search}%").each do |result|
			@results << result
		end
		@results
		redirect_to '/user/profile'
	end
end