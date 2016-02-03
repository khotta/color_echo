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
    @@cnt_limit = 0

    # pickup patterns and decoration of it
    @@pickup_list = {}

    # how much patterns having?
    @@cnt_pickups = 0

    # is stateful when 'color_echo/get'?
    @@stateful_getter = false

    # assgined methods to decorate
    @@assgined = [:puts, :p, :print, :printf, :putc]

    # save methods
    @@puts   = method :puts
    @@p      = method :p
    @@print  = method :print
    @@printf = method :printf
    @@putc   = method :putc

    # closure for CE.get
    @@get = lambda do |text|
        print text
    end

    # assgined methods will be overwritten as this closure
    @@task = lambda do |*arg|
        # get function name that was called
        if RUBY_VERSION >= "2.3.0"
            called = caller_locations(1).first.label
        else
            called = caller_locations(2).first.label
        end

        if available? && called == "get" || @@assgined.index(called.intern)
            task_available(called, arg)
        else
            # no available "color echo"
            task_unuse(called, arg)
        end
    end
end
