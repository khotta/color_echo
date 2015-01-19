module CE
    @@allow_output = true
end

# override Kernel methods
def print(*arg)
    CE.task.call(*arg)
end

def p(*arg)
    CE.task.call(*arg)
end

def puts(*arg)
    CE.task.call(*arg)
end
