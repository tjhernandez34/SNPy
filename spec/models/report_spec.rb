require "spec_helper"

describe Report do 
  before(:each) do
    @new_report = Report.new(genome_id: 1)
  end

  it "should be valid when new" do
    @new_report.should be_valid
  end


  it { should have_many :risks}
  it { should belong_to :genome}
end
