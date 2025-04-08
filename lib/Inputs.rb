require_relative "GeneralActions"
require_relative "ExploreActions"
require_relative "CombatActions"
require_relative "ASCIIGraphics"

def validate_classes(player_classes)
  result = nil
  while result == nil
    puts "Now please indicate your class"
    player_classes.each{ |i| print "| #{i} | "}
    puts ""
    input = gets.chomp()
    input.downcase!
    result = player_classes.find_index {|i| i == input}
  end
    return result
end

@action_status = ["c", "character"]
@action_map = ["m", "map"]
@action_inventory = ["i", "inventory"]
@action_exit = ["x", "exit"]

@action_attack = ["k", "attack"]
@action_defend = ["l", "defend"]

@action_consume_1 = ["6", "health"]
@action_consume_2 = ["7", "mana"]

@action_skills = ["e", "skills"]
@action_cast = {skill01: "1", skill02: "2", skill03: "3", skill04: "4"}

def indicate_explore(area)
    print "Possible Movement: " 
    area.options.each{ |k, v| print "| (#{v[0]}) #{v[1]} |" }
    
    puts ""
    print "Possible Actions: "
    print "| (#{@action_status[0]}) #{@action_status[1]} |"
    print "| (#{@action_map[0]}) #{@action_map[1]} |"
    print "| (#{@action_inventory[0]}) #{@action_inventory[1]} |"
    
    puts ""
    print "- Enter your input: "
end

def indicate_combat(player, enemy)
  ascii_sword()
  puts enemy.ascii_art
  puts "-IN COMBAT AGAINST #{enemy.name.upcase}-"
  print "Possible Actions: "
  print "| (#{@action_attack[0]}) #{@action_attack[1]} |"
  print "| (#{@action_defend[0]}) #{@action_defend[1]} |"
  print "| (#{@action_status[0]}) #{@action_status[1]} |"
  print "| (#{@action_inventory[0]}) #{@action_inventory[1]} |"
  if player.skills.size > 0
    print "| (#{@action_skills[0]}) #{@action_skills[1]} |"    
  end
  
  puts ""
  print "- Enter your input: "
end

def general_inputs(input, player)
  return "exit" if @action_exit.include? input.downcase
  return check_status(player) if @action_status.include? input.downcase
  return check_inventory(player) if @action_inventory.include? input.downcase
  return consume_item(0, player) if @action_consume_1.include? input.downcase
  return consume_item(1, player) if @action_consume_2.include? input.downcase
  return "invalid"
end

def explore_inputs(area, player, directions)
  input = gets.chomp()
  return check_map(area) if @action_map.include? input.downcase
  return move(area, input.downcase, directions) if validate_direction(input.downcase, directions)
  return general_inputs(input, player)
end

def combat_inputs(player, enemy)
  input = gets.chomp()
  return attack(player, enemy) if @action_attack.include? input.downcase
  return defend(player) if @action_defend.include? input.downcase
  return check_skills(player) if @action_skills.include? input.downcase
  return cast_skill(input.downcase, @action_cast, player, enemy) if validate_skill(input.downcase, @action_cast, player)
  return general_inputs(input, player)
end


def validate_direction(input, directions)
  result  = directions.select {|key, value| value.include? input}
  if result.empty?
    return false
  else
    return true
  end
end

def get_new_area()
  return @new_area
end