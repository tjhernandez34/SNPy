class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @diseases = current_user.genomes.last.reports.last.risks.map {|risk| risk.disease }
  end
end
