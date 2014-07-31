class WelcomeController < ApplicationController
	skip_before_action :require_login

  def sunburst
    risks_by_disease = current_user.current_risks.group_by{|risk| risk.disease.name }
    # puts risks_by_disease
    # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    risks = current_user.current_risks_by_category
    diseases = current_user.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
    data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
    json_hash = {name: current_user.first_name, children: []}
    colorGroup = ['#ffdb11','#19258f','#17becf','#694026','#9467bd','#e377c2','#e80c58','#e80c58','#b6272b','#aadc74','#ff7f0e','#96ffcc','#1ba763']

    Category.all.each_with_index do |category, category_index|
      json_hash[:children] << {name: category.name, children:[], group: category_index}

      category.diseases.each_with_index do |disease, disease_index|
        json_hash[:children][category_index][:children] << {name: disease.name, children:[], group: category_index}

        if risks_by_disease[disease.name] != nil
          risks_by_disease[disease.name].each_with_index do |risk|
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
    end

    render json: json_hash

  end

end
