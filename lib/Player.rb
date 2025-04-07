require_relative "Item"

class Player
  attr_accessor :name
  attr_accessor :role_class
  attr_accessor :hp
  attr_accessor :mana
  attr_accessor :damage
  attr_accessor :inventory


  def initialize(name, role_class)
    @name = name
    setup(role_class)
  end

  def setup(class_index)
    @role_class = ""
    @hp = 0
    @mana = 0
    @damage = 0
    @inventory = {
      :health_potion => HealthPotion.new(), 
      :mana_potion => ManaPotion.new(),
      :gold => Gold.new()
    }
    
    case class_index
      when 0
        @role_class = "Knight"
        @hp = 100
        @mana = 25
        @damage = 50
      when 1
        @role_class = "Brawler"
        @hp = 130
        @mana = 10
        @damage = 75
      when 2
        @role_class = "Mage"
        @hp = 60
        @mana = 100
        @damage = 70
      when 3
        @role_class = "Rogue"
        @hp = 40
        @mana = 50
        @damage = 40
    end
  end

  def attack(target)
    puts ""
    puts "--ATTACKED #{target.name}"
    target.take_damage(damage)
  end

  def defend
    puts ""
    puts "--DEFENDING"
    @defending = true
  end

  def take_damage(dmg)
    if @defending == true
      n_dmg = (dmg/1.5).floor 
      @hp -= n_dmg
      puts "YOU TOOK #{n_dmg} DAMAGE | CURRENT HP: #{hp}"
    else
      @hp -= dmg
      puts "YOU TOOK #{dmg} DAMAGE | CURRENT HP: #{hp}"
    end
    puts "Current HP: #{hp}"

    if @hp <= 0
      puts ""
      puts "-- GAME OVER --"
      puts ""
    end
  end

end