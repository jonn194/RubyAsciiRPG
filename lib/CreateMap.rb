require_relative "AreaV2"
require_relative "Enemy"

@full_map = []
@all_enemies = []

def create_map()
  area_amount = 15
  @full_map.push(AreaV2.new([0]))
  index = 0
  while @full_map.size < area_amount
    @full_map[index].possibleDir.each do |k, v|
      if v == true
        case k 
          when :up
            @full_map[index].connectionUp = @full_map.push(AreaV2.new(0))
          when :down
            @full_map[index].connectionDown = @full_map.push(AreaV2.new(1))
          when :left
            @full_map[index].connectionLeft = @full_map.push(AreaV2.new(2))
          when :right
            @full_map[index].connectionRight = @full_map.push(AreaV2.new(3))
        end
      end
    end
    index += 1
  end
  @full_map.each {|a| puts a.map }
end


def create_enemies(enemies_amount)
  count = 0
  temp_map = @full_map
  while count < enemies_amount
    index = rand(temp_map.size)
    @full_map[index].enemy = single_enemy()
    temp_map[index] = nil
    temp_map.compact
    count += 1
  end
end

def create_items(items_amount)
  count = 0
  temp_map = @full_map
  while count < items_amount
    index = rand(temp_map.size)
    @full_map[index].item = rand(3)
    temp_map[index] = nil
    temp_map.compact
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
