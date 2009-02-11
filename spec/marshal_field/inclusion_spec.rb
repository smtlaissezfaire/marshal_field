require File.dirname(__FILE__) + "/../spec_helper"

describe "including MarshalField into other objects" do
  before(:each) do
    @class = Class.new do
      include MarshalField
    end
  end

  it "should create the class method 'marshal_field" do
    @class.should respond_to(:marshal_field)
  end

  it "should have the instance method load_marshable_field" do
    @class.new.should respond_to(:load_marshable_field)
  end
end
