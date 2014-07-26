class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @diseases = []
    current_user.genomes.last.reports.last.risks.map do |risk|
          @diseases << risk.marker.disease.name
    end
    @diseases.uniq
  end
end
