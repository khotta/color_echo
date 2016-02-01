begin
    require "stringio"
rescue LoadError
    warn "'stringio' is required for color_echo."
    exit 1
end

require_relative "const"
require_relative "variables"
require_relative "module/foreground"
require_relative "module/background"
require_relative "module/textattr"
require_relative "module/off"
require_relative "functions"
require_relative "internal"
require_relative "private_task"
