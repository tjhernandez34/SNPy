class WelcomeController < ApplicationController
	skip_before_action :require_login


  def testing

  end

  def sunburst
    risks_by_disease = current_user.current_risks.group_by{|risk| risk.disease.name }
    # puts risks_by_disease
    # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    risks = current_user.current_risks_by_category
    diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
    data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
    json_hash = {name: current_user.first_name, children: []}

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

    # puts '---------------------------------------------'
    # puts json_hash
    # puts '--------------------------------------------------------------'

    render json: json_hash

    # puts json_hash[:children]

  end

end
