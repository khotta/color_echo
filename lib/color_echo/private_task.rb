module CE
    private
    def task_available(called, arg)
        # change output destination to StringIO Object
        strio   = StringIO.new
        $stdout = strio

        # call original method
        eval("@@#{called}").call(*arg)

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
    end

    # this task will be called if CE.unuse was called
    private
    def task_unuse(called, arg)
        if @@allow_output
            # call original method
            eval("@@#{called}").call(*arg)
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
