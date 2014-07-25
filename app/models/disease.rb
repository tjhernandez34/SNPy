class Disease < ActiveRecord::Base
	has_many :markers
  belongs_to :category
end
