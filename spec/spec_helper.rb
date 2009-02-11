
require 'rubygems'
require 'spec'

Spec::Runner.configure do |config|
  require File.dirname(__FILE__) + "/spec_helpers"
  
  include SpecHelperFunctions
  setup_tests
end
