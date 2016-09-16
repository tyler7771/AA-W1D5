require_relative 'node'
require 'byebug'

class KnightPathFinder

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [starting_position]
  end

  def valid_moves(pos)
    valid_move = all_moves(pos)

    valid_move.delete_if do |pos|
      (pos[0] < 0 || pos[0] > 7) ||
      (pos[1] < 0 || pos[1] > 7)
    end
  end

  def all_moves(pos)
    moves = []
    moves << [(pos[0] + 2), (pos[1] + 1)]
    moves << [(pos[0] + 2), (pos[1] - 1)]
    moves << [(pos[0] - 2), (pos[1] + 1)]
    moves << [(pos[0] - 2), (pos[1] - 1)]
    moves << [(pos[0] + 1), (pos[1] + 2)]
    moves << [(pos[0] + 1), (pos[1] - 2)]
    moves << [(pos[0] - 1), (pos[1] + 2)]
    moves << [(pos[0] - 1), (pos[1] - 2)]
    moves
  end

  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    new_moves.delete_if { |move| @visited_positions.include?(move) }
    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    #debugger
    @root = create_node(@starting_position, nil)
    queue = [@root]

    until queue.empty?
      current_node = queue.shift
      children_positions = new_move_positions(current_node.value)
      children_positions.each do |child_pos|
        child_node = create_node(child_pos, current_node)
        queue << child_node
      end
    end
  end

  def create_node(position, parent)
    node = PolyTreeNode.new(position)
    node.parent= parent
    node
  end

  def find_path(target_position)
    @root.dfs(target_position)
  end

  def trace_back_path(target_position)
    # debugger
    path = [find_path(target_position)]
    until path.last == @root
      #find_path(path.last)
      path << path.last.parent
    end
    path.reverse
  end

end
public
def string_conversion(string)
  split_string = string.split(",")
  array = []
  split_string.each { |el| array << el.to_i }
  p array
end

if __FILE__ == $PROGRAM_NAME
  knight =KnightPathFinder.new([0,0])
  knight.build_move_tree
  p knight.trace_back_path([7,6])
end
