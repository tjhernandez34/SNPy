class WelcomeController < ApplicationController
	skip_before_action :require_login

	def testing

	end

	def chart
		risks_by_disease = current_user.current_risks.group_by{|risk| risk.disease.name }
		puts risks_by_disease
		puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		risks = current_user.current_risks_by_category
		diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
		data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
		json_hash = {name: "Johnny", children: []}

			Category.all.each_with_index do |category, category_index|
				json_hash[:children] << {name: category.name, children:[]}

				category.diseases.each_with_index do |disease, disease_index|
					json_hash[:children][category_index][:children] << {name: disease.name, children:[]}

						if risks_by_disease[disease.name] != nil
							risks_by_disease[disease.name].each_with_index do |risk|
								json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.allele, size: 1}
							end
						end


				end
			end


		puts '---------------------------------------------'
		puts json_hash
		puts '--------------------------------------------------------------'
		# puts json_hash[:children]
		render json: json_hash

		# puts json_hash
		# render json: {
		# 	name: "johnny",
		# 	children: [
		# 		{
		# 			name: "Category 1",
		# 			children: [
		# 			{name: "johny 1.1", size: 5},{name: "johnny 1.2", size: 2 }]

		# 			},
		# 		{
		# 			name: "Category 2",
		# 			children: [
		# 			{name: "johny 2.1", size: 1},{name: "johnny 3.2", size: 2 }]
		# 			}
		# 	]}

	end

	def index
		respond_to do |format|
    	format.json { render "welcome/flare.json" }
  	end
	end

end
