require "spec_helper"

describe User do 
  it "is valid with a first_name, last_name, email, and password_digest" do 
    @user = User.new(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", password_digest: "password")
    expect(@user).to be_valid 
  end

  it "is invalid without a first_name" do
    expect(User.new(first_name: nil)).to_not be_valid
  end

  it "is invalid without a last_name" do
    expect(User.new(last_name: nil)).to_not be_valid
  end

  it "is invalid without an email" do
    expect(User.new(email: nil)).to_not be_valid
  end

  it "is invalid with a duplicate email address" do
    User.create(first_name: "Max", last_name: "Ruby", email: "jewel@gmail.com", password_digest: "sweet")
    user = User.new(first_name: "Jewel", last_name: "Green", email: "jewel@gmail.com", password_digest: "cake")
      expect(user).to_not be_valid
  end

  it "should not be valid if missing password_digest" do
    expect(User.new(last_name: nil)).to_not be_valid
  end

  it { should have_many :genomes }
  it { should have_many(:reports).through(:genomes) }
end

