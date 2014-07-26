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
    respond_to do |format|
      if @genome.save
        format.html {redirect_to '/user/profile', notice: "Genome was successfully uploaded." }
      else
        format.html {render :new}
      end
    end
	end

	private
	def genome_params
    params.require(:genome).permit(:user_id, :file_url, :first_name, :last_name, :username)
  end
end