class Genome < ActiveRecord::Base
	belongs_to :user
	has_many :risks
end
