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
    report.delay.parse(report, params[:bucket], params[:key])
    redirect_to '/user/profile'
  end

  # def parse(report)
  #     puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  #     puts params[:bucket]
  #     puts params[:key] 

  #     puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  #     data = open("https://s3.amazonaws.com/#{params[:bucket]}/#{params[:key]}") 
  #     puts "--------------------------------------------------"
  #     data.read.each_line do |line|
  #       puts "x"
  #       snp = line.scan(/(^rs\d+|^i\d+)/)
  #       allele = line.scan(/\s([A,T,G,C]{2})(\s|\z)/)
  #       if snp != "" && allele != ""
  #         puts "y"
  #         snp = snp.join.strip
  #         allele = allele.join.strip
  #         $redis.hset(current_user.username, snp, allele)
  #       end

  #     end

  #     Marker.all.each do |marker|
  #       if $redis.hget(current_user.username, marker.snp) == marker.allele
  #         puts "z"
  #         Risk.create(report_id: report.id, marker_id: marker.id)
  #       end
  #     end
  #     $redis.del(current_user.username)
      
  #   end

	private
	def genome_params
    params.require(:genome).permit(:user_id, :file_url, :first_name, :last_name, :username)
  end
end
