class Marker < ActiveRecord::Base
  validates_presence_of :rsid
  validates_presence_of :snp

	belongs_to :disease
	has_many :risks
end
