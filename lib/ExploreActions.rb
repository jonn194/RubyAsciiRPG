def check_map(area)
  puts ""  
  puts "-MAP-"
  puts area.map
  puts ""
  return "map"
end

def move(area, input, directions)
  @new_area = nil
  puts ""
  if directions[:forward].include? input
    if area.options.key?(:forward)
      @new_area = area.connectionUp
      puts "--MOVED FORWARD"
      puts ""
      return directions[:forward][1]
    else
      return wrong_direction()
    end
  elsif directions[:back].include? input
    if area.options.key?(:back)
      @new_area = area.connectionDown
      puts "--MOVED BACK"
      puts ""
      return directions[:back][1]    
    else
      return wrong_direction()
    end
  elsif directions[:left].include? input
    if area.options.key?(:left)
      @new_area = area.connectionLeft
      puts "--MOVED LEFT"
      puts ""
      return directions[:left][1]
    else
      return wrong_direction()
    end
  elsif directions[:right].include? input
    if area.options.key?(:right)
      @new_area = area.connectionRight
      puts "--MOVED RIGHT"
      puts ""
      return directions[:right][1]
    else
      return wrong_direction()
    end  
  end
end

def wrong_direction()
  puts "--Cannot move in that direction"
  puts ""
  return ""
end