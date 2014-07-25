require "spec_helper"

describe User do 
  before(:each) do
    @sample_user = User.new(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", password_digest: "password")
  end

  it "should be valid when created" do
    @sample_user.should be_valid
  end

  it "should not be valid if missing email" do
    @sample_user.email = ""
    @sample_user.should_not be_valid
  end

  it "should not be valid if missing password_digest" do
    @sample_user.password_digest = ""
    @sample_user.should_not be_valid
  end

  it { should validate_uniqueness_of :email }
  it { should have_one :genome }
  it { should have_many(:risks).through(:genome) }
end

