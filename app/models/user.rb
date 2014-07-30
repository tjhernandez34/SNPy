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

end
