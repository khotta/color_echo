# color_echo
Using the ANSI escape sequence and give it a color on the command line output.       
This Library will extend the Kernel module's functions(#print, #puts, #p).   
Required StringIO.   

Version: 0.4.0   
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
Alias is, fg   
This method alias is available in version 0.2.0 on and after.   
return self.   

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white   
    
    available in version 0.3.0 on and after.    
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   

    available in version 0.4.0 on and after.   
    * index[1-256]   

ex.) CE.ch_fg :red #=> foreground color will be changed red  

#### CE.ch_bg :symbol   
Change the background color to the your specified color.  
Alias is, bg   
This method alias is available in version 0.2.0 on and after.   
return self.   


* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  
    
    available in version 0.3.0 on and after.    
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   

    available in version 0.4.0 on and after.   
    * index[1-256]   

ex.) CE.ch_bg :white #=> background color will be changed white  



#### CE.ch_tx :symbol   
Change the text attribute to the your specified decoration. 

* symbol list:    
    * bold  
    * underscore  
    * blink    
    * reverse_video 
    * concealed   

Alias is, tx   
This method alias is available in version 0.2.0 on and after.   
return self.   
ex.) CE.ch_tx :blink #=> text blink on   



#### CE.ch foreground [,background [,text_attribute]]   
Change collectively.  
ex.) CE.ch :white, :green   
This method is available in version 0.1.0 on and after.   
return self.   


#### CE.reset([target={:fg|:bg]})     
Reset to set the escape sequence.   
Alias is, off, disable      
This method alias is available in version 0.1.0 on and after.   
Parameters can v0.3.0 on and after be specified.   
ex.) CE.reset :fg #=> foreground color will be reset.    
ex.) CE.reset :bg #=> background color will be reset.    
ex.) CE.reset     #=> All reset the set escape sequence.    
return self.   


#### CE.unuse
Force ignore the function of this library.    
This method is available in version 0.1.0 on and after.   


#### CE.rainbow
Text color will change to rainbow color.   
~~String Object only. Non-string object is excluded.~~    
-> Can v0.2.4 on and after be able to specify a non-string when rainbow mode.   
This method is available in version 0.2.0 on and after.   


### Can to select 256 colors!    
Please install color_echo and do `ruby test/check_color_index_list.rb`.    
ex.) CE.ch :index197, :index230    
![screen shot](/images/color_index.png)
![screen shot](/images/color_index2.png)


### Example
```ruby
#
# Example Code
#
#require "color_echo"

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
puts "turn off all colors and attribute."

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
```

#### Result

![screen shot](/images/screenshot.png)

## Release Note
* v0.4.0, 2014-12-11
    * Can to select 256 colors.   

* v0.3.0, 2014-12-08
    * High color can now be selected.    
    * Multiple text attribute can now be selected.   
    * Add parameter to the #reset method.   

* v0.2.4, 2014-12-04
    * Can now be able to specify a non-string when rainbow mode.
    * Cab now be able to take over the setting of other types of sequence when rainbow mode.

* v0.2.3, 2014-12-02
    * Fixed small bugs.
