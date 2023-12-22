require_relative 'linkedlist'
require_relative 'utils'
require_relative 'task'

list = TaskList.new

task1 = Task.new('task1', nil)

list.add(task1)

puts task1.printTask
