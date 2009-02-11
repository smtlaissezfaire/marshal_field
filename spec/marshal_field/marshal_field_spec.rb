require File.dirname(__FILE__) + "/../spec_helper"

describe "api" do
  it "should have 'marshal_field' as a public method on ActiveRecord::Base" do
    User.should respond_to(:marshal_field)
  end
end

describe "Marshaling a field" do

  describe "for a", User do
    describe "marshaled_ids" do
      before(:each) do
        User.class_eval do
          marshal_field :ids, :marshaled_ids
        end

        @user = User.new
      end

      it "should be nil array if the field is nil" do
        @user.marshaled_ids = nil
        @user.ids.should be_nil
      end

      it "should nil if it's an an empty string" do
        @user.marshaled_ids = ""
        @user.ids.should be_nil
      end

      it "should be [1] for the marshal'ed array of string '1'" do
        @user.marshaled_ids = Base64.encode64(Marshal.dump([1]))
        @user.ids.should == [1]
      end

      it "should be [1,2] for the marshal'ed array of 1,2" do
        @user.marshaled_ids = Base64.encode64(Marshal.dump([1,2]))
        @user.ids.should == [1,2]
      end

      it "should be able to set the ids" do
        @user.ids = [1,2,3]
        @user.ids.should == [1,2,3]
      end

      it "should set the id to the correct value" do
        @user.ids = [1,2]
        @user.ids
        @user.ids = [2, 343, 3]
        @user.ids.should == [2, 343, 3]
      end

      it "should marshal the submission ids" do
        @user.ids = [1,2,3]
        @user.marshaled_ids.should == Base64.encode64(Marshal.dump([1,2,3]))
      end
    end

    describe "with a marshaled foo column" do
      before(:each) do
        User.class_eval do
          marshal_field :foo, :marshaled_foo
        end

        @user = User.new
      end

      it "should be able to read a value" do
        @user.foo.should be_nil
      end

      it "should be able to write and read the value" do
        @user.foo = :something
        @user.foo.should equal(:something)
      end

      it "should not conflict with another marshaled field" do
        User.class_eval do
          marshal_field :foo, :marshaled_foo
          marshal_field :ids, :marshaled_ids
        end

        @user = User.new

        @user.ids = [1,2,3]
        @user.foo = :something

        @user.ids.should == [1,2,3]
      end
    end
  end
end
