module CE
    @@allow_output = true
end

# override Kernel module functions
def print(*arg)
    CE.task.call(*arg)
end

def p(*arg)
    CE.task.call(*arg)
end

def puts(*arg)
    CE.task.call(*arg)
end

def printf(*arg)
    CE.task.call(*arg)
end

def putc(*arg)
    CE.task.call(*arg)
end
