# color_echo
#
# To add color to the command line output.
# This Library will extend the Kernel module's functions(#print, #puts, #p).
# @autor: Kazuya Hotta (nyanko)
#
require "stringio"

module CE
    VERSION    = "0.2.0"
    CODE_RESET = "\e[0m"

    @@enable         = true
    @@isset          = false
    @@code_bg_color  = ""
    @@code_fg_color  = ""
    @@code_text_attr = ""
    @@rainbow        = false

    @@print = method :print
    @@p     = method :p
    @@puts  = method :puts

    @@task = lambda do |*arg|
        if available?
            if @@rainbow && arg.first.instance_of?(String)
                arg = add_rainbow(arg.first)

                # call original method
                eval("@@#{caller_locations(2).first.label}").call(arg)

            else
                # change output destination to StringIO Object
                strio   = StringIO.new
                $stdout = strio

                # output color sequence
                $stdout.print get_start_code

                # call original method
                eval("@@#{caller_locations(2).first.label}").call(arg)

                # change output destination to STDOUT
                $stdout = STDOUT

                # output to STDOUT
                $stdout.print add_reset_line_feed(strio.string)
            end

        # no available "color echo"
        else
            # call original method
            eval("@@#{caller_locations(2).first.label}").call(arg)
        end
    end

    module ForeGround
        BLACK   = 30
        RED     = 31
        GREEN   = 32
        YELLOW  = 33
        BLUE    = 34
        MAGENTA = 35
        CYAN    = 36
        WHITE   = 37
    end

    module BackGround
        BLACK    = 40
        RED      = 41
        GREEN    = 42
        YELLOW   = 43
        BLUE     = 44
        MAGENTA  = 45
        CYAN     = 46
        WHITE    = 47
    end

    module TextAttr
        OFF           = 0
        BOLD          = 1
        UNDERSCORE    = 4
        BLINK         = 5
        REVERSE_VIDEO = 7
        CONCEALED     = 8
    end

    public
    def available?
        return @@enable && @@isset
    end

    def isset?
        return @@isset
    end

    def enable?
        return @@enable
    end

    def unuse
        @@enable = false
    end

    def reset
        @@isset          = false
        @@rainbow        = false
        @@code_bg_color  = ""
        @@code_fg_color  = ""
        @@code_text_attr = ""
    end

    def ch_fg(name)
        return nil if !name.instance_of?(Symbol)
        @@isset         = true  if !@@isset
        @@rainbow       = false if @@rainbow
        @@code_fg_color = convert_to_code("ForeGround", name)
    end

    def ch_bg(name)
        return nil if !name.instance_of?(Symbol)
        @@isset         = true if !@@isset
        @@rainbow       = false if @@rainbow
        @@code_bg_color = convert_to_code("BackGround", name)
    end

    def ch_tx(name)
        return nil if !name.instance_of?(Symbol)
        @@isset          = true if !@@isset
        @@rainbow        = false if @@rainbow
        @@code_text_attr = convert_to_code("TextAttr", name)
    end

    def ch(fg, bg=nil, tx=nil)
        ch_fg(fg)
        ch_bg(bg)
        ch_tx(tx)
    end

    def get_start_code
        return @@code_fg_color + @@code_bg_color + @@code_text_attr
    end

    def get_reset_code
        return self::CODE_RESET
    end

    # add reset & start code to line feed code
    def add_reset_line_feed(input)
        input.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_start_code)
        input += CE::get_reset_code
        return input
    end

    def rainbow
        @@isset   = true if !@@isset
        @@rainbow = true
    end

    def add_rainbow(text)
        cnt    = 0
        output = ""
        text.each_char do |char|
            output += $/ if char == $/

            case cnt
            when 0
                output += "\e[31m" + char + "\e[0m"
            when 1
                output += "\e[32m" + char + "\e[0m"
            when 2
                output += "\e[33m" + char + "\e[0m"
            when 3
                output += "\e[34m" + char + "\e[0m"
            when 4
                output += "\e[35m" + char + "\e[0m"
            when 5
                output += "\e[36m" + char + "\e[0m"
            when 6
                output += "\e[37m" + char + "\e[0m"
            end
            cnt += 1
            cnt  = 0 if cnt >= 7
        end
        return output
    end

    def convert_to_code(module_name, name)
        begin
            code = eval(%{#{module_name}::#{name.to_s.swapcase!}})
        rescue NameError
            raise(NameError ,%{:#{name} is not defined! Please check reference.})
        end
        return "\e[#{code}m"
    end

    def task
        return @@task
    end

    alias_method :off,     :reset
    alias_method :disable, :reset
    alias_method :fg,      :ch_fg
    alias_method :bg,      :ch_bg
    alias_method :tx,      :ch_tx

    module_function :available?,
                    :isset?,
                    :enable?,
                    :unuse,
                    :reset, :off, :disable,
                    :ch_fg, :fg,
                    :ch_bg, :bg,
                    :ch_tx, :tx,
                    :ch,
                    :get_start_code,
                    :get_reset_code,
                    :add_reset_line_feed,
                    :add_rainbow,
                    :rainbow,
                    :convert_to_code,
                    :task
end

# override Kernel methods
def print(*arg)
    CE.task.call(*arg)
end

def p(*arg)
    CE.task.call(*arg)
end

def puts(*arg)
    CE.task.call(*arg)
end
