# MarshalField
module MarshalField
  def marshal_field(attr, field)
    define_method attr do
      value = instance_variable_get("@#{attr}")
      value ||= load_marshable_field(field)
    end

    define_method "#{attr}=" do |value|
      write_attribute(field, Marshal.dump(value))
      instance_variable_set("@#{field}", value)
    end

    define_method :load_marshable_field do |field|
      field_value = read_attribute(field)

      if field_value && !field_value.blank?
        Marshal.load(read_attribute(field))
      else
        nil
      end
    end
  end
end
