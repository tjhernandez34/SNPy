class Genome < ActiveRecord::Base

  mount_uploader :file_url, GenomeUploader

  # validates_presence_of :file_url
	belongs_to :user

	has_many :reports



end
