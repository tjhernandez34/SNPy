require "spec_helper"

describe Genome do 
  before(:each) do
    @my_genome = Genome.new(user_id: 1, file_url: "mygenomehome.com")
  end

  it "should be valid when new" do
    @my_genome.should be_valid
  end

  it "should not be valid if missing file_url" do
    @my_genome.file_url = ""
    @my_genome.should_not be_valid
  end

  it { should belong_to :user}
  it { should have_many :risks}
end