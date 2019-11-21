require './node.rb'

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(node)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
      @tail.next_node = nil
    end
  end

  def prepend(node)
    node.next_node = @head
    @head = node
  end

  def size
    count = 0
    current_node = @head
    until current_node.nil?
      count += 1
      current_node = current_node.next_node
    end
    count
  end

  def head
    @head.value
  end
  def tail
    @tail.value
  end

  def at index
    if index + 1 > size
      return nil
    end
    i = 0
    current_node = @head
    until i == index
      i += 1
      current_node = current_node.next_node
    end
    current_node.value
  end

  def pop
    current_node = @head
    until current_node.next_node == @tail
      current_node = current_node.next_node
    end
    @tail = current_node
    current_node.next_node = nil
  end

  def contains? data
    current_node = @head
    until current_node.nil?
      if current_node.value == data
        return true
      else
        current_node = current_node.next_node
      end
    end
    return false
  end

  def find data
    i = 0
    current_node = @head
    until current_node.nil?
      if current_node.value == data
        return "Node with data found at index #{i}"
      else
        current_node = current_node.next_node
        i += 1
      end
    end
    return nil
  end

  def to_s
    current_node = @head
    until current_node.nil?
      print "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    puts "nil"
  end

  def insert_at index, node
    if index >= size
      @tail.next_node = node
      @tail = node
    elsif index == 0
      node.next_node = @head
      @head = node
    else
      i = 0
      current_node = @head
      until i + 1 == index
        current_node = current_node.next_node
        i += 1
      end
      node.next_node = current_node.next_node
      current_node.next_node = node
    end
  end

  def remove_at index
    if index >= size || index < 0
      return nil
    elsif index == 0
      @head = @head.next_node
    end
    i = 0
    current_node = @head
    until i + 1 == index
      i += 1
      current_node = current_node.next_node
    end
    current_node.next_node = current_node.next_node.next_node
  end
end

list = LinkedList.new
list.append(Node.new("Hello!"))
list.append(Node.new("hello again!"))
list.prepend(Node.new("I am the new head node!")) 
puts list
#( I am the new head node! ) -> ( Hello! ) -> ( hello again! ) -> nil
puts "#{list.head}"
#I am the new head node!
puts "#{list.tail}"
#hello again!
puts "#{list.at(1)}"
#Hello!
list.pop
puts list
#( I am the new head node! ) -> ( Hello! ) -> nil
puts list.contains?("Hello!")
#True
puts list.find("Hello!")
#Node with data found at index 1
puts list.find("Should not exist")
#nil
puts list.at(5)
#nil
list.append(Node.new("F"))
list.append(Node.new("G"))
list.append(Node.new("H"))
puts list
#( I am the new head node! ) -> ( Hello! ) -> ( F ) -> ( G ) -> ( H ) -> nil
list.insert_at(1, Node.new("Injection!"))
puts list
#( I am the new head node! ) -> ( Injection! ) -> ( Hello! ) -> ( F ) -> ( G ) -> ( H ) -> nil
list.remove_at(3)
puts list
#( I am the new head node! ) -> ( Injection! ) -> ( Hello! ) -> ( G ) -> ( H ) -> nil