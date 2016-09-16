class PolyTreeNode
  attr_reader :parent, :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    unless @parent.nil?
      @parent.children.delete(self)
    end

    @parent = parent
    if !parent.nil? && !parent.children.include?(self)
      parent.children << self
    end
  end

#position.add_child(current_child)
  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if @children.include?(child)
      child.parent = nil
    else
      raise "Not a child"
    end
  end

  def inspect
    @value.inspect
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      answer = child.dfs(target_value)
      return answer if answer
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end
end
