require 'spec_helper'

describe "A Vote(in general) should" do
  it "should be invalid without a user id " do
    Vote.new(:user_id => "").should_not be_valid
  end

  it "should be invalid without a post id " do
    Vote.new(:post_id => "").should_not be_valid
  end
end
