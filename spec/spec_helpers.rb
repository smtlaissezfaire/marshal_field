module SpecHelperFunctions
  
  def setup_tests
    setup_database_connection
    setup_project_requires
  end
  
private
  
  def setup_database_connection
    require 'rubygems'
    require 'sqlite3'
    require 'active_record'
    
    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database  => ':memory:'
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do  
      create_table :users, :force => true do |t|
        t.string :first_name
        t.timestamps
      end
    end
  end
  
  def setup_project_requires
    require File.dirname(__FILE__) + "/../lib/marshal_field"
    require File.dirname(__FILE__) + "/fixtures/classes"
  end
end
