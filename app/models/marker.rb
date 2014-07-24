class Marker < ActiveRecord::Base
	belongs_to :disease
	has_many :risks
end
