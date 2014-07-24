class Risk < ActiveRecord::Base
  
	
	belongs_to :marker
	belongs_to :genome

end
