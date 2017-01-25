# Color Echo
Decorates command line output with ANSI escape sequence.   

Documents and all informations are as below =(^x^=    
http://colorecho.github.io

See on rubygems: https://rubygems.org/gems/color_echo

### Example Code
```ruby
require "color_echo"

CE.fg :red
puts "This is red."

CE.fg :yellow
puts "This is yellow."
puts "This is yellow too."
puts "This is yellow too."

CE.once.fg :green
puts "This is green."
puts "This is not green."
```

### You can choose 256 colors!!
![screen shot](/image/colorindex01.png)
![screen shot](/image/colorindex02.png)
