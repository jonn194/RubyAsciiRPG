require_relative "AreaV2"
require_relative "Enemy"

def create_map(directions, area_amount, enemies_amount, items_amount)
  @full_map = []
  @full_map.push(AreaV2.new([0]))
  index = 0
  while @full_map.size < area_amount
    @full_map[index].possibleDir.each do |k, v|
      if v == true
        case k 
          when :up
            if @full_map[index].connectionUp == nil #CHECK IF THERE IS NOT ALREADY A CONNECTION ON THAT SIDE
              new_area = AreaV2.new(0) #CREATE THE NEW AREA WITH POSSIBLE CONNECTIONS ID == 0
              @full_map[index].connectionUp = new_area #ASSIGN THE NEW AREA AS A CONNECTION OF THE OLDER ONE
              new_area.connectionDown = @full_map[index] #ASSIGN THE OLDER AREA AS THE OPPOSITE CONNECTION OF THE NEW ONE
              @full_map.push(new_area) #PUSH THE NEW AREA INTO THE ARRAY
            end
          when :down
            if @full_map[index].connectionDown == nil
              new_area = AreaV2.new(1)
              @full_map[index].connectionDown = new_area
              new_area.connectionUp = @full_map[index]
              @full_map.push(new_area)
            end
          when :left
            if @full_map[index].connectionLeft == nil
              new_area = AreaV2.new(2)
              @full_map[index].connectionLeft = new_area
              new_area.connectionRight = @full_map[index]
              @full_map.push(new_area)
            end
          when :right
            if @full_map[index].connectionRight == nil
              new_area = AreaV2.new(3)
              @full_map[index].connectionRight = new_area
              new_area.connectionLeft = @full_map[index]
              @full_map.push(new_area)
            end
        end
      end
    end
    index += 1
  end

  @full_map.each do |a| #ASSIGN THE POSSIBLE DIRECTIONS FOR THE PLAYER TO MOVE, SINCE SOME AREA CONNECTIONS ARE DEAD ENDS
    if a.connectionUp != nil
      a.options[:forward] = directions[:forward]
    end
    if a.connectionDown != nil
      a.options[:back] = directions[:back]
    end
    if a.connectionLeft != nil
      a.options[:left] = directions[:left]
    end
    if a.connectionRight != nil
      a.options[:right] = directions[:right]
    end
  end
  @full_map[-1].is_goal = true #THE LAST AREA CREATED IS THE GOAL
  create_enemies(enemies_amount)
  create_items(items_amount)
end


def create_enemies(enemies_amount)
  count = 0
  temp_map = []
  for i in 0...@full_map.size
    temp_map.push(i)
  end
  while count < enemies_amount
    index = rand(temp_map.size)
    @full_map[index].enemy = single_enemy()
    temp_map[index] = nil
    temp_map.compact!
    count += 1
  end
end

def create_items(items_amount)
  count = 0
  temp_map = []
  for i in 0...@full_map.size
    temp_map.push(i)
  end
  while count < items_amount
    index = rand(temp_map.size)
    @full_map[index].item = rand(3)
    temp_map[index] = nil
    temp_map.compact!
    count += 1
  end  
end

def single_enemy()
  rand_e = rand(4)
  case rand_e
    when 0 then return Slime.new()
    when 1 then return Goblin.new()
    when 2 then return Wolf.new()
    when 3 then return Minotaur.new()
  end
end

def clear_map()
  @full_map.clear
end