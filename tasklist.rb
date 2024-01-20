require_relative 'linkedList'
require_relative 'utils'
require 'set'

# class: TaskList
class TaskList
    def initialize()
        @hash = Hash.new
        # create double linked list
        @list = DoublyLinkedList.new
    end

    # add task
    def add(task) # if no parent supplied, nil
        # add to hash
        key = caseInsensitive(task.name)
        @hash[key] = task
        if task.parent
            task.parent.children.add(task)
        # add to list
        else
            @list.add(task)
        end
    end

    # remove task
    def remove(task) # if no parent supplied, nil
        # remove from hash
        key = caseInsensitive(task.name)
        @hash.delete(key)
        if task.parent
            task.parent.children.remove(task)
        else 
            @list.remove(task)
        end
    end

    # uses hash for O(1) lookup
    # search input is user input, formatted in function
    def search(name)
        key = caseInsensitive(name)
        return @hash[key] # returns task object or nil
    end

    def hasParent(task)
        return task.parent != nil # returns true or false
    end

    def size()
        return @list.size
    end

    def printTasks()
        if @list.size == 0
            return puts "Error: No tasks to print"
        end
    
        puts "Task Name | Total Hours | Session (time) | Previous Session (hours)| Date Created"
        visited = Set.new
        stack = []
        stack.push([@list.head, 0]) # Start from the head of the list with depth 0
    
        while !stack.empty?
            node, depth = stack.pop
            next if node.nil? || visited.include?(node.data)
    
            visited.add(node.data) # Mark the node as visited
            puts "#{' ' * depth * 2}#{node.data.printTask()}"
    
            stack.push([node.next, depth]) if node.next
            child_node = node.data.children.head
            while child_node
                stack.push([child_node, depth + 1])
                child_node = child_node.next
            end
        end
    end
    
    def fileSave(file_path)
        File.open(file_path, "wb") do |file|
            Marshal.dump(self, file)
        end
    end

    def self.fileLoad(file_path)
        File.open(file_path, "rb") do |file|
            Marshal.load(file)
        end
    end
    
end
