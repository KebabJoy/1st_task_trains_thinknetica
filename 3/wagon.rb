require_relative 'modules'

class Wagon
  include Company
  attr_reader :type

  def initialize(type,company)
    @company = company
    @type = type
  end
end
