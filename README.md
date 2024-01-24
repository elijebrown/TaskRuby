## Preamble  
Code Authored by Elijah Bruhn.  
  
This program is a very light and easy to install utility. TaskRuby allows you to succinctly keep track of your time. I created this program so that I would be able to record how many hours I spend on a given course in University, so that I could plan my time better. TaskRuby is great for my use-case, or a professional who needs to track billing hours for multiple different clients. There's no need to fuss around with creating an excel spreadsheet and downloading (and paying for) MS office on all your devices to track your time; TaskRuby is an out of the box solution for your organizational needs!  
  
TaskRuby does not use any additional Ruby Gems, which means that it is compatible with most versions of Ruby, including the native versions installed on your Mac or Linux machines!

## Execution  
- To start the program, ensure you have ruby installed on your machine with `ruby -v`  
- In a terminal window, ensure you are in the same directory as the source files provided in the GitHub repository
- Execute the command `ruby main.rb` to run the program

## Program Operation
- Upon execution, you will be prompted with the *Main Menu*, where you can quickly access the most important commands with a single input, such as:
    - add/remove task
    - start/stop tracking task
    - view task list
    - save changes (save without exiting)
    - quit program
- There is also a select task function that has additional features tailored to editing individual tasks
- To stay organized, you are encouraged to take advantage of the Task/SubTask features. When creating a new task, you can designate a *parent* task. This allows you to group smaller tasks under larger ones. Note that if you are tracking a sub/child task, the tracked session time will be added to all parent tasks, up to the root parent. Below is an example of how you might organize your TaskRuby tasks for a comprehensive workflow:  
  
- COMP2402 - Data Structures and Algorithms (*the parent task*)
    - Assignment 1 (*a smaller sub-task*)
        - Part 1
        - Part 2
    - Exam Study
        - Heaps
        - Binary Trees
        - Graphs
  
In this example, if you started a tracking session while studying Graphs, the tracked study time would also be added to the Exam Study task and the 'root' parent task, COMP2402.. 

## List of Source Files
- linkedList.rb: Contains a simple doubly-linked-list implementation
- task.rb:       Contains the Task class and its member functions
- taskList.rb:   Contains the TaskList class and its member functions
- menu.rb:       Contains all of the functions defined in the main menu of the program
- selectMenu.rb: Contains all of the functions defined in the select task submenu
- utils.rb:      Contains generic utility functions that are used repeatedly throughout the program.
- LICENSE:       Read the license file for terms and conditions regarding open-source use of this program.

## Future Updates:
- An executable package with a setup guide. Nice and easy. 
- A settings config file: Customize various settings to tailor your user-experience to your exact needs

