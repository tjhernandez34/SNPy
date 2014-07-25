require "spec_helper"

describe Risk do 
  before(:each) do
    @my_risk = Risk.create(genome_id: 1, marker_id: 5)
  end

  it "should be valid when new" do
    @my_risk.should be_valid
  end

  it { should belong_to :marker }
  it { should belong_to :genome }
end
