# ColorEcho
To add color to the command line output.  
This Library will extend the Kernel module's functions(#print, #puts, #p).   
required StringIO.   

Version: 0.0.1
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


#### CE::ch_bg::symbol   
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

#### CE::disable   
Turn off the function of this library.   

### Example
<pre>
#
# Example Code
#
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

# reset the color sequence
CE::disable

puts "hogehoge"
</pre>


