class DiseasesController < ApplicationController

  def index
    @diseases = Disease.where('category_id = ?', params[:category_id])
  end

  def show
    @risks = current_user.genomes.last.reports.last.risks
    @disease = Disease.find(params[:id])
  end

  def barchart
    @disease = Disease.find(params[:id])
    @risks = current_user.current_risks_by_disease["#{@disease.name}"]
    data = []
    @risks.each_with_index do |risk, index|
      if risk.marker.risk_level > 0
        data << [{x: 0, y: risk.marker.risk_level, y0: 0}]
        # data[index] << {x: 1, y: 0, y0: 0}
      else

        data << [{x: "Negative", y: risk.marker.risk_level, y0: 0}]
      end
    end

    render json: data
  end
end
