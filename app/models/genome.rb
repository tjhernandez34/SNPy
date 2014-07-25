class Genome < ActiveRecord::Base
	belongs_to :user
	has_many :risks
	mount_uploader :file_url, GenomeUploader
end
