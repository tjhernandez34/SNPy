desc "add disease descriptions"
task :disease_descriptions => :environment do

	def get_descriptions
  @descriptions = []
    File.open("disease-list.txt", "r") do |file|
      file.each_line do |line|
        @descriptions << line.chomp unless line == "\n"
      end
    end
    @descriptions
	end

  def add_descriptions_to_diseases(descriptions)
  	sorted_diseases = Disease.all.sort
  	line = 0
  	sorted_diseases.each do |disease|
  		disease.update(description: descriptions[line])
  		line += 1
  	end
  end

  get_descriptions
  add_descriptions_to_diseases(@descriptions)
end