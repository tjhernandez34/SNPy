require 'open-uri'
# require 'open-uri-s3'

class GenomesController < ApplicationController
	def new
      genome = Genome.new(user_id: current_user.id, first_name: current_user.first_name, last_name: current_user.last_name, username: current_user.username)
      @uploader = genome.file_url
      # GenomeUploader.cache_stored_file!

      @uploader.success_action_redirect = new_callback_genomes_url #set later
  end

  def new_callback
    genome = Genome.new(user_id: current_user.id, first_name: current_user.first_name, last_name: current_user.last_name, username: current_user.username)
    genome.file_url.key = params[:key]

    genome.save
    report = Report.create(genome_id: genome.id)

    parse(genome.file_url, report)
    # however you want to handle this.
    
  end

	def create
		# @genome = Genome.last
  #   text_file = @genome[:file_url].read
    respond_to do |format|
      if @genome.save
        # @report = Report.create(genome_id: @genome.id)
        # parse(text_file, @report)
        format.html {redirect_to '/user/profile', notice: "Genome was successfully uploaded." }
      else
        format.html {render :new}
      end
    end
  end

   def download 
    data = open("s3.amazonaws.com/#{params[:bucket]}/#{params[:key]}") 
    send_data data.read, :filename => "#{params[:key]}", :disposition => 'attachment', :stream => 'true', :buffer_size => '4096' 
    # :type => "application/text",
  end

  def parse(file, report)
      # @file = Nokogiri::HTML(open(file))
      # report = current_user.reports.last
      # @file = Net::HTTP.get_response(URI.parse(file))
      # file = GenomeUploader.cached?
      puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      puts params[:bucket]
      puts params[:key] 

      puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      data = open("https://s3.amazonaws.com/#{params[:bucket]}/#{params[:key]}") 
      puts "--------------------------------------------------"
      data.read.each_line do |line|
        puts "x"
        snp = line.scan(/(^rs\d+|^i\d+)/)
        allele = line.scan(/\s([A,T,G,C]{2})(\s|\z)/)
        if snp != "" && allele != ""
          puts "y"
          snp = snp.join.strip
          allele = allele.join.strip
          $redis.hset(current_user.username, snp, allele)
        end

      end

      Marker.all.each do |marker|
        if $redis.hget(current_user.username, marker.snp) == marker.allele
          puts "z"
          Risk.create(report_id: report.id, marker_id: marker.id)
        end
      end
      $redis.del(current_user.username)
      redirect_to '/user/profile'
    end

	private
	def genome_params
    params.require(:genome).permit(:user_id, :file_url, :first_name, :last_name, :username)
  end
end
