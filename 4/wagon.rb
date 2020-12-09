require_relative 'modules'

class Wagon
  include Company
  attr_reader :type

  def initialize(type,company)
    @company = company
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected #A user has method valid? to validate object

  def validate!
    raise 'nil' if @company.nil? || @type.nil?
  end
end
