# color_echo
#
# To add color to the command line output.
# This Library will extend the Kernel module's functions(#print, #puts, #p).
# @autor: Kazuya Hotta (nyanko)
begin
    require "stringio"
rescue LoadError
    warn "color_echo required 'stringio.'"
end

require_relative "color_echo/version.rb"
require_relative "color_echo/const.rb"
require_relative "color_echo/variables.rb"
require_relative "color_echo/background.module.rb"
require_relative "color_echo/foreground.module.rb"
require_relative "color_echo/textattr.module.rb"
require_relative "color_echo/module_functions.rb"
require_relative "color_echo/override.rb"
