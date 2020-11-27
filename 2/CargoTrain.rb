require_relative 'train'

class CargoTrain < Train
  def initialize(num)
    super
    @type = "Cargo"
  end
end
