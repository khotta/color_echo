module CE
    @@enable         = true
    @@isset          = false
    @@code_bg_color  = ""
    @@code_fg_color  = ""
    @@code_text_attr = ""
    @@code_rainbow   = ""
    @@rainbow        = false
    @@pickup_list    = {}
    @@cnt_limit      = 0

    @@print = method :print
    @@p     = method :p
    @@puts  = method :puts

    @@task = lambda do |*arg|
        if available?
            # change output destination to StringIO Object
            strio   = StringIO.new
            $stdout = strio

            # call original method
            eval("@@#{caller_locations(2).first.label}").call(*arg)

            # change output destination to STDOUT
            $stdout = STDOUT

            # output to STDOUT
            if @@rainbow
                output = add_rainbow(strio.string)
            else
                output = strio.string

                # decorate pickup
                if @@pickup_list.size > 0
                    output = add_pickup_code(output)
                end

                # add start code in haed
                output = get_start_code + output

                # add reset code in front of line feed
                output = add_reset_line_feed(output)
            end

            $stdout.print output

            # auto off
            if @@cnt_limit > 0
                @@cnt_limit -= 1
                reset if @@cnt_limit == 0
            end

        # no available "color echo"
        else
            # call original method
            eval("@@#{caller_locations(2).first.label}").call(*arg)
        end
    end
end
