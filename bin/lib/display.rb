@explain_v      = %(Show version of color_echo.)
@explain_s      = %(Show symbol list that can to specify.)
@explain_l      = %(Show color index list that can to specify.)
@explain_p      = %(Decorate your specified wrods. You can use this option any number of times.)
@explain_H      = %(Highlight the match lines by -p options word. format -H "fg_color, bg_color, text_attribute[,...]")
@explain_f      = %(Specify the foreground color.)
@explain_b      = %(Specify the background color.)
@explain_t      = %(Specify the text attributes.)
@explain_w      = %(Interactive mode. Break word is -> exit, quit, bye; Or Ctl + c)
@explain_n      = %(Do not output the trailing newline.)
@explain_e      = %(Enable interpretation of line feed.)
@explain_h      = %(Show help message with example.)
@explain_c      = %(Try to remove the sequence code from the given.)
@explain_stripe = %(Decorate on every other line. pickup option is ignored.)
@padding        = " " * 4
@explain_usage  = @padding * 2 + %(colorecho [options] message) + $/
@explain_usage += @padding * 2 + %(colorecho [options] < /path/to/file) + $/
@explain_usage += @padding * 2 + %(echo "message" | colorecho [options]) + $/
@explain_usage += @padding * 2 + %(colorecho -v) + $/
@explain_usage += @padding * 2 + %(colorecho -s) + $/
@explain_usage += @padding * 2 + %(colorecho -l) + $/
@explain_usage += @padding * 2 + %(colorecho -h)

def version
    require_color_echo

    puts CE::VERSION
    exit 0 
end

def usage
    require_color_echo

    CE.once.ch :yellow
    puts <<-EOS
    #{CE::LIBS_NAME} - #{CE::SUMMARY}
    VERSION: #{CE::VERSION}
    README: #{CE::DOCS_PAGE}

    EOS

    headers    = ["* Usage", "* Options", "* Example"]
    headers_op = [
                    "-v:", "--symbol-list:", "--index-list:", "--pickup word [--pickup word ...]:", "--fg color_name:", "--bg color_name:",
                    "--tx text_attribute[,...]:", "--watch:", "--stripe:", %(--hightlight "foreground_color[,background_color[,text_attribute]]:"),
                    "--clean:", "--help:", "-n:", "-e:"
    ]
    CE.pickup(headers, :h_green)
    CE.pickup(headers_op, :cyan)

    puts @padding + "* Usage"

    CE.ch :h_blue
    puts @explain_usage + $/ + $/
    CE.off :fg

    puts @padding + "* Options"

    puts @padding * 2 + "--symbol-list:"
    puts @padding * 3 + @explain_s
    puts @padding * 3 + "short option is -s." + $/ + $/ 
    
    puts @padding * 2 + "--index-list:"
    puts @padding * 3 + @explain_l
    puts @padding * 3 + "short option is -l." + $/ + $/ 

    puts @padding * 2 + "--pickup word [--pickup word ...]:"
    puts @padding * 3 + @explain_p
    puts @padding * 3 + "Regular expressions can be used; like that -> /^foo/i"
    puts @padding * 3 + "short option is -p." + $/ + $/ 

    puts @padding * 2 + %(--hightlight "foreground_color[,background_color[,text_attribute]]:")
    puts @padding * 3 + @explain_H
    puts @padding * 3 + %(example -> echo "some message" | colorecho -H "nil,gray" -p /some patturn/ -f h_yellow)
    puts @padding * 3 + %(default is -H "nil,nil,bold")
    puts @padding * 3 + "short option is -H." + $/ + $/

    puts @padding * 2 + "--fg color_name:"
    puts @padding * 3 + @explain_f
    puts @padding * 3 + "short option is -f." + $/ + $/ 

    puts @padding * 2 + "--bg color_name:"
    puts @padding * 3 + @explain_b
    puts @padding * 3 + "short option is -b." + $/ + $/ 

    puts @padding * 2 + "--tx text_attribute[,...]:"
    puts @padding * 3 + @explain_t
    puts @padding * 3 + "short option is -t." + $/ + $/ 

    puts @padding * 2 + "--watch:"
    puts @padding * 3 + @explain_w
    puts @padding * 3 + "short option is -w." + $/ + $/

    puts @padding * 2 + "--stripe:"
    puts @padding * 3 + @explain_stripe + $/ + $/

    puts @padding * 2 + "--clean:"
    puts @padding * 3 + @explain_c
    puts @padding * 3 + "If you didn't specified -c option will force remove sequence code given message when pickup word is matched."
    puts @padding * 3 + "short option is -c." + $/ + $/

    puts @padding * 2 + "-n:"
    puts @padding * 3 + @explain_n + $/ + $/ 

    puts @padding * 2 + "-e:"
    puts @padding * 3 + @explain_e + $/ + $/ 

    puts @padding * 2 + "-v:"
    puts @padding * 3 + @explain_v + $/ + $/

    puts @padding * 2 + "--help:"
    puts @padding * 3 + @explain_h
    puts @padding * 3 + "short option is -h." + $/ + $/

    puts @padding + "* Example"

    CE.once.ch :h_magenta
    puts @padding * 2 + %(* color_echo can to highlight even when you following the log file by tailf, tail -f.)
    puts @padding * 3 + %(tailf /var/log/httpd/access_log | colorecho -w -p "127.0.0.1" -t bold)
    puts @padding * 3 + %(tailf /var/log/php/php_error.log | colorecho -w -p "foo.php" -p "Fatal error:" -f h_blue) + $/ + $/

    CE.once.ch :h_magenta
    puts @padding * 2 + %(* color_echo is useful to read the access log, etc.)
    puts @padding * 3 + %(cat /var/log/httpd/access_log | colorecho -p "Sun Jan 18" -f h_cyan -t underscore | less -R)
    puts @padding * 3 + %(colorecho -p "Sun Jan 18" -f h_cyan -t underscore < /var/log/httpd/access_log | less -R)
    puts @padding * 3 + %((colorecho -f cyan -p /\\\\s2..\\\\s/ | colorecho -f h_red -p /\\\\s5..\\\\s/ | less -R) < /var/log/httpd/access_log)
    puts @padding * 3 + %(sed -n 1,1000p /var/log/httpd/access_log | colorecho -f cyan -p /\\\\s2..\\\\s/ | colorecho -f h_red -p /\\\\s5..\\\\s/ | less -R) + $/ + $/

    CE.once.ch :h_magenta
    puts @padding * 2 + %(* It is a simple to use.)
    puts @padding * 3 + %(colorecho Hello\\!\\! -f h_white -b index199)
    puts @padding * 3 + %(colorecho Hello\\!\\! -t blink,bold -f magenta) + $/ + $/

    CE.once.ch :h_magenta
    puts @padding * 2 + %(* color_echo can to receive the standard input.)
    puts @padding * 3 + %(echo FooFoOfOO | colorecho -t reverse_video)
    puts @padding * 3 + %(echo FooFoOfOO | colorecho -f index130 -p /foo$/i | colorecho -f index180 -p /^foo/i)
    puts @padding * 3 + %(netstat -na | colorecho -p ":80" | colorecho -p "127.0.0.1" -f h_cyan) + $/ + $/

    CE.once.ch :h_magenta
    puts @padding * 2 + %(* color_echo can to decorate on every other line.)
    puts @padding * 3 + %(colorecho -f gray -t bold --stripe < /path/to/file)
    puts @padding * 3 + %(tailf /var/log/httpd/access_log | colorecho -w -f black -b index150 -t bold --stripe) + $/ + $/

    exit 0
