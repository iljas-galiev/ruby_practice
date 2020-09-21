class LinkedList
  include Enumerable
	attr_accessor :head
	def << (value)
		if !@head
			@head = Node.new value
		else
			node = @head
			while node.next_node != nil
				node = node.next_node
			end
			node.next_node = Node.new value
		end
	end

	def each
		node = @head
		while node
			yield node.value
			node = node.next_node
		end
	end

  def remove value
		prev = nil
		node = @head

		if(@head.value == value)
			@head = @head.next_node
			return
		end

		while node
			if node.value == value
				prev.next_node = node.next_node
			end
			prev = node
			node = node.next_node
		end
	end

  def print
		self.each do |item|
			puts item
		end
		puts "\n"
	end
end