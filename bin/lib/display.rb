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

    padding    = " " * 4
    headers    = ["* Usage", "* Options", "* Example"]
    headers_op = [
                     "-v:", "--symbol-list:", "--index-list:", "--pickup word [--pickup word ...]:", "--fg color_name:", "--bg color_name:",
                     "--tx text_attribute[,...]:", "--watch:", "--stripe:", "-n:", "-h:"
    ]
    CE.pickup(headers, :h_green)
    CE.pickup(headers_op, :cyan)

    puts padding + "* Usage"

    CE.ch :h_blue
    puts padding * 2 + "color_echo [options] text"
    puts padding * 2 + "color_echo [options] < /path/to/file"
    puts padding * 2 + "echo text | color_echo [options]"
    puts padding * 2 + "color_echo -v"
    puts padding * 2 + "color_echo -s"
    puts padding * 2 + "color_echo -l"
    puts padding * 2 + "color_echo -h" + $/ + $/
    CE.off :fg

    puts padding + "* Options"

    puts padding * 2 + "-v:"
    puts padding * 3 + "Display version of color_echo." + $/ + $/

    puts padding * 2 + "--symbol-list:"
    puts padding * 3 + "Display symbol list that can to specify."
    puts padding * 3 + "short option is -s." + $/ + $/ 
    
    puts padding * 2 + "--index-list:"
    puts padding * 3 + "Display color index list that can to specify."
    puts padding * 3 + "short option is -l." + $/ + $/ 

    puts padding * 2 + "--pickup word [--pickup word ...]:"
    puts padding * 3 + "Decorate your specified wrods. You can use this option any number of times."
    puts padding * 3 + "Regular expressions can be used; like that -> /^foo/i"
    puts padding * 3 + "short option is -p." + $/ + $/ 

    puts padding * 2 + "--fg color_name:"
    puts padding * 3 + "Decorate the foreground color."
    puts padding * 3 + "short option is -f." + $/ + $/ 

    puts padding * 2 + "--bg color_name:"
    puts padding * 3 + "Decorate the background color."
    puts padding * 3 + "short option is -b." + $/ + $/ 

    puts padding * 2 + "--tx text_attribute[,...]:"
    puts padding * 3 + "Decorate the text attribute."
    puts padding * 3 + "short option is -t." + $/ + $/ 

    puts padding * 2 + "--watch:"
    puts padding * 3 + "Interactive mode. Break word is -> exit, quit, bye; Or Ctl + c"
    puts padding * 3 + "short option is -w." + $/ + $/

    puts padding * 2 + "--stripe:"
    puts padding * 3 + "Apply the decoration for each row."
    puts padding * 3 + "pickup option is ignored." + $/ + $/

    puts padding * 2 + "-n:"
    puts padding * 3 + "Do not output the trailing newline." + $/ + $/ 

    puts padding * 2 + "-h:"
    puts padding * 3 + "Show this message." + $/ + $/ 

    puts padding + "* Example"

    CE.once.ch :h_magenta
    puts padding * 2 + %(* color_echo can to highlight even when you following the log file by tailf, tail -f.)
    puts padding * 3 + %(tailf /var/log/httpd/access_log | color_echo -w -p "127.0.0.1" -t bold)
    puts padding * 3 + %(tailf /var/log/php/php_error.log | color_echo -w -p "foo.php" -p "Fatal error:" -f h_blue) + $/ + $/

    CE.once.ch :h_magenta
    puts padding * 2 + %(* color_echo is useful to read the access log, etc.)
    puts padding * 3 + %(cat /var/log/httpd/access_log | color_echo -p "Sun Jan 18" -f h_cyan -t underscore | less)
    puts padding * 3 + %(color_echo -p "Sun Jan 18" -f h_cyan -t underscore < /var/log/httpd/access_log | less)
    puts padding * 3 + %((color_echo -f cyan -p /\\\\s2..\\\\s/ | color_echo -f h_red -p /\\\\s5..\\\\s/ | less) < /var/log/httpd/access_log)
    puts padding * 3 + %(sed -n 1,1000p /var/log/httpd/access_log | color_echo -f cyan -p /\\\\s2..\\\\s/ | color_echo -f h_red -p /\\\\s5..\\\\s/ | less) + $/ + $/

    CE.once.ch :h_magenta
    puts padding * 2 + %(* It is a simple to use.)
    puts padding * 3 + %(color_echo Hello\\!\\! -f h_white -b index199)
    puts padding * 3 + %(color_echo Hello\\!\\! -t blink,bold -f magenta) + $/ + $/

    CE.once.ch :h_magenta
    puts padding * 2 + %(* color_echo can to receive the standard input.)
    puts padding * 3 + %(echo FooFoOfOO | color_echo -t reverse_video)
    puts padding * 3 + %(echo FooFoOfOO | color_echo -f index130 -p /foo$/i | color_echo -f index180 -p /^foo/i)
    puts padding * 3 + %(netstat -na | color_echo -p ":80" | color_echo -p "127.0.0.1" -f h_cyan) + $/ + $/

    CE.once.ch :h_magenta
    puts padding * 2 + %(* color_echo can to decorate for each row.)
    puts padding * 3 + %(color_echo -f gray -t bold --stripe < /path/to/file)
    puts padding * 3 + %(tailf /var/log/httpd/access_log | color_echo -w -f black -b index150 -t bold --stripe) + $/ + $/

    exit 0
end

def display_color_index
    require_color_echo

    CE.rainbow
    cnt     = 134
    padding = " " * 2
    mes     = "OK, Let me check color index list... :)"
    puts padding + "-" * cnt
    puts padding + " " * ((cnt - mes.size)/2) + mes
    puts padding + "-" * cnt

    print padding
    256.times do |i|
        num = i + 1
        CE.fg "index#{num}".intern
        print "index#{num}" + " " * (4 - num.to_s.size)
        CE.bg "index#{num}".intern
        print " " * 5
        CE.off
        print " " * 3

        if num % 8 == 0
            print $/ + $/
            print padding if num != 256
        end
    end
    CE.off

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
    padding = " " * 2
    mes     = "OK, Let me check color name list... :)"
    puts padding + "-" * cnt
    puts padding + " " * ((cnt - mes.size)/2) + mes
    puts padding + "-" * cnt

    header_colors     = "* foreground or background colors"
    header_text_attrs = "* text attributes"
    CE.pickup([header_colors, header_text_attrs], :cyan, nil, [:underscore, :bold])

    puts padding + header_colors
    symbols_color.each do |color_name|
        CE.off(:bg).fg color_name
        print "#{padding*2}:#{color_name}" + " " * (11 - color_name.to_s.size)
        CE.bg color_name
        puts color_name.to_s + " " * (30 - color_name.to_s.size)
    end

    CE.off [:bg, :fg]
    print $/ + $/

    puts padding + header_text_attrs
    symbols_text_attr.each do |tx_name|
        CE.off(:tx)
        CE.tx tx_name if tx_name != :concealed
        puts "#{padding*2}:#{tx_name}" + " " * (30 - tx_name.to_s.size)
    end

    print $/

    exit 0
end

