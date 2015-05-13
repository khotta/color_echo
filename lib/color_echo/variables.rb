module CE
    @@enable                 = true
    @@isset                  = false
    @@rainbow                = false
    @@allow_output           = false
    @@clean                  = false
    @@code_bg_color          = ""
    @@code_fg_color          = ""
    @@code_text_attr         = ""
    @@code_hitline_bg_color  = ""
    @@code_hitline_fg_color  = ""
    @@code_hitline_text_attr = ""
    @@code_rainbow           = ""
    @@cnt_limit              = 0
    @@pickup_list            = {}

    @@print = method :print
    @@p     = method :p
    @@puts  = method :puts

    @@get = lambda do |text|
        print text
    end

    @@task = lambda do |*arg|
        if available?
            # change output destination to StringIO Object
            strio   = StringIO.new
            $stdout = strio

            # call original method
            eval("@@#{caller_locations(2).first.label}").call(*arg)

            # change output destination to STDOUT
            $stdout = STDOUT

            #is_hit_pickup = false

            # get output text
            if @@rainbow
                output = add_rainbow(strio.string)
            else
                output = strio.string

                # try to remove escape sequence code
                output = cleanup_text(output) if @@clean

                # decorate pickup
                if @@pickup_list.size > 0
                    #before_output = String.new(output)
                    output = add_pickup_code(output)
                    #is_hit_pickup = before_output != output
                end

                # add start code in haed
                output = get_start_code + output

                # add reset code in front of line feed
                output = add_reset_line_feed(output)
            end

            # output to STDOUT
            if @@allow_output
                $stdout.print output
                # auto off
                if @@cnt_limit > 0
                    @@cnt_limit -= 1
                    # to reset
                    if @@cnt_limit == 0
                        reset [:fg, :bg, :tx, :rainbow]
                    end
                end
            else
                reset
                return output
            end

        # no available "color echo"
        else
            if @@allow_output
                # call original method
                eval("@@#{caller_locations(2).first.label}").call(*arg)
            else
                return arg
            end
        end
    end
end
