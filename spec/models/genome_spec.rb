require "spec_helper"

describe Genome do 
  before(:each) do
    @my_genome = Genome.new(user_id: 1, file_url: "mygenomehome.com")
  end

  it { should belong_to :user}
  it { should have_many :reports}
end