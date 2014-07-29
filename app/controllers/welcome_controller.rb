class WelcomeController < ApplicationController
	skip_before_action :require_login

	def index
	end

	def sunburst
		risks_by_disease = current_user.current_risks.group_by{|risk| risk.disease.name }
		# puts risks_by_disease
		# puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		risks = current_user.current_risks_by_category
		diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
		data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
		json_hash = {name: "Johnny", children: [], tag: "base"}

			Category.all.each_with_index do |category, category_index|
				json_hash[:children] << {name: category.name, children:[], tag: "category"}

				category.diseases.each_with_index do |disease, disease_index|
					json_hash[:children][category_index][:children] << {name: disease.name, children:[], tag: "disease"}

						if risks_by_disease[disease.name] != nil
							risks_by_disease[disease.name].each_with_index do |risk|
								json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.allele, size: risk.marker.risk_level.abs, tag: "risk"}
							end
						end


				end
			end


		# puts '---------------------------------------------'
		# puts json_hash
		# puts '--------------------------------------------------------------'
		# puts json_hash[:children]
		render json: json_hash

	end

	def testing
		@risks = current_user.current_risks
		json_hash = { "links" => [], "nodes"=> []}
		@risks.each do |risk|
			if json_hash["nodes"].index({"name"=> risk.marker.snp}) == nil
				json_hash["nodes"] << {"name"=> risk.marker.snp}
			end
		end
		# json_hash["nodes"].uniq!
		@risks.each_with_index do |risk, index|
			json_hash["links"] << {"source"=> json_hash["nodes"].index({"name"=> risk.marker.snp}) , "target" => index}
		end
		puts "====================f==================================="
		puts json_hash
		render json: json_hash
	end

	def dna
		respond_to do |format|
    	format.json { render "welcome/flare.json" }
  	end
	end
end
