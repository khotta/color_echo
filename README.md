# color_echo
Decorate the command line output with ANSI escape sequence.     
String that is output by "print, puts, p" method is decorated.    
It is also can to decorate only your specified words!   

Version: 0.9.0   
Compliant Rubys Version: 2.0.0, 2.1.0 (for Linux)  
License: MIT  
Gems repository: http://rubygems.org/gems/color_echo

## Installation

Add this line to your application's Gemfile:

    gem 'color_echo'

Or install it yourself as:

    $ gem install color_echo


## Can to select 256 colors!    
Please install color_echo and do `color_echo -l`.   
ex.) CE.ch :index197, :index230    
![screen shot](/images/color_index.png)
![screen shot](/images/color_index2.png)

## You can to decorate your specified words!   

```ruby
CE.fg(:h_cyan).pickup("color_echo", :h_white, :red, :underscore).pickup("COLOR_ECHO", :h_yellow)

puts <<EOS
xxxxxxxxxxxxxxxxxcolor_echoxxxxxxxxxxxxxxxxxxxxxxxx
xxxxcolor_echoxxxxxxxCOLOR_ECHOxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxcolor_echoxxxxxxxxxxcolor_echoxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
EOS
```
![screen shot](/images/pickup1.png)



## Do you want to return words with the escape sequence?

Please write `require "color_echo/get"` rather than `require "color_echo"`.
```ruby
require "color_echo/get"

greet  = CE.fg(:yellow).get("Hello")
name   = CE.ch(:h_blue, :gray).get("Foo")
myname = CE.tx(:underscore).rainbow.get("Bar")

puts greet + ", " + name + "!"
puts "My name is " + myname

output = CE.fg(:blue).pickup(/color$/, :index199).pickup(/^color/, :h_green).get("color color color")
puts "output is -> " + output
```
![screen shot](/images/get1.png)


## You can run on the command line
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
</pre>


## module functions

#### CE.pickup(target, foreground=:red, backgruond=nil, text_attribute)    
To decorate the words that specfied in the String or Regexp or Array of them.    
If state of enable rainbow mode, This feature is disabled.    
 - Parameter target -> string|regexp or array of them
 - Parameter foreground -> symbol|nil
 - Parameter background -> symbol|nil
 - Parameter text_attribute -> symbol or array of them
 - Return -> self


#### CE.ch_fg(foreground)
Change the foreground color to the your specified color.    
 - Alias -> fg    
 - Parameter foreground -> symbol    
 - Return -> self    

* symbol list of foreground:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white   
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   
    * index[1-256]   

ex.) CE.ch_fg :red #=> foreground color will be changed red  




#### CE.ch_bg(background)   
Change the background color to the your specified color.     
 - Alias -> bg   
 - Parameter background -> symbol    
 - Return -> self    

* symbol list of background:    
    * black  
    * red   
    * green   
    * yellow  
    * blue   
    * magenta  
    * cyan  
    * white  
    * gray   
    * h_red   
    * h_green   
    * h_yellow   
    * h_blue   
    * h_magenta   
    * h_cyan   
    * h_white   
    * index[1-256]   

ex.) CE.ch_bg :white #=> background color will be changed white  



#### CE.ch_tx(text_attribute)        
Change the text attribute to the your specified decoration.     
 - Alias -> tx   
 - Parameter text_attribute -> symbol or array of them   
 - Return -> self    

* symbol list of text attribute:    
    * bold  
    * underscore  
    * blink    
    * reverse_video 
    * concealed   

ex.) CE.ch_tx :blink #=> text blink on   


#### CE.ch foreground [,background [,text_attribute]]   
Change collectively.     
 - Parameter foreground -> symbol|nil    
 - Parameter background -> symbol|nil     
 - Parameter text_attribute -> symbol or array of them
 - Return -> self    

ex.) CE.ch :white, :green   
ex.) CE.ch :h_red, nil, :blink   


#### CE.reset(scope=:all)
Reset to set the escape sequence.   
 - Alias -> off, disable    
 - Parameter scope -> symbol or array of them
 - Return -> self    

ex.) CE.reset            #=> reset all of the set escape sequence.    
ex.) CE.reset :fg        #=> foreground color will be reset.     
ex.) CE.reset :bg        #=> background color will be reset.     
ex.) CE.reset :tx        #=> text attribute will be reset.    
ex.) CE.reset :pickup    #=> pickup text will be reset.    
ex.) CE.reset :rainbow   #=> rainbow mode will be reset and swich off.    
ex.) CE.reset [:fg. :tx] #=> foreground color and ext attribute will be reset.     


#### CE.once     
Reset automatically after once output.     
 - Return -> self    


#### CE.times(cnt)
Reset automatically after cnt times output.     
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
 - Return -> self


#### CE.rainbow
Text color will change to rainbow color.   



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
* v0.9.0, 2014-01-19
    * Added a mode to receive as the words with ANSI escape sequence; without output to display.

* v0.8.0, 2014-01-14
    * Changed for the specified arguments of reset method.
    * Fixed small bugs.

* v0.7.0, 2014-01-08
    * Added new method -> pickup
    * Added new symbol that can to specify in reset method of first parameter -> CE.reset(:pickup)

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

* v0.2.0
    * Added new method -> rainbow
    * Added some method alias.

* v0.1.0
    * Added new method -> ch, unuse
    * Added some method alias.
