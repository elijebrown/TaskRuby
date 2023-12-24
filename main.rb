require_relative 'linkedList'
require_relative 'utils'
require_relative 'task'

def mainMenu()
    puts "Welcome to Task Manager, please select an option:"
    puts "a Add Task"
    puts "r Remove Task"
    puts "s Select Task"
    puts "v View Tasks"
    puts "q Quit"
    input = ARGF.gets.chomp # ARGF adds option for file input
    return input
end

def selectMenu()
    puts "a  Add Child/Sub Task"
    puts "r  Remove All Children/Sub Tasks"
    puts "v  View direct Child/Sub Tasks"
    puts "va View all Child/Sub Tasks"
    puts "q  Back to main menu"
    input = ARGF.gets.chomp # ARGF adds option for file input
    return input
end

def action(i, list)
    case i
    when 'a' # add task
        puts "Enter a task name: "
        n = ARGF.gets.chomp
        p = nil
        k = nil
        loop do
            puts "Enter parent task's name, 0 if none: "
            p = ARGF.gets.chomp
            break if p == '0'
            k = list.search(p)
            break if k
            puts "Error: Invalid parent task, try again"
        end
        parent_task = p == '0' ? nil : k
        new_task = Task.new(n, parent_task)
        list.add(new_task)
        puts "Added task: #{new_task.name}"

    when 'r' # remove task
        n = nil
        k = nil
        loop do
            puts "Enter name of task to remove: "
            n = ARGF.gets.chomp
            k = list.search(n)
            break if k
            puts "Error: Task not found, try again"
        end
        list.remove(k)
        puts "Removed task: #{n}"
    when 's'
        n = nil
        while ((k = list.search(n)) == nil)
            puts "Enter name of task: "
            n = ARGF.gets.chomp # get input
            if !k
                puts "Error: Task not found, try again"
            end
        end
        puts "Selected task: #{n.name}, choose an action, or quit to return to main menu"
        while true
            i = selectMenu()
            case i
            when 'a'
                n.add(Task.new(n.name))
            when 'r'
                n.clear()
            when 'v'
                n.printChildren()
            when 'va'
                n.printChildrenAll()
            when 'q'
                break
            else
                puts "Error: Invalid input"
            end
            
        end
        puts n.printTask()


        # search task return info but also store it so it can be manipulated
        # needs a submenu
    when 'v'
        list.printTasks
    when 'q'
        exit(0)
    else
        puts "Error: Invalid input"
    end
end

def main()
    list = TaskList.new()
    while true
        action(mainMenu(),list)
    end

end 

main()
