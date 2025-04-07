def check_map(area)
  puts ""  
  puts "-MAP-"
  puts area.map
  puts ""
  return "map"
end

def move(area, input, directions)
  @moveConnections = []
  puts ""
  if directions[:forward].include? input
    if area.options.key?(:forward)
      @moveConnections = area.forwardOp
      puts "--MOVED FORWARD"
      puts ""
      return directions[:forward][1]
    else
      return wrong_direction()
    end
  elsif directions[:left].include? input
    if area.options.key?(:left)
      @moveConnections = area.leftOp
      puts "--MOVED LEFT"
      puts ""
      return directions[:left][1]
    else
      return wrong_direction()
    end
  elsif directions[:back].include? input
    if area.options.key?(:back)
      @moveConnections = area.backOp
      puts "--MOVED BACK"
      puts ""
      return directions[:back][1]    
    else
      return wrong_direction()
    end
  elsif directions[:right].include? input
    if area.options.key?(:right)
      @moveConnections = area.rightOp
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