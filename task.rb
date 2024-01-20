require_relative 'linkedList'
require_relative 'utils'
require 'set'

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

    def printChildren()
        if @children.size == 0
            return puts "no children"
        else
            n = @children.head 
            while n != nil
                puts n.printTask
                n = n.next
            end
        end
    end

    def printAllChildren()
        if @children.size == 0
            return puts "no children"
        else
            n = @children.head 
            while n != nil
                puts n.data.printTask
                n.data.printAllChildren
                n = n.next
            end
        end
    end


end

