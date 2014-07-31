require "spec_helper"

describe User do 
  # before(:each) do
  it "is valid with a first_name, last_name, email, and password_digest" do 
    @user = User.new(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", password_digest: "password")
    expect(@user).to be_valid 
  end

  xit "is valid with a first_name, last_name, email, and password_digest" do
    @sample_user.should be_valid
    expect(@sample_user).to be_valid
  end

  xit "is invalid without a first_name" do
    expect(@sample_user).to have(1).errors_on(:first_name)
  end

  xit "is invalid without a last_name" do
    @sample_user.last_name = ""
    @sample_user.should_not be_valid
  end

  xit "is invalid without an email" do
    @sample_user.email = ""
    @sample_user.should_not be_valid
  end

  xit "should not be valid if missing password_digest" do
    @sample_user.password_digest = ""
    @sample_user.should_not be_valid
  end

  xit { should validate_uniqueness_of :email }
  xit { should have_many :genomes }
  xit { should have_many(:reports).through(:genomes) }
end

