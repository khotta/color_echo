#
# Example Code
#
require "color_echo"

# force ignore the function of this library
#CE.unuse

CE.ch :yellow
puts "fooooooooo"
puts "baaaaaaaar"
puts "AAAAA", "BBBBB", "CCCCC"

CE.ch :white, :red
print "fooooooooo"
print "baaaaaaaar"
print "AAAAA", "BBBBB", "CCCCC"

CE.ch :black, :magenta, :underscore
p "fooooooooo"
p "baaaaaaaar"
p "AAAAA", "BBBBB", "CCCCC"

ary = ["Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate"]

CE.off
puts "switch off all colors and attribute."

CE.fg :red
puts ary

CE.bg :cyan
print ary

CE.tx :underscore
p ary

CE.fg(:black).bg(:white).tx(:blink)
puts <<EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.
EOM

CE.off
CE.rainbow
puts "fooooooooo"
puts "baaaaaaaar"
puts "AAAAA", "BBBBB", "CCCCC"
puts ary

print "fooooooooo"
print "baaaaaaaar"
print "AAAAA", "BBBBB", "CCCCC"
print ary

p "fooooooooo"
p "baaaaaaaar"
p "AAAAA", "BBBBB", "CCCCC"
p ary

puts <<EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.
EOM

CE.tx(:underscore).bg(:black)
CE.rainbow
hash = {:foo => [111, 222, 333], :bar => {:str => String}}
p hash
p "fooooooo", ["AAA", "BBB", "CCC"]

CE.off
puts "Disable rainbow mode."
