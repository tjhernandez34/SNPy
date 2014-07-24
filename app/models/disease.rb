class Disease < ActiveRecord::Base
	has_many :markers
end
