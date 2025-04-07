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
  action = ""
  initiate_map()

  while true
    unless @in_combat
      if @current_area.is_goal
        puts ""
        puts "--END OF LEVEL"
        puts "--GOING TO THE NEXT FLOOR..."
        puts ""
        clear_map()
        initiate_map()
      end
      indicate_explore(@current_area)
      action = explore_inputs(@current_area, @player, @directions)
      if action == "forward" || action == "left" || action == "back" || action == "right"
        @current_area = get_new_area()
        check_encounter()
      end
    else
      indicate_combat(@current_area.enemy)
      action = combat_inputs(@player, @current_area.enemy)
      if action == "attack" || action == "defend"
        if @current_area.enemy.hp <= 0
          @current_area.enemy = nil
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

def initiate_map()
  create_map(@directions, 10, 5, 3)
  @current_area = @full_map[0]
end

def check_encounter() #CHECK IF THE AREA ALREADY HAS MOSTER/ITEM
  if @current_area.enemy != nil
    @in_combat = true
  end

  if @current_area.item > -1
    case @current_area.item
      when 0 then @player.inventory[:health_potion].add_item(1)
      when 1 then @player.inventory[:mana_potion].add_item(1)
      when 2 then @player.inventory[:gold].add_item(1)
    end
    @current_area.item = -1
  end
end

def enemy_action()
    rand_a = rand(100)
    if rand_a < 60
      @current_area.enemy.attack(@player)
    else
      @current_area.enemy.defend()
    end
end

Main()