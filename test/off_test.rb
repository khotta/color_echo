#
# Example Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

puts "* off - test\n\n"

CE.ch :h_green, :h_red, :underscore
puts "CE.ch :h_green, :h_red, :underscore"

CE.off :bg
puts "CE.off :bg"

puts "\n"

CE.ch :h_green, :h_red, :underscore
puts "CE.ch :h_green, :h_red, :underscore"

CE.off :fg
puts "CE.off :fg"

puts "\n"

CE.ch :h_green, :h_red, :underscore
puts "CE.ch :h_green, :h_red, :underscore"

CE.off
puts "CE.off"
