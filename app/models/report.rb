class Report < ActiveRecord::Base
  belongs_to :genome
  has_many :risks

  attr_reader :create_report

  # def self.create_report
  #   create(genome_id: 32)#current_user.genomes.last)
  # end

end
