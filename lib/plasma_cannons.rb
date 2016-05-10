require_relative 'weapon.rb'

class PlasmaCannon < Weapon
  attr_reader :range
  def initialize
    super("Plasma Cannon", 200, 55)
    @range = 0
  end

end