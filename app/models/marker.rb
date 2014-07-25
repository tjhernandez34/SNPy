class Marker < ActiveRecord::Base
  validates_presence_of :snp
  validates_presence_of :allele

	belongs_to :disease
	has_many :risks
end
