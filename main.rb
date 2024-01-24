require_relative 'linkedList'
require_relative 'utils'
require_relative 'task'
require_relative 'tasklist'
require_relative 'menu'

def action(i, list)
    case i
    when 'a' # add task
        addM(list)
    when 'r' # remove task
        removeM(list)
    when 's'
        selectM(list)
    when 'v'
        list.printTasks
    when 'z'
        list.fileSave("task.bin")
        puts "Saved changes"
    when 'q'
        return -1 # returns exit flag
    when 't'
        trackM(list)
    else
        puts "Error: Invalid input"
    end
    # when 't' # tracking structure
    # end
    return 0
end

def main()
    list = TaskList.fileLoad("task.bin")
    menuFlag = 0
    while menuFlag == 0
        menuFlag = action(mainMenu(),list) 
    end
    #save
    list.fileSave("task.bin")

end 

main()
