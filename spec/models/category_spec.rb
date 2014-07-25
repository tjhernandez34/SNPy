require "spec_helper"

describe Category do 
  before(:each) do
    @category1 = Category.new(name: "disease_category")
  end

  it "should be valid when new" do
    @category1.should be_valid
  end

  it "should not be valid if missing name" do
    @category1.name = ""
    @category1.should_not be_valid
  end

  it { should have_many :diseases}
end