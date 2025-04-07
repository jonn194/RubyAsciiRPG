require_relative "Player"
require_relative "Enemy"
require_relative "Inputs"
require_relative "Area"
require_relative "Item"
require_relative "CreateMap"
include RPGElements

@player_classes = ["knight", "brawler", "mage", "Rogue"]
@full_map = []
@directions = {
  forward: ["w", "forward"],
  back: ["s", "back"],
  left: ["a", "left"],
  right: ["d", "right"]
}
@in_combat = false
@current_enemy = nil

def Main()
  init_game()
  game_loop()
end

def init_game
  puts "Welcome to the ASCII Dungeon!"
  puts "Please write your name adventurer"
  player_name = gets.chomp()
  player_class = validate_classes(@player_classes)

  @player = Player.new(player_name, player_class)
  puts "Awesome! You are:"
  puts "Name: #{@player.name}  |  Class: #{@player.role_class}"
  puts "HP: #{@player.hp}  |  Mana: #{@player.mana}  |  Damge: #{@player.damage}"
end

def game_loop 
  @currentArea = Area.new([0],@directions)
  action = ""
  create_map()
  while true
    unless @in_combat
      indicate_inputs(@currentArea)      
      action = explore_inputs(@currentArea, @player, @directions)
      if action == "forward" || action == "left" || action == "back" || action == "right"
        @currentArea = Area.new(get_move_options(), @directions)
        check_encounter()
      end
    else
      indicate_combat(@current_enemy)
      action = combat_inputs(@player, @current_enemy)
      if action == "attack" || action == "defend"
        if @current_enemy.hp <= 0
          @current_enemy = nil
          @in_combat = false
        else
          enemy_action()
        end

        break if @player.hp <= 0
      end
    end
    break if action == "exit"

    if action == "invalid"
      puts "INVALID INPUT"
    end
  end
  puts "Ending the game..."
  puts "For more projects please visit https://github.com/jonn194"
end

def check_encounter()
  random_enemy = rand(100)
  random_item = rand(100)
  if random_enemy > 50
    @in_combat = true
    rand_e = rand(4)
    case rand_e
      when 0 then @current_enemy = Slime.new()
      when 1 then @current_enemy = Goblin.new()
      when 2 then @current_enemy = Wolf.new()
      when 3 then @current_enemy = Minotaur.new()
    end
    
  elsif random_item > 50
    rand_i = rand(3)
    case rand_i
      when 0 then @player.inventory[:health_potion].add_item(1)
      when 1 then @player.inventory[:mana_potion].add_item(1)
      when 2 then @player.inventory[:gold].add_item(1)
    end
  end
end

def enemy_action()
    rand_a = rand(100)
    if rand_a < 60
      @current_enemy.attack(@player)
    else
      @current_enemy.defend()
    end
end

Main()