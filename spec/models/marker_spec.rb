require "spec_helper"

describe Marker do 
  before(:each) do
    @marker1 = Marker.new(snp: "rs51", allele: "CC", risk_level: 3, disease_id: 1)
  end

  it "should be valid when new" do
    @marker1.should be_valid
  end

  it "should not be valid if snp is missing" do
    @marker1.snp = ""
    @marker1.should_not be_valid
  end

  it "should not be valid if allele is missing" do
    @marker1.allele = ""
    @marker1.should_not be_valid
  end

  it { should have_many :risks }
  it { should belong_to :disease }
end