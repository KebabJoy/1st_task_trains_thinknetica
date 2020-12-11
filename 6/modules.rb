module Company
  attr_accessor :company
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, args = nil)
      @validations ||= []
      @validations << [name, type, args]
    end
  end

  module InstanceMethods
    def validate!(name, type, args = nil)
      var = instance_variable_get("@#{name}")
      send "validate_#{type}", [var, args]
    end

    def valid?
      self.class.validations.each do |validation|
        validate!(validation[0], validation[1], validation[2])
      end
      true
    rescue StandardError
      false
    end

    private #A user shouldn't be able to use these validations manually
    def validate_presence(*args)
      raise 'Variable is nil!' if args[0].nil? || args[0].empty?
    end

    def validate_format(*args)
      raise "Variable doesn't match the template" if args[0] !~ args[1]
    end

    def validate_type(*args)
      raise "Variable doesn't match the type" if args[0].is_a? args[1]
    end
  end
end

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      @history ||= {}

      names.each do |name|
        var_name = "@#{name}".to_sym

        define_method(name) { @history[name] }
        define_method("#{name}=".to_sym) do |value|
          @history[name] << value
          instance_variable_set(var_name, value)
        end

        define_method("#{name}_history") do
          @history[name]
        end
      end
    end

    def strong_attr_accessor(name, type)
      define_method(name) { instance_variable_get(name) }

      define_method("#{name}=".to_sym) do |value|
        raise 'Wrong type of variable!' if type != value.type
        instance_variable_set(name, value)
      end
    end
  end

end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end
  end

  protected # Class changes value itself

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end
end
