def attack(player, enemy)
  player.attack(enemy)
  return "attack"
end

def defend(player)
  player.defend()
  return "defend"
end

def check_skills(player)
  puts ""
  puts "-SKILLS-"
  count = 1
  player.skills.each do |k, v|
   print "| (#{count}) #{v.skill_name} - POW: #{v.power} - COST: #{v.cost} |"   
   count += 1   
  end
  puts ""
  return "check skills"
end

def validate_skill(input, actions, player)
  if actions.has_value?(input) && player.skills.key?(actions.key(input))
    return true
  else
    return false
  end
end

def cast_skill(input, actions, player, enemy)
  player.skills[actions.key(input)].cast(player, enemy)
  return "skill"
end