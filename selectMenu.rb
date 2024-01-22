def selectMenu()
    puts "a  Add Child/Sub Task"
    puts "r  Remove All Children/Sub Tasks"
    puts "v  View direct Child/Sub Tasks"
    puts "va View all Child/Sub Tasks"
    puts "q  Back to main menu"
    input = ARGF.gets.strip # ARGF adds option for file input
    return input
end

def addChild(list, parent)
    puts "Enter a task name: "
    n = gets.strip
    task = Task.new(n, parent)
    list.add(task)
    puts "Added task: #{task.name} to #{parent.name}"
end

def removeChildren(list, parent)
    while parent.children.head != nil
        puts "Removed task: #{parent.children.head.data.name}"
        list.remove(parent.children.head.data)
        parent.children.head = parent.children.head.next
    end
end