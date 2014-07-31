class Genome < ActiveRecord::Base

  mount_uploader :file_url, GenomeUploader

  belongs_to :user
  has_many :reports
end
