class GenomesController < ApplicationController
	def new
    if current_user.doctor == true
		  @genome = Genome.new(user_id: current_user.id)
    else
      @genome = Genome.new(user_id: current_user.id, first_name: current_user.first_name, last_name: current_user.last_name, username: current_user.username)
	  end
  end

	def create
		@genome = Genome.new(genome_params)
    text_file = params[:genome][:file_url].read
    parse(text_file)
    respond_to do |format|
      if @genome.save
        format.html {redirect_to '/user/profile', notice: "Genome was successfully uploaded." }
      else
        format.html {render :new}
      end
    end
	end

  def parse(file)
      report = Report.create(genome_id: @genome.id)
      file.each_line do |line|
        snp = line.scan(/(^rs\d+|^i\d+)/)
        allele = line.scan(/\s([A,T,G,C]{2})(\s|\z)/)
        if snp != "" && allele != ""
          snp = snp.join.strip
          allele = allele.join.strip
          $redis.hset(current_user.username, snp, allele)
        end
      end

      Marker.all.each do |marker|
        if $redis.hget(current_user.username, marker.snp) == marker.allele
          Risk.create(report_id: report.id, marker_id: marker.id)
        end
      end
      $redis.del(current_user.username)
    end

	private
	def genome_params
    params.require(:genome).permit(:user_id, :file_url, :first_name, :last_name, :username)
  end
end
