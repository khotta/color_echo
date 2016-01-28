module CE
    @@enable                 = true
    @@isset                  = false
    @@rainbow                = false
    @@allow_output           = false
    @@refresh                = false
    @@refresh_pre_match      = false
    @@code_bg_color          = ""
    @@code_fg_color          = ""
    @@code_text_attr         = ""
    @@code_highlights        = []
    @@code_rainbow           = ""
    # count number for times method
    @@cnt_limit              = 0
    @@pickup_list            = {}
    # how much pattern having?
    @@cnt_pickups            = 0
    @@stateful_getter        = false

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
            if RUBY_VERSION >= "2.3.0"
                eval("@@#{caller_locations(1).first.label}").call(*arg)
            else
                eval("@@#{caller_locations(2).first.label}").call(*arg)
            end

            # change output destination to STDOUT
            $stdout = STDOUT

            # get output text
            if @@rainbow
                output = add_rainbow(strio.string)
            else
                output = strio.string

                # try to remove escape sequence code
                output = cleanup_text(output) if @@refresh

                # decorate pickup
                if @@pickup_list.size > 0
                    output = add_pickup_code(output)
                end

                # add start code in header
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
                        reset
                    end
                end
            else
                reset if !@@stateful_getter
                return output
            end

        # no available "color echo"
        else
            if @@allow_output
                # call original method
                if RUBY_VERSION >= "2.3.0"
                    eval("@@#{caller_locations(1).first.label}").call(*arg)
                else
                    eval("@@#{caller_locations(2).first.label}").call(*arg)
                end
            else
                # just return
                output = ""
                arg.each do |elem|
                    output += elem
                end
                return output
            end
        end
    end
end
