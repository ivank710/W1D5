require "byebug"

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def inspect 
    value
  end 

  def parent=(new_parent)
    if new_parent.nil?
      @parent = nil
    elsif @parent.nil?
      @parent = new_parent 
      unless new_parent.children.include?(self)
        new_parent.children << self
      end
    else
      old_parent = self.parent 
      old_children = old_parent.children

      old_children.delete(self)

      @parent = new_parent

      unless new_parent.children.include?(self)
        new_parent.children << self
      end
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "This is not your child" if child_node.parent.nil?

    child_node.parent=()
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      child.dfs(target_value)
    end

  end

end