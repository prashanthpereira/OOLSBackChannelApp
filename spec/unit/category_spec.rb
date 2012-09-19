require 'spec_helper'

describe "A Category (in general) should" do
  it "should be invalid without a name" do
    Category.new(:name => "").should_not be_valid
  end
end
