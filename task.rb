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
        t_hoursFormatted = formatHours(@t_hours)
        sessionFormatted = @session.zero? ? 'n/a'.ljust(5) : @session.strftime('%H:%M')
        prevFormatted = formatHours(@sessionPrev)
        created_str = @created.strftime('%d-%m-%Y')

        "#{name_str}  #{t_hoursFormatted} | #{sessionFormatted} | #{prevFormatted} | #{created_str}"
    end

    def formatHours(total)
        hours = total.to_i  # Extracts the hour part
        diff = total - hours # Extracts the fractional hour part
        minutes = (diff * 60).round
      
        # Formats the string to have hours and minutes
        format('%02d:%02d', hours, minutes)
      end
      

    def printChildren()
        if @children.size == 0
            return puts "no children"
        else
            n = @children.head 
            while n != nil
                puts n.data.printTask()
                n = n.next
            end
        end
    end

    def printAllChildren()
        n = @children.head 
        while n != nil
            puts n.data.printTask
            n.data.printAllChildren
            n = n.next
        end
    end

    def trackStart()
        @session = Time.now
    end

    def trackStop()
        diff = Time.now - @session
        time = diff/3600.0
        @sessionPrev = time
        @session = 0 #(aka nil)
        @t_hours += time

        # parent adding structure
        temp = @parent
        while temp != nil
            temp.t_hours += time
            temp = temp.parent
        end
    end

    def printTime()
        # print hours and minutes
        puts "#{@name} tracked for #{@t_hours} hours"
    end




end

