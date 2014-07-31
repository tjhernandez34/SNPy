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




  # def search
  #   search = params[:search].titleize!.split
  #   replace_terms(search)
  #   @risks = current_user.genomes.last.reports.last.risks
  #   give_risk_names(@risks)
  #   @results = []
  # search.each do |term|
  #   Disease.where('name LIKE ?', "%#{term}%").each do |result|
  #     if @risk_names.include?(result.name)
  #       @results << result
  #     end
  #   end
  # end
  #   @results.uniq!
  #   @results #below is json
  # end

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



  json_hash = {name: current_user.first_name, children: []}

    Category.all.each_with_index do |category, category_index|
      json_hash[:children] << {name: category.name, children:[], group: category_index}

      @result_by_category = []

      @results.each do |result|
        if result.category.name == category.name
          @result_by_category << result
        end
      end
      @result_by_category.each_with_index do |disease, disease_index|
        json_hash[:children][category_index][:children] << {name: disease.name, children:[], group: category_index}


        @risks_by_disease = []

        @risks.each do |risk|
          if risk.marker.disease.name == disease.name
            @risks_by_disease  << risk
          end
        end
        @risks_by_disease.each_with_index do |risk|
            if risk.marker.risk_level > 0
              group = "Negative"
            else
              group = "Positive"
            end
          json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.snp, size: risk.marker.risk_level.abs,
             group: group}
        end
      end
    end
  puts "----------------------------"
  puts json_hash

    if !request.xhr?
      puts "im in the render json hash section"
      render json: json_hash
    else
      @results
    end

  end

  def hashify_for_d3(results)
    @risks = current_user.search_risks
    give_risk_names(@risks)
    json_hash = {name: current_user.first_name, children: []}

      Category.all.each_with_index do |category, category_index|
        json_hash[:children] << {name: category.name, children:[], group: category_index}

        @result_by_category = []

        results.each do |result|
          if result.category.name == category.name
            @result_by_category << result
          end
        end
        @result_by_category.each_with_index do |disease, disease_index|
          json_hash[:children][category_index][:children] << {name: disease.name, children:[], group: category_index}


          @risks_by_disease = []

          @risks.each do |risk|
            if risk.marker.disease.name == disease.name
              @risks_by_disease  << risk
            end
          end
          @risks_by_disease.each_with_index do |risk|
            if risk.marker.risk_level > 0
              group = "Negative"
            else
              group = "Positive"
            end
            json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.snp, size: risk.marker.risk_level.abs,
             group: group }
          end
        end
      end

      return json_hash
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





end
