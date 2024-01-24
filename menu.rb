require_relative 'linkedList'
require_relative 'utils'
require_relative 'task'
require_relative 'tasklist'
require_relative 'selectMenu'

def mainMenu()
    puts "Welcome to Task Manager, please select an option:"
    puts "a Add Task"
    puts "r Remove Task"
    puts "s Select Task"
    puts "t Start/Stop Tracking Task"
    puts "v View Tasks"
    puts "z Save Changes"
    puts "q Quit"
    input = ARGF.gets.strip # ARGF adds option for file input
    return input
end

def addM(list)
    puts "Enter a task name: "
    n = gets.strip
    parent = menuUtil("Enter parent task name or -1 to skip: ",list)
    if parent == -1
        task = Task.new(n)
    else
        task = Task.new(n, parent)
    end
    list.add(task)
    puts "Added task: #{task.name}"
end

def removeM(list)
    name = nil
    task = menuUtil("Enter task name to remove or -1 to go back: ",list)
    task == -1 ? return : list.remove(task)
    puts "Removed task: #{name}"
end

def selectM(list)
    task = menuUtil("Enter task name to select or -1 to go back: ",list)
    if task == -1 # go back
        return
    end
    puts "Selected task: #{task.name}, choose an action, or quit to return to main menu"  
    while true
        i = selectMenu()
        case i
        when 'a' #add
            addChild(list, task)
        when 'r' #remove
            removeChildren(list, task)
        when 'v' #view children
            task.printChildren()
        when 'va' #dfs view all children
            task.printAllChildren()
        when 'q' #exit
            break
        else
            puts "Error: Invalid input"
        end
    end
end
# simple start/stop, more advanced tracking options will be in select menu
def trackM(list)
    task = menuUtil("Enter task name to start/stop tracking or -1 to go back: ",list)
    if task == -1 # go back
        return
    end
    if task.session == 0 # start tracking
        task.trackStart()
        puts "Started tracking task: #{task.name}"
    else # stop tracking
        task.trackStop()
        puts "Stopped tracking task: #{task.name}"  
    end
    
end