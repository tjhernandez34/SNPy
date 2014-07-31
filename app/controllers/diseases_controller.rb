class DiseasesController < ApplicationController

  def index
    @diseases = Disease.where('category_id = ?', params[:category_id])
  end

  def show
    @risks = current_user.genomes.last.reports.last.risks
    @disease = Disease.find(params[:id])
  end

end
