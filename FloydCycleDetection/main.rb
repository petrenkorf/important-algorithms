class Node
  def initialize(value)
    @value = value
  end

  def link_to(node)
    @next = node
  end
end

node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)

node1.link_to node2
node2.link_to node3
node3.link_to node4

fast_pointer = node1
slow_pointer = node1

pp node1

