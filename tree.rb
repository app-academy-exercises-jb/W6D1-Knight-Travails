require 'byebug'
class Tree
  def self.generate_grid(n, location)
    grid = Array.new(n) { |i| Array.new(n) { |j| Node.new([i,j]) } }
    grid.each_with_index { |row,idx|
      row.each_with_index { |node,idx2|
        neighbors = knightly_neighbors([idx,idx2], n-1)
        neighbors.map { |loc| grid[loc[0]][loc[1]] }.each { |nei| node.children << nei }
      }
    }
    Tree.new(grid[location[0]][location[1]])
  end

  def self.knightly_neighbors(position, size)
    positions = []
    # size -= 2
    
    x, y = position[0], position[1]

    positions << [x-1, y+2] unless x == 0 || y > size-2
    positions << [x-1, y-2] unless x == 0 || y < 2
    positions << [x-2, y+1] unless x < 2 || y > size-1
    positions << [x-2, y-1] unless x < 2 || y == 0

    positions << [x+1, y+2] unless x > size-1 || y > size-2
    positions << [x+1, y-2] unless x > size-1 || y < 2
    positions << [x+2, y+1] unless x > size-2 || y > size-1
    positions << [x+2, y-1] unless x > size-2 || y == 0

    positions
  end

  def bfs(target, discovered=nil)
    return if @discovered[target] == true
    start = @head
    @queue.unshift(start)
    @discovered[start] = true
    until @queue.empty?
      node = @queue.pop
      node.children.each { |child|
        if @discovered[child] == false
          @queue.unshift(child)
          @discovered[child] = true
          @parents[child] = node
        end
      }
    end
  end

  def initialize(head)
    @head = head
    @queue = []
    @discovered = Hash.new { |h, k| h[k] = false }
    @parents = {}
  end

end

class Node
  attr_accessor :children
  attr_reader :value
  
  def initialize(value)
    @value = value
    @children = []
  end

  def inspect
    @value
  end
end
