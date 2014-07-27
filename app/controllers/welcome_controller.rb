class WelcomeController < ApplicationController
	skip_before_action :require_login

	def testing

	end

	def chart

		risks = current_user.current_risks_by_category
		diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
		data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
		render json: data

	end

	def index
		respond_to do |format|
    	format.json { render "welcome/flare.json" }
  	end
	end

end
