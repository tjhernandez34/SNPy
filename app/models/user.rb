class User < ActiveRecord::Base
	has_one :genome

	has_many :risks, through: :genome

end
