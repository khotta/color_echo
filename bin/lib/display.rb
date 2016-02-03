@padding        = " " * 4
@header_s       = %(-s, --symbol-list)
@explain_s      = %(Shows symbol list that can to specify in foreground_color, background_color, text_attr.)
@header_l       = %(-l, --index-list)
@explain_l      = %(Shows color index list that can to specify in foreground_color, background_color.)
@header_p       = %(-p, --pickup "pattern[,foreground_color[,background_color[,text_attribute]]]")
@explain_p      = %(Decorates your specified pattern. You can use this option many times.)
@header_H       = %(-H, --hightlight "foreground_color[,background_color[,text_attribute]]")
@explain_H      = %(Highlight lines that match pattern which is specified by -p option.)
@header_f       = %(-f, --fg color_name)
@explain_f      = %(Specifies foreground color.)
@header_b       = %(-b, --bg color_name)
@explain_b      = %(Specifies background color.)
@header_t       = %(-t, --tx text_attribute[,...])
@explain_t      = %(Specifies background color.)
@header_w       = %(-w, --watch)
@explain_w      = %(Keeps wait for standard input.)
@header_stripe  = %(--stripe)
@explain_stripe = %(Decorates on every other line.)
@header_r       = %(-r, --refresh-match)
@explain_r      = %(Tries to delete sequence code from input that matches -p option’s pattern)
@header_R       = %(-R, --refresh)
@explain_R      = %(Tries to delete sequence code from input.)
@header_c       = %(-c file_name,...)
@explain_c      = %(Reads options from your specify file. You can specify many files as -c foo,bar,baz.)
@header_n       = %(-n)
@explain_n      = %(Do not output the trailing newline.)
@header_e       = %(-e)
@explain_e      = %(Enable interpretation of line feed.)
@header_v       = %(-v)
@explain_v      = %(Shows version of color_echo.)
@header_h       = %(-h, --help)
@explain_h      = %(Shows help message.)
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
    #{CE::LIBS_NAME} - #{CE::DESCRIPTION}
    VERSION: #{CE::VERSION}

    EOS

    headers = ["* Usage", "* Options", "* Example"]
    CE.pickup(headers, :h_green)

    puts @padding + "* Usage"

    CE.ch :h_blue
    puts @explain_usage + $/ * 2
    CE.off :fg

    headers_op = [
        @header_l,
        @header_p,
        @header_H,
        @header_f,
        @header_b,
        @header_t,
        @header_w,
        @header_n,
        @header_e,
        @header_h,
        @header_stripe,
        @header_r,
        @header_R,
        @header_c,
        @header_v,
        @header_s
    ]
    CE.pickup(headers_op, :cyan)

    puts @padding + "* Options"

    puts @padding * 2 + @header_s
    puts @padding * 3 + @explain_s + $/ * 2
    
    puts @padding * 2 + @header_l
    puts @padding * 3 + @explain_l + $/ * 2

    puts @padding * 2 + @header_p
    puts @padding * 3 + @explain_p + $/ * 2

    puts @padding * 2 + @header_H
    puts @padding * 3 + @explain_H + $/ * 2

    puts @padding * 2 + @header_f
    puts @padding * 3 + @explain_f + $/ * 2

    puts @padding * 2 + @header_b
    puts @padding * 3 + @explain_b + $/ * 2

    puts @padding * 2 + @header_t
    puts @padding * 3 + @explain_t + $/ * 2

    puts @padding * 2 + @header_w
    puts @padding * 3 + @explain_w + $/ * 2

    puts @padding * 2 + @header_stripe
    puts @padding * 3 + @explain_stripe + $/ * 2

    puts @padding * 2 + @header_r
    puts @padding * 3 + @explain_r + $/ * 2

    puts @padding * 2 + @header_R
    puts @padding * 3 + @explain_R + $/ * 2

    puts @padding * 2 + @header_c
    puts @padding * 3 + @explain_c + $/ * 2

    puts @padding * 2 + @header_n
    puts @padding * 3 + @explain_n + $/ * 2 

    puts @padding * 2 + @header_e
    puts @padding * 3 + @explain_e + $/ * 2 

    puts @padding * 2 + @header_v
    puts @padding * 3 + @explain_v + $/ * 2

    puts @padding * 2 + @header_h
    puts @padding * 3 + @explain_h + $/ * 2

    CE.once.rainbow
    puts @padding * 2 + %(Let's enjoy colors!!) + $/ * 2
    exit 0
end

def warn_display(msg, header="Runtime")
    warn(%(#{header} Warning:))
    warn(" " * 4 + msg + $/ * 2)
end

def error_display(msg, header="Runtime")
    msgls = msg.is_a?(Array) ? msg : [msg]
    warn(%(#{header} Error:))
    msgls.each do |msg|
        warn(" " * 4 + msg + $/)
    end
    exit 1
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
            mes += $/ * 2
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
        :underline,
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
    CE.pickup([header_colors, header_text_attrs], :cyan, nil, [:underline, :bold])

    puts @padding + header_colors
    symbols_color.each do |color_name|
        CE.off(:bg).fg color_name
        print "#{@padding*2}:#{color_name}" + " " * (11 - color_name.to_s.size)
        CE.bg color_name
        puts color_name.to_s + " " * (30 - color_name.to_s.size)
    end

    CE.off [:bg, :fg]
    print $/ * 2

    puts @padding + header_text_attrs
    symbols_text_attr.each do |tx_name|
        CE.off(:tx)
        CE.tx tx_name if tx_name != :concealed
        puts "#{@padding*2}:#{tx_name}" + " " * (30 - tx_name.to_s.size)
    end

    print $/

    exit 0
end
