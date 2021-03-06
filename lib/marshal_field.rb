require "base64"

module MarshalField
  MAJOR = 1
  MINOR = 0
  TINY  = 1
  VERSION = "#{MAJOR}.#{MINOR}.#{TINY}"
  
  def self.extended(other_mod)
    other_mod.extend ClassMethods
    other_mod.class_eval { include InstanceMethods }
  end

  def self.included(other_mod)
    extended(other_mod)
  end

  module ClassMethods
    def marshal_field(attr, field)
      define_method attr do
        value = instance_variable_get("@#{attr}")
        value ||= load_marshable_field(field)
      end

      define_method "#{attr}=" do |value|
        write_attribute(field, dump_marshable_field(value))
        instance_variable_set("@#{field}", value)
      end
    end
  end

  module InstanceMethods
    def dump_marshable_field(value)
      Base64.encode64(Marshal.dump(value))
    end

    def load_marshable_field(field)
      field_value = read_attribute(field)

      if field_value && !field_value.blank?
        Marshal.load(Base64.decode64(read_attribute(field)))
      else
        nil
      end
    end
  end
end
