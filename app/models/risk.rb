class Risk < ActiveRecord::Base

	belongs_to :marker
	belongs_to :report

  # has_one :marker
  has_one :disease, through: :marker
  has_one :category, through: :disease

end
