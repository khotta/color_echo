#
# Test Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

CE.once.ch :h_yellow, :h_red, :underscore
puts "decorated"
puts "switch off"

puts "\n"

CE.times(3).rainbow
puts "one"
puts "two"
puts "three"
puts "switch off"

puts "\n"

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
