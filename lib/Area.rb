module RPGElements
    class Area
      attr_reader :map
      attr_reader :options
      attr_reader :forwardOp
      attr_reader :backOp
      attr_reader :leftOp
      attr_reader :rightOp

      def initialize(connections, directions)
        setup(connections, directions)
      end

      def setup(connections, directions)
        @options = Hash.new
        type = connections[rand(connections.size)]
        
        @forwardOp = [0, 2, 6, 7]
        @backOp = [0, 3, 4, 5]
        @leftOp = [1, 2, 3, 4, 6]
        @rightOp = [1, 2, 3, 5, 7]
        
        case type
          when 0 #V HALL UP/DOWN
            @map = ["[]   []\n[] C []\n[]   []"]
            @options[:forward] = directions[:forward]
            @options[:back] = directions[:back]
          when 1 #H HALL LEFT/RIGHT
            @map = ["[][x][]\n   C   \n[][x][]"] 
            @options[:left] = directions[:left]
            @options[:right] = directions[:right]
          when 2 #T HALL LEFT/DOWN/RIGHT
            @map = ["[][x][]\n   C   \n[]   []"] 
            @options[:back] = directions[:back]
            @options[:left] = directions[:left]
            @options[:right] = directions[:right]
          when 3 #INV T HALL LEFT/UP/RIGHT
            @map = ["[]   []\n   C   \n[][x][]"] 
            @options[:forward] = directions[:forward]
            @options[:left] = directions[:left]
            @options[:right] = directions[:right]
          when 4 #CORNER LEFT/UP
            @map = ["[]   []\n   C []\n[][x][]"] 
            @options[:forward] = directions[:forward]
            @options[:left] = directions[:left]
          when 5 #CORNER RIGHT/UP
            @map = ["[]   []\n[] C   \n[][x][]"] 
            @options[:forward] = directions[:forward]
            @options[:right] = directions[:right]
          when 6 #CORNER LEFT/DOWN
            @map = ["[][x][]\n   C []\n[]   []"] 
            @options[:back] = directions[:back]
            @options[:left] = directions[:left]
          when 7 #CORNER RIGHT/DOWN
            @map = ["[][x][]\n[] C   \n[]   []"] 
            @options[:back] = directions[:back]
            @options[:right] = directions[:right]
        end
      end
    end
end