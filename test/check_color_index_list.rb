#
# Example Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

CE.rainbow
cnt = 134
padding = " " * 2
mes = "OK, Let me check color index list... :)"
puts padding + "-" * cnt
puts padding + " " * ((cnt - mes.size)/2) + mes
puts padding + "-" * cnt

print padding
256.times do |i|
    num = i + 1
    CE.fg "index#{num}".intern
    print "index#{num}" + " " * (4 - num.to_s.size)
    CE.bg "index#{num}".intern
    print " " * 5
    CE.off
    print " " * 3

    if num % 8 == 0
        print $/ + $/
        print padding if num != 256
    end
end
CE.off
