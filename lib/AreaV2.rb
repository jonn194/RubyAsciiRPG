require_relative "Enemy"
require_relative "Item"

class AreaV2
  attr_accessor :is_goal

  attr_accessor :options
  attr_accessor :enemy
  attr_accessor :item
  
  attr_accessor :connectionUp
  attr_accessor :connectionDown
  attr_accessor :connectionLeft
  attr_accessor :connectionRight
  
  attr_reader :map
  attr_reader :upCn
  attr_reader :downCn
  attr_reader :leftCn
  attr_reader :rightCn

  attr_reader :possibleDir


  def initialize(dir)
    @is_goal = false
    
    @options = Hash.new
    @enemy = nil
    @item = -1
    
    @connectionUp = nil
    @connectionDown = nil
    @connectionLeft = nil
    @connectionRight = nil
    
    @map = []
    @upCn = [0, 2, 6, 7]
    @downCn = [0, 3, 4, 5]
    @leftCn = [1, 2, 3, 4, 6]
    @rightCn = [1, 2, 3, 5, 7]
    
    @possibleDir = {
      up: false, 
      down: false, 
      left: false, 
      right: false 
    }
    
    setup(dir)
  end

  def setup(dir)
    type = 0
    
    case dir
      when 0 
        type = @upCn[rand(@upCn.size)]
      when 1 
        type = @downCn[rand(@downCn.size)]
      when 2 
        type = @leftCn[rand(@leftCn.size)]
      when 3 
        type = @rightCn[rand(@rightCn.size)]
    end

    case type
      when 0 #V HALL UP/DOWN
        @map = v_hall_map()
        @possibleDir[:up] = true
        @possibleDir[:down] = true
      when 1 #H HALL LEFT/RIGHT
        @map = h_hall_map()
        @possibleDir[:left] = true
        @possibleDir[:right] = true
      when 2 #T HALL LEFT/DOWN/RIGHT
        @map = t_map()
        @possibleDir[:down] = true
        @possibleDir[:left] = true
        @possibleDir[:right] = true
      when 3 #INV T HALL LEFT/UP/RIGHT
        @map = inv_t_map()
        @possibleDir[:up] = true
        @possibleDir[:left] = true
        @possibleDir[:right] = true
      when 4 #CORNER LEFT/UP
        @map = cor_left_up_map()
        @possibleDir[:up] = true
        @possibleDir[:left] = true
      when 5 #CORNER RIGHT/UP
        @map = cor_right_up_map()
        @possibleDir[:up] = true
        @possibleDir[:right] = true
      when 6 #CORNER LEFT/DOWN
        @map = cor_left_down_map()
        @possibleDir[:down] = true
        @possibleDir[:left] = true
      when 7 #CORNER RIGHT/DOWN
        @map = cor_right_down_map()
        @possibleDir[:down] = true
        @possibleDir[:right] = true
    end
  end

  private
  def v_hall_map () return ["[]   []\n[] C []\n[]   []"] end
  def h_hall_map () return ["[][x][]\n   C   \n[][x][]"] end
  def t_map () return ["[][x][]\n   C   \n[]   []"] end
  def inv_t_map () return ["[]   []\n   C   \n[][x][]"] end
  def cor_left_up_map () return ["[]   []\n   C []\n[][x][]"] end
  def cor_right_up_map () return ["[]   []\n[] C   \n[][x][]"] end
  def cor_left_down_map () return ["[][x][]\n   C []\n[]   []"] end  
  def cor_right_down_map () return ["[][x][]\n[] C   \n[]   []"] end
end