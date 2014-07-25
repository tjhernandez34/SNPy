class Report < ActiveRecord::Base
  belongs_to :genome
  has_many :risks
end
