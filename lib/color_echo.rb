# color_echo
#
# Decorate the command line output with ANSI escape sequense.
# This Library will extend the Kernel module's functions(#print, #puts, #p).
# Required StringIO.
#
begin
    require "stringio"
rescue LoadError
    warn "color_echo required 'stringio'."
end

require_relative "color_echo/const.rb"
require_relative "color_echo/module/foreground.rb"
require_relative "color_echo/module/background.rb"
require_relative "color_echo/module/textattr.rb"
require_relative "color_echo/module/off.rb"
require_relative "color_echo/variables.rb"
require_relative "color_echo/module_functions.rb"
require_relative "color_echo/override.rb"
