require_relative "plasma_cannons.rb"
require 'pry'
class AlreadyDeadError < StandardError

end
class OnlyRobotsError < StandardError

end

class Robot
  MAX_HEALTH = 100
  attr_reader :position, :items, :items_weight, :health, :damage, :range
  attr_accessor :equipped_weapon

  # @@capacity = 250

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @damage = 5
    @equipped_weapon = nil
    @range = 1
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)

    capacity = 250
    ###### make sure instance variable do not have the same name as the stubbed method
    ###### ie. @health vs self.health
    ###### your rspec will not be able to sub the instance with the method
    ###### stub will be bypassed and test will fail
    if item.class.superclass == Weapon && items_weight < capacity && item.weight <= capacity
      @items_weight += item.weight
      @items << item
      @equipped_weapon = item
    elsif items_weight < capacity && item.weight <= capacity
      if self.health <= 80 && item.class == BoxOfBolts
        item.feed(self)
      end
      @items_weight += item.weight
      @items << item
    end

    # MM
    # if items_weight < capacity && item.weight <= capacity
    #   if item.class.superclass == Weapon
    #     @items_weight += item.weight
    #     @equipped_weapon = item
    #   else
    #     @items_weight += item.weight
    #     @items << item
    #   end
    # end

  end

  def wound(damage)
    @health -= damage
    if health <= 0
      @health = 0
    end
  end

  def heal(amount)
    self.heal!
    @health += amount
    if health >= MAX_HEALTH
      @health = MAX_HEALTH
    end
  rescue AlreadyDeadError => e
    puts e.message
  end

  def attack(enemy)
    # self.attack!(enemy)
    if @equipped_weapon.nil?
      @range 
    else
      @range = @equipped_weapon.range
    end
    # binding.pry
    if enemy.position[1] == @position[1] + @range || enemy.position[1] == @position[1] - @range || enemy.position[0] == @position[0] + @range || enemy.position[0] == @position[0] - @range || enemy.position == @position
      if enemy.class == Robot && @equipped_weapon.nil?
        enemy.wound(damage)
      elsif @equipped_weapon.name == "Grenade"
        enemy.wound(@equipped_weapon.damage)
        @equipped_weapon = nil
      else
        @equipped_weapon.hit(enemy)
      end
    end
  # rescue OnlyRobotsError => e
  #   puts e.message
end

def heal!
  if @health <= 0
    raise AlreadyDeadError, "Robot is already dead! You can't heal a dead robot!"
  end
end

def attack!(enemy)
  if enemy.class != Robot
    raise OnlyRobotsError, "You cannot attack that object, only other robots!"
  end
end

end
# testing codes
# robot = Robot.new
# robot.wound(1000)
# robot.heal(1000)
# robot2 = Robot.new
# plasmacannon = PlasmaCannon.new
# robot.attack(plasmacannon)
# robot.attack(robot2)
# puts robot2.health
