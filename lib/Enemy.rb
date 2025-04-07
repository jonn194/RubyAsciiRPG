require_relative "ASCIIGraphics"

class Enemy
  attr_reader :name
  attr_accessor :hp
  attr_accessor :damage
  attr_reader :defending
  attr_reader :ascii_art

  def initialize
    setup()
  end

  def setup()
  end

  def attack(target)
    puts "#{name} ATTACKED YOU"
    target.take_damage(damage)
  end

  def defend
    puts "#{name} DEFENDED"
    @defending = true
  end

  def take_damage(dmg)
    if @defending == true
      n_dmg = (dmg/1.5).floor 
      @hp -= n_dmg
      puts "#{@name} TOOK #{n_dmg} DAMAGE | CURRENT HP: #{hp}"
    else
      @hp -= dmg
      puts "#{@name} TOOK #{dmg} DAMAGE | CURRENT HP: #{hp}"
    end
    
    if @hp <= 0
      puts "#{@name} DEFEATED"
      puts ""
    end
  end

end

class Slime < Enemy
  def setup()
    @name = "Slime"
    @hp = 60
    @damage = 5
    @ascii_art = ascii_slime()
  end
end

class Goblin < Enemy
  def setup()
    @name = "Goblin"
    @hp = 75
    @damage = 15
    @ascii_art = ascii_goblin()
  end
end

class Wolf < Enemy
  def setup()
    @name = "Wolf"
    @hp = 95
    @damage = 20
    @ascii_art = ascii_wolf()
  end
end

class Minotaur < Enemy
  def setup()
    @name = "Minotaur"
    @hp = 150
    @damage = 25
    @ascii_art = ascii_minotaur()
  end
end
