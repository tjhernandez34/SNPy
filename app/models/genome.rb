class Genome < ActiveRecord::Base

  mount_uploader :genome , GenomeUploader

  validates_presence_of :file_url
	belongs_to :user

	mount_uploader :file_url, GenomeUploader

	has_many :reports



end
