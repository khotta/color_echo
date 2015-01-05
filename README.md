# color_echo
Decorate the command line output with ANSI escape sequence.    
This Library will extend the Kernel module's functions(#print, #puts, #p).   
Required StringIO.   

Version: 0.6.0   
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
 - Alias -> fg (available in v0.2.0 on and after)     
 - Parameter -> Symbol    
 - Return -> self    

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white   
    
    available in v0.3.0 on and after.    
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   

    available in v0.4.0 on and after.   
    * index[1-256]   

ex.) CE.ch_fg :red #=> foreground color will be changed red  




#### CE.ch_bg :symbol   
Change the background color to the your specified color.     
 - Alias -> bg (available in v0.2.0 on and after)     
 - Parameter -> Symbol    
 - Return -> self    

* symbol list:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  
    
    available in v0.3.0 on and after.    
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   

    available in v0.4.0 on and after.   
    * index[1-256]   

ex.) CE.ch_bg :white #=> background color will be changed white  



#### CE.ch_tx :symbol   
Change the text attribute to the your specified decoration.     
 - Alias -> tx (available in v0.2.0 on and after)     
 - Parameter -> Symbol    
 - Return -> self    

* symbol list:    
    * bold  
    * underscore  
    * blink    
    * reverse_video 
    * concealed   

ex.) CE.ch_tx :blink #=> text blink on   


#### CE.ch foreground [,background [,text_attribute]]   
Change collectively.     
This method is available in v0.1.0 on and after.   
 - Parameter foreground -> Symbol     
 - Parameter background -> Symbol     
 - Parameter text_attribute -> Symbol     
 - Return -> self    

ex.) CE.ch :white, :green   


#### CE.reset([target={:fg|:bg]})  
Reset to set the escape sequence.   
 - Alias -> off, disable (available in v0.1.0 on and after)    
 - Parameter target -> Symbol (available in v0.3.0 on and after)     
 - Return -> self    

ex.) CE.reset :fg #=> foreground color will be reset.    
ex.) CE.reset :bg #=> background color will be reset.    
ex.) CE.reset     #=> All reset the set escape sequence.    


#### CE.once     
Reset automatically after once output.     
This method is available in v0.5.0 on and after.   
 - Return -> self    

#### CE.times(cnt)
Reset automatically after cnt times output.     
This method is available in v0.5.0 on and after.   
 - Parameter cnt -> Integer    
 - Return -> self    

```ruby   
CE.once.ch :h_yellow, :h_red, :underscore
puts "decorated"
puts "switch off"

puts "\n"

CE.times(3).rainbow
puts "one"
puts "two"
puts "three"
puts "switch off"
```
![screen shot](/images/result_off.png)

#### CE.unuse
Force ignore the function of this library.    
This method is available in v0.1.0 on and after.   


#### CE.rainbow
Text color will change to rainbow color.   
~~String Object only. Non-string object is excluded.~~    
-> Can v0.2.4 on and after be able to specify a non-string when rainbow mode.   
This method is available in v0.2.0 on and after.   


### Can to select 256 colors!    
Please install color_echo and do `color_echo -l`.   
ex.) CE.ch :index197, :index230    
![screen shot](/images/color_index.png)
![screen shot](/images/color_index2.png)

### You can run on the command line
<pre>
    * Usage
        color_echo [options]

    * Options
        -v:
            Display version of color_echo.

        --symbol_list, -s
            Display symbol list that can to specify.

        --index_list, -l
            Display color index list that can to specify.

If your server using the rbenv, You have to do `rbenv rehash`.
This is available in v0.6.0 on and after.
</pre>

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
```

#### Result

![screen shot](/images/screenshot.png)

## Release Note
* v0.6.0, 2014-01-05
    * Added command line tool.

* v0.5.0, 2014-12-16
    * Added a new method -> \#once, \#times

* v0.4.0, 2014-12-11
    * Can to select 256 colors.   

* v0.3.0, 2014-12-08
    * High color can now be selected.    
    * Multiple text attribute can now be selected.   
    * Added parameter to the #reset method.   

* v0.2.4, 2014-12-04
    * Can now be able to specify a non-string when rainbow mode.
    * Cab now be able to take over the setting of other types of sequence when rainbow mode.

* v0.2.3, 2014-12-02
    * Fixed small bugs.
