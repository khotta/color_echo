#
# Example Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

CE.fg :black
print "black "
CE.bg :black
puts "                "

CE.off(:bg).fg :gray
print "gray "
CE.bg :gray
puts "                "

CE.off(:bg).fg :red
print "red "
CE.bg :red
puts "                "

CE.off(:bg).fg :h_red
print "h_red "
CE.bg :h_red
puts "                "

CE.off(:bg).fg :green
print "green "
CE.bg :green
puts "                "

CE.off(:bg).fg :h_green
print "h_green "
CE.bg :h_green
puts "                "

CE.off(:bg).fg :yellow
print "yellow "
CE.bg :yellow
puts "                "

CE.off(:bg).fg :h_yellow
print "h_yellow "
CE.bg :h_yellow 
puts "                "

CE.off(:bg).fg :blue
print "blue "
CE.bg :blue
puts "                "

CE.off(:bg).fg :h_blue
print "h_blue "
CE.bg :h_blue
puts "                "

CE.off(:bg).fg :magenta
print "magenta "
CE.bg :magenta
puts "                "

CE.off(:bg).fg :h_magenta
print "h_magenta "
CE.bg :h_magenta
puts "                "

CE.off(:bg).fg :cyan
print "cyan "
CE.bg :cyan
puts "                "

CE.off(:bg).fg :h_cyan
print "h_cyan "
CE.bg :h_cyan
puts "                "

CE.off(:bg).fg :white
print "white "
CE.bg :white
puts "                "

CE.off(:bg).fg :h_white
print "h_white "
CE.bg :h_white
puts "                "
