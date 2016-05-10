require_relative "item.rb"

class BoxOfBolts < Item
  @@heal_amount = 20

  def initialize
    super("Box of bolts", 25)

  end

  def feed(robot)
      robot.heal(@@heal_amount)
  end

end