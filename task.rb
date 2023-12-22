require_relative 'linkedList'
require_relative 'utils'

class Task
    MAX_STR = 12 # max string length
    attr_accessor :name, :parent, :children, :t_hours, :session, :sessionPrev, :created

    # String name, TaskObject parent
    def initialize(name, parent=nil)
        @name = name
        @parent = parent # nil if no parent
        @children = DoublyLinkedList.new # child list
        @t_hours = 0 # total hours
        @session = 0; # session starting timestamp
        @sessionPrev = 0; # previous session time (hours)
        @created = Time.now
    end

    def printTask()
        name_str = @name.ljust(MAX_STR)
        total_hours_str = format_total_hours(@t_hours)
        session_str = @session.zero? ? 'n/a'.ljust(5) : @session.strftime('%H:%M')
        prev_session_str = format_total_hours(@sessionPrev)
        created_str = @created.strftime('%d-%m-%Y %H:%M')

        "#{name_str}  #{total_hours_str} | #{session_str} | #{prev_session_str} | #{created_str}"
    end

    private

    def format_total_hours(hours)
        if hours.is_a? Integer
            hours.to_s.rjust(4)
        else
            integer_part = hours.to_i
            fractional_part = hours - integer_part
            fractional_str = fractional_part == 0.5 ? ' and a half' : ''
            "#{integer_part}#{fractional_str}".rjust(4)
        end
    end

end

# class: TaskList
class TaskList
    def initialize()
        @hash = Hash.new
        # create double linked list
        @list = DoublyLinkedList.new
    end

    # add task
    def add(task, parent = nil) # if no parent supplied, nil
        # add to hash
        key = caseInsensitive(task.name)
        @hash[key] = task
        if parent
            parent.children.add(task)
        # add to list
        else
            @list.add(task)
        end
    end

    # remove task
    def remove(task, parent = nil) # if no parent supplied, nil
        # remove from hash
        key = caseInsensitive(task.name)
        @hash.delete(key)
        if parent
            parent.children.remove(task)
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
        stack = []
        stack.push([@list.head, 0]) # Start from the head of the list with depth 0
    
        while !stack.empty?
            node, depth = stack.pop
            next if node.nil?
            
            if depth == 0
                puts "---------------------------------------------------------"
            end
            # You can use 'depth' here as needed, for example, to indent the output
            puts "#{' ' * depth * 2}#{node.data.printTask()}"
    
            # Add the next node in the main list to the stack with the same depth
            stack.push([node.next, depth]) if node.next
    
            # Add all children of the current node to the stack with incremented depth
            child_node = node.data.children.head
            while child_node
                stack.push([child_node, depth + 1])
                child_node = child_node.next
            end
        end
    end
    
    
    
end
