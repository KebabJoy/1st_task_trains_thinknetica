require_relative 'modules'

class Wagon
  include Company
  attr_reader :type; :capacity; :capacity_left; :number
  @@number = 0
  def initialize(company)
    @company = company
    @@number += 1
    @number = @@number
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected #A user has method valid? to validate object
  attr_writer :capacity; :capacity_left;

  def validate!
    raise 'Argument cannot be nil' if @company.nil? || @type.nil?
  end
end
