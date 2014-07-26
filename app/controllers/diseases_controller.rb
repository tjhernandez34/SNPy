class DiseasesController < ApplicationController

  def index
    @diseases = Disease.where('category_id = ?', params[:category_id])
  end

  def show
    @disease = Disease.find(params[:id])
    @risks = current_user.genomes.last.reports.last.risks
  end
end
