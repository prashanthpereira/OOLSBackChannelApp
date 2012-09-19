require 'spec_helper'

describe "A User (in general)" do

  it "should be invalid without a name" do
    User.new(:name => "").should_not be_valid
  end

  it "should be invalid without a user name" do
    User.new(:username => "").should_not be_valid
  end

  it "should be invalid without a  password" do
    User.new(:password => "").should_not be_valid
  end

  it "should be invalid without a  roke" do
    User.new(:role=> "").should_not be_valid
  end

end