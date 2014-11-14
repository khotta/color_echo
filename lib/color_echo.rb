# ColorEcho - handle the ANSI color sequences.
# @autor: Kazuya Hotta (nyanko)
#
require "stringio"

module CE
    VERSION    = "0.1.1"
    CODE_RESET = "\e[0m"

    @@use            = true
    @@enable         = false
    @@code_bg_color  = ""
    @@code_fg_color  = ""
    @@code_text_attr = ""

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

    module_function
    def enable?
        return @@enable && @@use
    end

    def disable
        @@enable         = false
        @@code_bg_color  = ""
        @@code_fg_color  = ""
        @@code_text_attr = ""
    end

    def off
        disable
    end

    def reset
        disable
    end

    def unuse
        @@use = false
    end

    def ch_fg(name)
        return nil if !name.instance_of?(Symbol)
        @@enable        = true if !@@enable
        @@code_fg_color = get_code("ForeGround", name)
    end

    def ch_bg(name)
        return nil if !name.instance_of?(Symbol)
        @@enable        = true if !@@enable
        @@code_bg_color = get_code("BackGround", name)
    end

    def ch_tx(name)
        return nil if !name.instance_of?(Symbol)
        @@enable         = true if !@@enable
        @@code_text_attr = get_code("TextAttr", name)
    end

    def ch(fg, bg=nil, tx=nil)
        ch_fg(fg)
        ch_bg(bg)
        ch_tx(tx)
    end

    def get_color_code
        return @@code_fg_color + @@code_bg_color + @@code_text_attr
    end

    def get_reset_code
        return self::CODE_RESET
    end

    def get_code(module_name, name)
        begin
            code = eval(%{#{module_name}::#{name.to_s.swapcase!}})
        rescue NameError
            raise(NameError ,%{:#{name} is not defined! Please check reference.})
        end
        return "\e[#{code}m"
    end
end

def print(*arg)
    if CE::enable?
        # change output destination to StringIO Object
        strio   = StringIO.new
        $stdout = strio

        # output color sequence
        $stdout.print(CE::get_color_code)

        super

        # change output destination to STDOUT
        $stdout = STDOUT

        # add reset & start code to line feed code
        output = strio.string
        output.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_color_code)
        output += CE::get_reset_code

        # output to STDOUT
        $stdout.print(output)
    else
        super
    end
end

def p(*arg)
    if CE::enable?
        # change output destination to StringIO Object
        strio   = StringIO.new
        $stdout = strio

        # output color sequence
        $stdout.print(CE::get_color_code)

        super

        # change output destination to STDOUT
        $stdout = STDOUT

        # add reset & start code to line feed code
        output = strio.string
        output.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_color_code)
        output += CE::get_reset_code

        # output to STDOUT
        $stdout.print(output)
    else
        super
    end
end

def puts(*arg)
    if CE::enable?
        # change output destination to StringIO Object
        strio   = StringIO.new
        $stdout = strio

        # output color sequence
        $stdout.print(CE::get_color_code)

        super

        # change output destination to STDOUT
        $stdout = STDOUT

        # add reset & start code to line feed code
        output = strio.string
        output.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_color_code)
        output += CE::get_reset_code

        # output to STDOUT
        $stdout.print(output)
    else
        super
    end
end
