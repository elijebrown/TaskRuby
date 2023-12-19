require_relative linkedlist, utils

class Task
    # String name, TaskObject parent
    def initialize(name, parent)
        @name = name
        @parent = parent # nil if no parent
        @children = DoublyLinkedList.new # child list
        @t_hours = 0 # total hours
        @session = 0; # session starting timestamp
        @sessionPrev = 0; # previous session time (hours)
        @created = Time.now
    end

    def removeAllChildren()
        @children = DoublyLinkedList.new # this feels so wrong coming from C... 
    end
    
end

# class: TaskList
class TaskList
    def initialize()
        @hash = Hash.new
        # create double linked list
        @list = DoublyLinkedList.new
    end

    # add task (no parent)
    def add(task)
        # add to hash
        key = caseInsensitive(task.name)
        @hash[key] = task
        # add to list
        @list.add(task)
    end

    # add to parent
    def add(task, parent)
        # add to hash
        key = caseInsensitive(task.name)
        @hash[key] = task
        # add to parent's child list
        parent.children.add(task)
    end

    # remove task (no parent)
    def remove(task)
        # remove from hash
        key = caseInsensitive(task.name)
        @hash.delete(key)
        # remove from list
        @list.remove(task)
    end

    # remove from parent
    def remove(task, parent)
        # remove from hash
        key = caseInsensitive(task.name)
        @hash.delete(key)
        # remove from parent's child list
        parent.children.remove(task)
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

end
