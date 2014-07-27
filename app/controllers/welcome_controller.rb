class WelcomeController < ApplicationController
	skip_before_action :require_login

	def testing

	end

	def chart

		risks = current_user.current_risks_by_category
		diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
		data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
		json_hash = {name: "Johnny", children: []}

			Category.all.each do |category|
				json_hash[:children] << {name: category.name, children: []}
				json_hash[:children]
			end


		puts '---------------------------------------------'
		puts json_hash
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
