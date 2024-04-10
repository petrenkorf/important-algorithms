# frozen_string_literal: true

class Node
  attr_accessor :next, :value

  def initialize(value)
    @value = value
    @next = nil
  end

  def add(value)
    if @next.nil?
      @next = Node.new value
    else
      @next.add value
    end
  end
end

linked_list = Node.new(1).tap do |l|
  l.add(2)
  l.add(3)
  l.add(4)
end

pp linked_list

prev_node = nil
cur_node  = linked_list

until cur_node.nil?
  tmp = cur_node.next
  cur_node.next = prev_node
  prev_node = cur_node
  cur_node = tmp
  
  # since we do not have pointers, 
  # we have to track the last old item
  linked_list = prev_node
end

pp linked_list
