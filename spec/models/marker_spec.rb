require "spec_helper"

describe Marker do 
  before(:each) do
    @marker1 = Marker.new(rsid: "rs51", snp: "CC", risk_level: 3, disease_id: 1)
  end

  it "should be valid when new" do
    @marker1.should be_valid
  end

  it "should not be valid if rsid" do
    @marker1.rsid = ""
    @marker1.should_not be_valid
  end

  it "should not be valid if snp" do
    @marker1.snp = ""
    @marker1.should_not be_valid
  end

  it { should have_many :risks }
  it { should belong_to :disease }
end