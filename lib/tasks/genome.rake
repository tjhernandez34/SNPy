desc "generate risk genome"
task :generate_genome => :environment do

	def unique_markers
		Marker.all.uniq! {|marker| marker.snp}
	end


	def generate_genome(file)
		File.open(file, 'w') do |line|
			unique_markers.each do |marker|
				line << "#{marker.snp}        #{marker.allele}" + "\n"
			end
		end
	end


	generate_genome('TESTUSER284_FILE961_YEAROFBIRTH_1961_SEX_XY.23andme.txt')

end