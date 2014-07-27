class DiseasesController < ApplicationController

  # def index
  #   @diseases = Disease.where('category_id = ?', params[:category_id])
  # end

  def show
    @disease = Disease.find(params[:id])
    @results = []
    risks = current_user.genomes.last.reports.last.risks
    risks.each do |risk|
    	if risk.marker.disease.name == @disease.name
    		@results << risk.marker
    	end
    end
    @results
  end
end
