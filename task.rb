require_relative 'linkedlist'
require_relative 'utils'

class Task
    MAX_STR = 32 # max string length

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

    def printTask()
        name_str = @name.ljust(32)
        total_hours_str = format_total_hours(@t_hours)
        session_str = @session.zero? ? 'n/a'.ljust(5) : @session.strftime('%H:%M')
        prev_session_str = format_total_hours(@sessionPrev)
        created_str = @created.strftime('%d-%m-%Y %H:%M')

        "|#{name_str} | #{total_hours_str} | #{session_str} | #{prev_session_str} | #{created_str}"
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
