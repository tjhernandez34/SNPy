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

end
