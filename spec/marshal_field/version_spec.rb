require File.dirname(__FILE__) + "/../spec_helper"

describe MarshalField do
  it "should be on version 1.0.1" do
    MarshalField::VERSION.should == "1.0.1"
  end
end
