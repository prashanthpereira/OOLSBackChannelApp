require 'spec_helper'

describe "A Post (in general)" do
  it "should be invalid without content " do
    Post.new(:content => "").should_not be_valid
  end

  it "should be invalid without userid " do
    Post.new(:user_id => "").should_not be_valid
  end

  it "should be invalid without category id " do
    Post.new(:category_id=> "").should_not be_valid
  end

end