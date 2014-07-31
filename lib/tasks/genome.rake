desc "generate risk genome"
task :generate_genome => :environment do

	def generate_genome(file)
		File.open(file, 'w') do |line|
			Marker.all.each do |marker|
				line << "#{marker.snp}        #{marker.allele}" + "\n"
			end
		end
	end


	generate_genome('TESTUSER284_FILE961_YEAROFBIRTH_1961_SEX_XY.23andme.txt')

end