class Genome < ActiveRecord::Base
  validates_presence_of :file_url
	
  belongs_to :user
	has_many :risks
end
