require "spec_helper"

describe Disease do 
  before(:each) do
    @new_disease = Disease.new(name: "Cancer")
  end

  it "should be valid when new" do
    @new_disease.should be_valid
  end

  it "should not be valid if missing name" do
    @new_disease.name = ""
    @new_disease.should_not be_valid
  end
end

