# color_echo
To add color to the command line output.  
This Library will extend the Kernel module's functions(#print, #puts, #p).   
required StringIO.   

Version: 0.1.0   
Compliant Rubys Version: 1.9.3, 2.0.0, 2.1.0 (for Linux)  
License: MIT  
Gems repository: http://rubygems.org/gems/color_echo

## Installation

Add this line to your application's Gemfile:

    gem 'color_echo'

Or install it yourself as:

    $ gem install color_echo

## Usage

### module functions
#### CE::ch_fg :symbol
Change the foreground color to the your specified color.  

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  

ex.) CE::ch_fg :red #=> foreground color will be changed red  


#### CE::ch_bg :symbol   
Change the background color to the your specified color.  

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  

ex.) CE::ch_bg :white #=> background color will be changed white  

#### CE::ch_tx :symbol   
Change the text attribute to the your specified decoration. 

* symbol list:    
    * bold  
    * underscore  
    * blink    
    * reverse_video 
    * concealed   

ex.) CE::ch_tx :blink #=> text blink on

#### CE::ch :foreground [,:background [,:text_attribute]]  
Change collectively.  
This method is available in version 0.1.0.   
ex.) CE:ch :white, :green   

#### CE::disable   
Reset to set the color sequence.   
Alias is, CE::off, CE::reset   
This method alias is available in version 0.1.0.   

#### CE::not_use    
Force ignore the function of this library.    
This method is available in version 0.1.0.   

### Example
<pre>
#
# Example Code
#
require "color_echo"

# force ignore the function of this library
#CE::not_use

# change the foreground color to 'yellow'
CE::ch_fg :yellow

puts "fooooooooo"
puts "baaaaaaaar"

# change the foreground color to 'white'
CE::ch_fg :white
# change the foreground color to 'red'
CE::ch_bg :red

print "testtesttest"

# change the foreground color to 'black'
CE::ch_fg :black
# change the foreground color to 'cyan'
CE::ch_bg :cyan
# change the text attribute 'underscore'
CE::ch_tx :underscore

ary = ["aaa", "bbb", "ccc"]
p ary
print ary

CE::ch_bg :blue
CE::ch_fg :white
p "aaaaa", "bbbbb", "ccccc", "ddddd", "eeeee"

# reset the color sequence
CE::off

puts "hogehoge"

# to change collectively
CE::ch :black, :white, :blink

puts &lt;&lt;EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua. 
EOM
</pre>


