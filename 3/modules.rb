module Company
  attr_accessor :company
end

module Instances
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    def instances
      @@instances
    end
  end

  protected # Class changes value itself

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end
end
