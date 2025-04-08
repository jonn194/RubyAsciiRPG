require_relative "Item"
require_relative "Skill"

class Player
  attr_accessor :hp
  attr_accessor :mana
  attr_accessor :inventory
  attr_accessor :skills
  attr_accessor :shield
  attr_accessor :dmg_buff
  
  attr_reader :role_class
  attr_reader :name
  attr_reader :damage

  def initialize(name, role_class)
    @name = name
    setup(role_class)
  end

  def setup(class_index)
    @role_class = ""
    @hp = 0
    @mana = 0
    @damage = 0
    @shield = 0
    @dmg_buff = 0
    @inventory = {
      :health_potion => HealthPotion.new(), 
      :mana_potion => ManaPotion.new(),
      :gold => Gold.new()
    }
    @skills = Hash.new
    
    case class_index
      when 0
        @role_class = "Knight"
        @hp = 100
        @mana = 25
        @damage = 50
        @skills[:skill01] = MagicShield.new()
      when 1
        @role_class = "Brawler"
        @hp = 130
        @mana = 10
        @damage = 75
      when 2
        @role_class = "Mage"
        @hp = 60
        @mana = 120
        @damage = 25
        @skills[:skill01] = FireBolt.new()
        @skills[:skill02] = ShadowSlash.new()
        @skills[:skill03] = MinorHeal.new()
        @skills[:skill04] = MinorShield.new()
      when 3
        @role_class = "Rogue"
        @hp = 40
        @mana = 50
        @damage = 40
        @skills[:skill01] = ShadowSlash.new()
        @skills[:skill02] = DamageUp.new()
    end
  end

  def attack(target)
    puts ""
    puts "--ATTACKED #{target.name}"
    target.take_damage(@damage + @dmg_buff)
  end

  def defend
    puts ""
    puts "--DEFENDING"
    @defending = true
  end

  def take_damage(dmg)
    if @shield > 0
      aux = dmg
      dmg -= @shield
      @shield -= aux
    elsif @shield < 0
      @shield = 0
    end

    if @defending == true
      dmg = (dmg/1.5).floor
      @hp -= dmg
    else
      @hp -= dmg
    end
    print "YOU TOOK #{dmg} DAMAGE | CURRENT HP: #{hp}"
    if shield > 0
      print " | SHIELD: #{@shield}"
    end
    puts ""
    puts "Current HP: #{hp}"

    if @hp <= 0
      puts ""
      puts "-- GAME OVER --"
      puts ""
    end
  end

  def out_of_combat()
    @shield = 0
    @dmg_buff = 0
  end

end