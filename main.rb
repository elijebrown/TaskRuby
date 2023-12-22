require_relative 'linkedList'
require_relative 'utils'
require_relative 'task'

def main()
    list = TaskList.new

    task1 = Task.new('task1', nil)
    list.add(task1)
    task3 = Task.new('task3')
    list.add(task3)
    task2 = Task.new('task2', task1)
    list.add(task2, task1)
    task4 = Task.new('task4', task2)
    list.add(task4, task2)
    list.printTasks

end 

# print list task size
# puts taskm.list.size
# list.add(task1)

# puts task1.printTask
main()