class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates_inclusion_of :doctor, :in => [true, false]

  has_many :genomes
	has_many :reports, through: :genomes

  attr_reader :current_username

  def current_risks_by_category
    if self.reports.length > 0
      self.current_risks.group_by {|risk| risk.category}.delete_if{|category, risks| risks.length == 0}.keys
    end
  end

  def current_risks
    self.reports.order(created_at: :desc).first.risks
  end

  # def self.current_username
  #   "joey"#current_user.username
  # end

end
