require_relative 'tree.rb'

class KnightPathFinder
  def initialize(location)
    @start_position = location
    @board = Tree.generate_grid(8, location)
  end

  def find_path(location)
    @board.bfs(location)
    
    path = []

    parents = @board.instance_variable_get(:@parents)
    # debugger
    end_pos = parents.keys.select { |key| key.value == location }[0]
    until end_pos.value == @start_position
      path << end_pos.value
      end_pos = parents[end_pos]
    end

    path << end_pos.value

    path.reverse
  end
end