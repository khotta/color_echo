# color_echo
color_echo はコマンドライン出力に色をつけるライブラリです。    

Version: 2.0.0
Compliant Rubys Version: 2.0.0, 2.1.0 (for Linux)  
License: MIT  
Gems repository: http://rubygems.org/gems/color_echo

## Installation

Add this line to your application's Gemfile:

    gem 'color_echo'

Or install it yourself as:

    $ gem install color_echo

## 256色の色の選択が可能です
color_echo をインストールした後 `colorecho -l` と実行してみてください。   
![screen shot](/images/color_index.png)
![screen shot](/images/color_index2.png)

## 特定のワードだけを色づけすることができます   

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



## getモード    
例えば `CE.fg(:index100)` のように実行すれば、color_echoは #p, #puts, #printメソッドの出力を自動で色づけします。     
この機能を望まない場合は `require "color_echo"` ではなく、 `require "color_echo/get"` にしてください。     
CE.getのパラメータに指定した色のシーケンスコードをつけて返すようになります。    
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


## コマンドラインインターフェース    
color_echo は Rubyの gemライブラリですが、ターミナルで実行できるようコマンドラインインターフェースが実装されています。    
詳しくは、コマンドラインで `color_echo -h` と実行してみてください。   
![screen shot](/images/cli1.png)
![screen shot](/images/cli2.png)


## module functions

#### CE.pickup(target, foreground=:red, backgruond=nil, *text_attribute)    
パラメータtargetとマッチする文字列を指定した文字色、背景色、テキスト装飾で色づけします。     
使用できる文字色等は、`colorecho -s` または `colorecho -l` で確認できます。    
`CE.rainbow` がコールされている場合はこの機能は無視されます。    
例: `CE.pickup(/^foo/, :index100, nil, :bold)`    
 - Parameter target -> string|regexp or array of them
 - Parameter foreground -> symbol|nil
 - Parameter background -> symbol|nil
 - Parameter text_attribute -> symbol or array of them
 - Return -> self


#### CE.hitline(foreground=nil, background=nil, *text_attribute)    
CE.pickupでマッチした行に対して、指定した文字色、背景色、テキスト装飾で色づけします。    
 - Parameter foreground -> symbol|nil    
 - Parameter background -> symbol|nil    
 - Parameter text_attribute -> symbol or array of them    
 - Return -> self   


#### CE.ch_fg(foreground)
文字色を指定した色に変更します。     
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
背景色を指定した色に変更します。   
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



#### CE.ch_tx(*text_attribute)        
テキスト装飾を指定した色に変更します。    
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


#### CE.ch(foreground, background=nil, *text_attribute)
文字色、背景色、テキスト装飾を指定したものに変更します。    
 - Parameter foreground -> symbol|nil    
 - Parameter background -> symbol|nil     
 - Parameter text_attribute -> symbol or array of them
 - Return -> self    

ex.) CE.ch :white, :green   
ex.) CE.ch :h_red, nil, :blink   


#### CE.reset(scope=:all)
指定した色やテキスト装飾をリセットします。リセットする範囲はスコープで決まります。    
デフォルトは :all ですのですべての設定がリセットされます。    
 - Alias -> off, disable    
 - Parameter scope -> symbol or array of them
 - Return -> self    

ex.) CE.reset            #=> reset all of the set escape sequence.    
ex.) CE.reset :fg        #=> foreground color will be reset.     
ex.) CE.reset :bg        #=> background color will be reset.     
ex.) CE.reset :tx        #=> text attribute will be reset.    
ex.) CE.reset :pickup    #=> the pickups text will be reset.    
ex.) CE.reset :hitline   #=> sequence code list will be reset that is used at match line by CE.pickup.    
ex.) CE.reset :rainbow   #=> rainbow mode will be reset and swich off.    
ex.) CE.reset [:fg. :tx] #=> foreground color and ext attribute will be reset.     


#### CE.once     
一度だけ設定した装飾を適用します。      
これは CE.times(1) と同様です。    
 - Return -> self    


#### CE.times(cnt)
指定した回数だけ設定した装飾を適用します。    
 - Parameter cnt -> integer    
 - Return -> self    


#### CE.enable_refresh(scope=:all)
与えられた入力に対して可能な限りシーケンスコードを取り除きます。    
 - Parameter scope -> symbol
    - :all: いかなる時もシーケンスコードを取り除きます。   
    - :prematch: CE.pickupで指定したパターンにマッチした時だけシーケンスコードを取り除きます。    
 - Return -> self   


#### CE.disable_refresh
与えられた入力に対してシーケンスコードを取り除きません。デフォルトはこの挙動です。    
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
このメソッドがコールされた時点で color_echo の機能を無効にします。      


#### CE.rainbow
出力をレインボーにします。     
 - Return -> self


#### CE.get(text)    
設定されたシーケンスコードをつけて返します。`require "color_echo/get"` を読み込んだ時だけ使えるメソッドです。     
 - Parameter text -> string 
 - Return -> string


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
* v2.0.0, 2014-05-
    * 次の新しいメソッドを追加しました -> CE::hitline, CE.enable_refresh, CE.disable_refresh    
    * CE.reset のスコープに CE.pickupで指定したパターンとマッチした行に適用するシーケンスコードをリセットする ':hitline' を追加しました。       
    * tailfコマンドと colorechoコマンドを複数パイプで渡すと出力がバッファに溜まりリアルタイムで出力されない問題を解消しました。    
    * 正しくないエンコーディングを検知した際に対話モードが終了してしまう問題を解消しました。    
    * 対話モードを ctl + c で終了した時の WARNINGを表示しないようにしました。    
    * コマンドラインインターフェースのデフォルトの文字色をいかなる時も 'yellow' になるようにしました。    

* v1.3.0, 2014-02-06
    * Change some options help messages.
    * You can call 'colorecho' as 'color_echo' in command line interface.

* v1.2.0, 2015-01-28
    * Add -e option.

* v1.1.0, 2015-01-27
    * Modified to output the argument when the standard input is hit.
    * Add --stripe option in the command line interface.
    * Change the delimiter of long option with a hyphen -> -symbol-list,--index-list; Can to specify also underscore as before.

* v1.0.0, 2015-01-23
    * Add command line interface.

* v0.9.0, 2015-01-19
    * Add a mode to receive as the words with ANSI escape sequence; without output to display.

* v0.8.0, 2015-01-14
    * Change for the specified arguments of reset method.
    * Fix small bugs.

* v0.7.0, 2015-01-08
    * Add new method -> pickup
    * Add new symbol that can to specify in reset method of first parameter -> CE.reset(:pickup)

* v0.6.0, 2015-01-05
    * Add command line tool.

* v0.5.0, 2014-12-16
    * Add a new method -> \#once, \#times

* v0.4.0, 2014-12-11
    * Add 256 colors.

* v0.3.0, 2014-12-08
    * Add high colors.
    * Can to select multi value in ch_tx method.
    * Add parameter to the #reset method.   

* v0.2.4, 2014-12-04
    * Can to specify a non-string when rainbow mode.
    * Cab take over the setting of other types of sequence when rainbow mode.

* v0.2.3, 2014-12-02
    * Fix small bugs.

* v0.2.0
    * Added new method -> rainbow
    * Added some method alias.

* v0.1.0
    * Added new method -> ch, unuse
    * Added some method alias.
