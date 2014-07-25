require "spec_helper"

describe Category do 
  before(:each) do
    @new_category = Category.new(name: "disease category")
  end

  it "should be valid when new" do
    @new_category.should be_valid
  end

  # it "should be invalid if missing name" do
  #   @new_category.name = ""
  #   @new_category.should_not be_valid
  # end

  it { should have_many :diseases}
end