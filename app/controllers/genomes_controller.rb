require 'open-uri'

class GenomesController < ApplicationController
	def new
      genome = Genome.new(user_id: current_user.id, first_name: current_user.first_name, last_name: current_user.last_name, username: current_user.username)
      @uploader = genome.file_url
      @uploader.success_action_redirect = new_callback_genomes_url #set later
  end

  def new_callback
    genome = Genome.new(user_id: current_user.id, first_name: current_user.first_name, last_name: current_user.last_name, username: current_user.username)
    genome.file_url.key = params[:key]
    genome.save
    report = Report.create(genome_id: genome.id)
    report.delay.parse(params[:bucket], params[:key], current_user)
    redirect_to '/user/profile'
  end

	private
	def genome_params
    params.require(:genome).permit(:user_id, :file_url, :first_name, :last_name, :username)
  end
end
