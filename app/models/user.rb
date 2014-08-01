 class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :genomes
  has_many :reports, through: :genomes

  attr_reader :current_username

  def current_risks_by_category
    if self.reports.length > 0
      self.current_risks.group_by {|risk| risk.category }
    end
  end

  def search_risks
    self.genomes.last.reports.last.risks
  end


  def current_risks
    self.reports.order(created_at: :desc).first.risks
  end

  def current_risks_by_disease
    self.current_risks.group_by {|risk| risk.disease.name}
  end

  def order_user_diseases_by_total_risk_level
    array_of_disease_sums = []
    self.current_risks_by_disease.each do |disease, risk_array|
      total = 0
        risk_array.each do |risk|
          total += risk.marker.risk_level
        end
        array_of_disease_sums << [total, disease]
    end
    array_of_disease_sums.sort_by {|element| element[0].to_i}.reverse
  end

  def sunburst
    risks_by_disease = self.current_risks.group_by{|risk| risk.disease.name }
    risks = self.current_risks_by_category
    diseases = self.current_risks.group_by{|risk| risk.disease}.keys.group_by{|disease| disease.category}
    data = risks.merge(diseases){|category,risks,diseases| risks.group_by{|risk| risk.disease}}
    json_hash = {name: self.first_name, children: []}
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
            json_hash[:children][category_index][:children][disease_index][:children] << {name: risk.marker.allele, size: risk.marker.risk_level.abs,
             group: group }
          end
        end
      end
    end
    return json_hash
  end


  def search_top_diseases_by_risk_level
    search_terms = []
    top_ten_diseases = []
    self.order_user_diseases_by_total_risk_level.each do |disease_risk_pair_array|
     search_terms << disease_risk_pair_array[1]
    end
    top_diseases = search_terms.slice(0,9).flatten
    top_diseases.each do |term|
          top_ten_diseases << Disease.where('name = ?', "#{term}")
      end
    top_ten_diseases.flatten!
    hashify_for_d3(top_ten_diseases, self)
  end

  def search_bottom_diseases_by_risk_level
    search_terms = []
    bottom_ten_diseases = []
    low_risks = self.order_user_diseases_by_total_risk_level {|element| element[0].to_i}.reverse
    low_risks.each do |disease_risk_pair_array|
     search_terms << disease_risk_pair_array[1]
    end
    bottom_diseases = search_terms.slice(0,9).flatten
    bottom_diseases.each do |term|
          bottom_ten_diseases << Disease.where('name = ?', "#{term}")
      end
    bottom_ten_diseases.flatten!
    hashify_for_d3(bottom_ten_diseases, self)
  end

  def hashify_for_d3(results, current_user)
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

  def give_risk_names(risks)
    @risk_names = []
    risks.each do |risk|
      if risk.marker.disease.name
        @risk_names << risk.marker.disease.name
      end
      @risk_names.uniq!
    end
  end


end
