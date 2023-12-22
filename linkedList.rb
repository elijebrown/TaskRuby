class Node
    attr_accessor :data, :next, :prev
    def initialize(data)
        @data = data
        @next = nil
        @prev = nil
    end
end

class DoublyLinkedList
    attr_accessor :head, :tail, :size
    
    def initialize()
        @head = nil
        @tail = nil
        @size = 0
    end

    # append to the end of the list
    def add(data)
        node = Node.new(data)
        if @head.nil?
            @head = node
            @tail = node
        else
            node.prev = @tail
            @tail.next = node
            @tail = node
        end
        @size += 1
    end

    # remove
    def remove(data)
        node = @head
        while node != nil
            if node.data == data
                if node == @head
                    @head = @head.next
                    @head.prev = nil
                elsif node == @tail
                    @tail = @tail.prev
                    @tail.next = nil
                else
                    node.prev.next = node.next
                    node.next.prev = node.prev
                end
                @size -= 1
                return true
            end
            node = node.next
        end
    end

    # pop
    def pop()
        if @head.nil?
            return nil
        else 
            node = @tail
            @tail = @tail.prev
            @tail.next = nil
            @size -= 1
            return node.data
        end
    end

    # clear
    def clear
        @head = nil
        @tail = nil
        @size = 0
    end
end