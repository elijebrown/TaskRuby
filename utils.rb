def caseInsensitive(str)
    str = str.delete(' ')
    str = str.downcase
    return str
end

# searches given list by name and returns task object or nil. Use a custom string to prompt the user
def menuUtil(promptString,list)
    n = nil
    k = nil
    loop do 
        puts promptString
        n = ARGF.gets.strip
        k = list.search(n)
        break if n == '-1' || k
        puts "Error: Task not found, try again"
    end
    if n == '-1'
        return -1
    else
        return k
    end
end