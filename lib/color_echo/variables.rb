module CE
    @@enable         = true
    @@isset          = false
    @@code_bg_color  = ""
    @@code_fg_color  = ""
    @@code_text_attr = ""
    @@code_rainbow   = ""
    @@rainbow        = false

    @@print = method :print
    @@p     = method :p
    @@puts  = method :puts

    @@task = lambda do |*arg|
        if available?
            # change output destination to StringIO Object
            strio   = StringIO.new
            $stdout = strio

            # output color sequence
            $stdout.print get_start_code if !@@rainbow

            # call original method
            eval("@@#{caller_locations(2).first.label}").call(*arg)

            # change output destination to STDOUT
            $stdout = STDOUT

            # output to STDOUT
            if @@rainbow
                $stdout.print add_rainbow(strio.string)
            else
                $stdout.print add_reset_line_feed(strio.string)
            end

        # no available "color echo"
        else
            # call original method
            eval("@@#{caller_locations(2).first.label}").call(*arg)
        end
    end
end
