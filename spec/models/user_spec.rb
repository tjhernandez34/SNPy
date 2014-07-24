require "spec_helper"

describe User do 
  before(:each) do
    @sample_user = User.new(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", password_digest: "password")
  end

  it "should be valid when created" do
    @sample_user.should be_valid
  end

  it "should not be valid if missing first_name" do
    @sample_user.first_name = ""
    @sample_user.should_not be_valid
  end

  it "should not be valid if missing last_name" do
    @sample_user.last_name = ""
    @sample_user.should_not be_valid
  end

  it { should have_many :markers}
end