end

# TODO need pager like 'less'?
def display_color_index
    require_color_echo_get

    CE.rainbow
    cnt      = 134
    @padding = " " * 2

    header = "OK, Let me check color index list... :)"
    mes    = CE.rainbow.get(@padding + "-" * cnt) + $/
    mes   += @padding + " " * ((cnt - header.size)/2) + CE.rainbow.get(header) + $/
    mes   += CE.rainbow.get(@padding + "-" * cnt) + $/

    mes += @padding
    256.times do |i|
        num = i + 1
        mes += CE.fg("index#{num}".intern).get("index#{num}" + " " * (4 - num.to_s.size))
        mes += CE.bg("index#{num}".intern).get(" " * 5)
        mes += " " * 3

        if num % 8 == 0
            mes += $/ + $/
            mes += @padding if num != 256
        end
    end
    print mes   

    exit 0
end

def display_symbol_list
    require_color_echo

    symbols_color = [
        :black,
        :gray,
        :red,
        :h_red,
        :green,
        :h_green,
        :yellow,
        :h_yellow,
        :blue,
        :h_blue,
        :magenta,
        :h_magenta,
        :cyan,
        :h_cyan,
        :white,
        :h_white
    ]
    symbols_text_attr = [
        :bold,
        :underscore,
        :blink,
        :reverse_video,
        :concealed
    ]

    CE.times(3).rainbow
    cnt     = 60
    @padding = " " * 2
    mes     = "OK, Let me check color name list... :)"
    puts @padding + "-" * cnt
    puts @padding + " " * ((cnt - mes.size)/2) + mes
    puts @padding + "-" * cnt

    header_colors     = "* foreground or background colors"
    header_text_attrs = "* text attributes"
    CE.pickup([header_colors, header_text_attrs], :cyan, nil, [:underscore, :bold])

    puts @padding + header_colors
    symbols_color.each do |color_name|
        CE.off(:bg).fg color_name
        print "#{@padding*2}:#{color_name}" + " " * (11 - color_name.to_s.size)
        CE.bg color_name
        puts color_name.to_s + " " * (30 - color_name.to_s.size)
    end

    CE.off [:bg, :fg]
    print $/ + $/

    puts @padding + header_text_attrs
    symbols_text_attr.each do |tx_name|
        CE.off(:tx)
        CE.tx tx_name if tx_name != :concealed
        puts "#{@padding*2}:#{tx_name}" + " " * (30 - tx_name.to_s.size)
    end

    print $/

    exit 0
end
