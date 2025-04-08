def check_status(player)
  puts ""
  puts "-CHARACTER-"
  puts "Name: #{player.name}  |  Class: #{player.role_class}"
  puts "HP: #{player.hp}  |  Mana: #{player.mana}  |  Damge: #{player.damage}"
  puts ""
  return "status"
end

def check_inventory(player)
  puts ""
  puts "-INVENTORY-"
  if player.inventory.size > 0
    player.inventory.each do |k, v| 
      if v.amount > 0
        print "| #{v.item_name}: #{v.amount} |"
      end 
    end
  end
  if player.inventory[:health_potion].amount == 0 && player.inventory[:mana_potion].amount == 0 && player.inventory[:gold].amount == 0
    puts "--INVENTORY EMPTY"
    puts ""
  else
    if player.inventory[:health_potion].amount > 0
      puts ""
      print "| Consume: (6) health |"
    end
    if player.inventory[:mana_potion].amount > 0
      puts ""
      print "| Consume: (7) mana |"
    end
    puts ""
  end
  return "inventory"
end

def consume_item(item_id, player)
  case item_id
  when 0
    if player.inventory[:health_potion].amount > 0
      player.inventory[:health_potion].consume(player)
    else
      puts "--NOT ENOUGH POTIONS"
      return ""
    end
  when 1
    if player.inventory[:mana_potion].amount > 0
      player.inventory[:mana_potion].consume(player)
    else
      puts "--NOT ENOUGH POTIONS"
      return ""
    end
  end
  return "consumed"
end