class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :genomes
	has_many :reports, through: :genomes

  def category_risks(category)
    reports.order(created_at: :desc).first
  end

end
