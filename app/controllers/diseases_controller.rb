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
    data = [[],[]]
    @risks.each_with_index do |risk, index|

      if risk.marker.risk_level > 0
        data[0] << {value: risk.marker.risk_level, name: risk.marker.allele, group: "Negative"}
      else
        data[1] << {value: risk.marker.risk_level.abs, name: risk.marker.allele, group: "Positve"}
      end
    end
    render json: data
  end

  def sortedbarchart
    @risks = current_user.current_risks.delete_if{|risk| risk.marker.risk_level < 0 }

  end
end
