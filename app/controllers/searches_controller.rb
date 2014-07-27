class SearchesController < ApplicationController
# @searches = current_user.searches.all

CHANGES = { "Heart" => "Cardiovascular Myocardial Atrial Atherosclerosis",
						"Brain" => "Brain Intracranial",
						"Lung" => "Lung Sarcoidosis",
						"Drinking" => "Alcoholism",
						"Marijuana" => "Cannabis",
						"Weed" => "Cannabis",
						"Pot" => "Cannabis",
						"Tobacco" => "Nicotine",
						"Chew" => "Nicotine",
  					"OCD" => "Obsessive Compulsive Disorder",
 						"ADHD" => "Adhd Hyperactivity",
						"Gehrig's" => "Als",
						"Ovary" => "Ovarian",
						"Pancreas" => "Pancreatic",
						"Ass" => "Colorectal",
						"Nervous" => "Tayâsachs Anxiety Brain Multiple Sclerosis Sciatica",
						"Skin" => "Porphyria Psoriasis",
						"Iron" => "Haemochromatosis",
						"Blood" => "G6 Blood Gunther Sjögren",
					 	"Digestive" => "Stomach Colitis Crohn's Celiac",
						"Bone" => "Bone Ankylosing",
						"Ear" => "Otitis"}




	def search
		search = params[:search].titleize!.split
		replace_terms(search)
		@risks = current_user.genomes.last.reports.last.risks
		give_risk_names(@risks)
		@results = []	
		search.each do |term|
		Category.where('name LIKE ?', "%#{term}%").each do |result|
			if @risk_names.include?(result.name)
				@results << result
			end
		end
	end
	search.each do |term|
		Disease.where('name LIKE ?', "%#{term}%").each do |result|
			if @risk_names.include?(result.name)
				@results << result
			end
		end
	end
		@results.uniq!
		render :search
	end


	def replace_terms(search)
		CHANGES.each do |key, value|
  		if search.include?(key)
  			value = value.titleize!.split
  			value.each do |term|
  				search.push(term)
  			end
  		end
  		search
  	end
  end

  def give_risk_names(risks)
		@risk_names = []
		risks.each do |risk|
			if risk.marker.disease.name
				@risk_names << risk.marker.disease.name
			elsif risk.marker.disease.category.name
				@risk_names << risk.marker.disease.category.name
			end
			@risk_names.uniq!
		end
	end
end