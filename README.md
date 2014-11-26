# color_echo
To add color to the command line output.  
This Library will extend the Kernel module's functions(#print, #puts, #p).   
required StringIO.   

Version: 0.1.1   
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
#### CE.ch_fg :symbol
Change the foreground color to the your specified color.  
Alias is, CE.fg   
This method alias is available in version 0.2.0 on and after.   

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  

ex.) CE.ch_fg :red #=> foreground color will be changed red  

#### CE.ch_bg :symbol   
Change the background color to the your specified color.  
Alias is, CE.bg   
This method alias is available in version 0.2.0 on and after.   


* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  

ex.) CE.ch_bg :white #=> background color will be changed white  

#### CE.ch_tx :symbol   
Change the text attribute to the your specified decoration. 

* symbol list:    
    * bold  
    * underscore  
    * blink    
    * reverse_video 
    * concealed   

ex.) CE.ch_tx :blink #=> text blink on
Alias is, CE.tx   
This method alias is available in version 0.2.0 on and after.   


#### CE.ch :foreground [,:background [,:text_attribute]]  
Change collectively.  
This method is available in version 0.1.0 on and after.   
ex.) CE.ch :white, :green   

#### CE.disable   
Reset to set the color sequence.   
Alias is, CE::off, CE::reset   
This method alias is available in version 0.1.0 on and after.   

#### CE.unuse
Force ignore the function of this library.    
This method is available in version 0.1.0 on and after.   

#### CE.rainbow
Enjoy rainbow.     
This method is available in version 0.2.0 on and after.   

### Example
<pre>
#
# Example Code
#
require "color_echo"

# force ignore the function of this library
#CE::unuse

CE.ch :yellow
puts "fooooooooo"
puts "baaaaaaaar"

CE.ch :white, :red
print "testtesttest"

CE.ch :black, :cyan, :underscore
ary = ["Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate"]
p ary
print ary

CE.off

CE.fg :white
p "aaaaa", "bbbbb", "ccccc", "ddddd", "eeeee"

CE.bg :magenta
print ary

CE.reset
puts "hogehoge"

CE.tx :underscore
puts "hogehoge"

CE.ch :black, :white, :blink
puts &lt;&lt;EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua. 
EOM

CE.rainbow
puts "String will be rainbow! You can specify the argument only one."
puts ["rainbow", "is", "String", "only"]
puts "this is rainbow.", "This argument is ignored when rainbow mode."
CE.off
puts "Disable rainbow mode."
</pre>
