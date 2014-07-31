require 'byebug'

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
            "Digestive" => "Digestive Stomach Colitis Crohn's Celiac Kidney",
            "Bone" => "Bone Ankylosing",
            "Urinary" => "Kidney Bladder",
            "Ear" => "Otitis"}



  def search
    search = params[:search].titleize!.split
    replace_terms(search)
    @risks = current_user.genomes.last.reports.last.risks
    give_risk_names(@risks)
    @results = []
    search.each do |term|
      Disease.where('name LIKE ?', "%#{term}%").each do |result|
        if @risk_names.include?(result.name)
          @results << result
        end
      end
    end
    @results.uniq!
  #   hashify_for_d3(@results)
  # end

  # def hashify_for_d3(results)
  #   @risks = current_user.search_risks
  #   give_risk_names(@risks)
    json_hash = {name: current_user.first_name, children: []}

      Category.all.each_with_index do |category, category_index|
        json_hash[:children] << {name: category.name, children:[]}

        @result_by_category = []

        @results.each do |result|
          if result.category.name == category.name
            @result_by_category << result
          end
        end
        @result_by_category.each_with_index do |disease, disease_index|
          json_hash[:children][category_index][:children] << {name: disease.name, children:[]}


          @risks_by_disease = []

          @risks.each do |risk|
            if risk.marker.disease.name == disease.name
              @risks_by_disease  << risk
            end
          end
          @risks_by_disease.each_with_index do |risk|
            json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.snp, size: 1}
          end
        end
      end

      if !request.xhr?
        puts json_hash
        render json: json_hash, locals: {results: @results}
      else
        @results
      end

  end

  def hashify_for_d3(results)
    @risks = current_user.search_risks
    give_risk_names(@risks)
    json_hash = {name: current_user.first_name, children: []}

      Category.all.each_with_index do |category, category_index|
        json_hash[:children] << {name: category.name, children:[]}

        @result_by_category = []

        results.each do |result|
          if result.category.name == category.name
            @result_by_category << result
          end
        end
        @result_by_category.each_with_index do |disease, disease_index|
          json_hash[:children][category_index][:children] << {name: disease.name, children:[]}


          @risks_by_disease = []

          @risks.each do |risk|
            if risk.marker.disease.name == disease.name
              @risks_by_disease  << risk
            end
          end
          @risks_by_disease.each_with_index do |risk|
            json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.snp, size: 1}
          end
        end
      end

      if !request.xhr?
        puts json_hash
        render json: json_hash, locals: {results: results}
      else
        results
      end
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
      end
      @risk_names.uniq!
    end
  end

  def search_top_diseases_by_risk_level
    search_terms = []
    top_ten_diseases = []
    current_user.order_user_diseases_by_total_risk_level.each do |disease_risk_pair_array|
     search_terms << disease_risk_pair_array[1]
    end
    search_terms.each do |term|
      Disease.where('name = ? LIMIT 10', "#{term}").each do |disease|
          top_ten_diseases << disease
      end
    end
    hashify_for_d3(top_ten_diseases)
  end

  def search_bottom_diseases_by_risk_level
    search_terms = []
    top_ten_diseases = []
    low_risks = current_user.order_user_diseases_by_total_risk_level {|element| element[0].to_i}.reverse
    low_risksJOPDQW.each do |disease_risk_pair_array|
     search_terms << disease_risk_pair_array[1]
    end
    search_terms.each do |term|
      Disease.where('name = ? LIMIT 10', "#{term}").each do |disease|
          top_ten_diseases << disease
      end
    end
    hashify_for_d3(top_ten_diseases)
  end

end
