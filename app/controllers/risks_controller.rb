class RisksController < ApplicationController

  def index
    # @risks = Risk.where('disease_id = ?', params[:disease_id])
    @risks = current_user.current_risks
  end
end
