class Disease < ActiveRecord::Base
  validates_presence_of :name
	
  has_many :markers
end
