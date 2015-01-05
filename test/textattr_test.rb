#
# Test Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

CE.tx :underscore
puts "CE.tx :underscore"

CE.off
puts "\n"

CE.ch :h_cyan, :h_red, :underscore
puts "CE.ch :white, :h_red, :underscore"

CE.off
puts "\n"

CE.ch :h_cyan, :h_red, [:underscore, :blink, :bold]
puts "CE.ch :h_cyan, :h_red, [:underscore, :blink, :bold]"

CE.off
puts "\n"

CE.tx [:underscore, :blink, :bold]
puts "CE.tx [:underscore, :blink, :bold]"

CE.off
puts "\n"

CE.tx :underscore
puts "CE.tx :underscore"
CE.tx :blink
puts "CE.tx :blink"
