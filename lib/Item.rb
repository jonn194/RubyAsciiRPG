class Item
  attr_reader :item_name
  attr_reader :item_power
  attr_accessor :amount
  @amount = 0  
  @item_name = "-"

  def initialize
    setup()
  end

  def setup
    @item_power = 0
  end

  def consume
            
  end

  def get_amount()
    return @amount
  end

  def add_item(n_amount)
    puts "--OBTAINED #{n_amount} #{@item_name}"
    puts ""
    @amount += n_amount      
  end
end

class HealthPotion < Item
  def setup
    @item_power = 20
    @amount = 0  
    @item_name = "Health Potion"
  end

  def consume(player)
    puts""
    puts "-CONSUMED HEALTH POTION"
    puts "RECOVERED #{@item_power} HEALTH"
    puts""
    player.hp += @item_power
    @amount -= 1
  end
end

class ManaPotion < Item 
  def setup
    @item_power = 10
    @amount = 0
    @item_name = "Mana Potion"
  end

  def consume(player)
    puts""
    puts "-CONSUMED MANA POTION"
    puts "RECOVERED #{@item_power} MANA"
    puts""
    player.mana += @item_power
    @amount -= 1
  end
end

class Gold < Item  
  def setup
    @item_power = 0
    @amount = 0
    @item_name = "Gold"
  end
end