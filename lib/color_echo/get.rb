begin
    require "stringio"
rescue LoadError
    warn "color_echo required 'stringio'."
end

require_relative "const"
require_relative "variables"
require_relative "module/foreground"
require_relative "module/background"
require_relative "module/textattr"
require_relative "module/off"
require_relative "functions"
require_relative "internal"
