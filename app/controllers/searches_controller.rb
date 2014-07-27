class SearchesController < ApplicationController
# @searches = current_user.searches.all

	def search
		search = params[:search].titleize!.split
		@risks = current_user.genomes.last.reports.last.risks
		risk_names = []
		@risks.each do |risk|
			if risk.marker.disease.name
				risk_names << risk.marker.disease.name
			elsif risk.marker.disease.category.name
				risk_names << risk.marker.disease.category.name
			end
			risk_names.uniq!
		end
		@results = []	
		search.each do |term|
		Category.where('name LIKE ?', "%#{term}%").each do |result|
			if risk_names.include?(result.name)
				@results << result
			end
		end
	end
	search.each do |term|
		Disease.where('name LIKE ?', "%#{term}%").each do |result|
			if risk_names.include?(result.name)
				@results << result
			end
		end
	end
		@results.uniq!
		render :search
	end
end