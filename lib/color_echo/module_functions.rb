module CE
    # @return bool
    def available?
        return @@enable && @@isset
    end

    # @return bool
    def isset?
        return @@isset
    end

    # @return bool
    def enable?
        return @@enable
    end

    # @return void
    def unuse
        @@enable = false
    end

    # @return void
    def reset
        @@isset          = false
        @@rainbow        = false
        @@code_bg_color  = ""
        @@code_fg_color  = ""
        @@code_text_attr = ""
        @@code_rainbow   = ""
    end

    # @param Symbol name
    # @return void
    def ch_fg(name)
        return nil if !name.instance_of?(Symbol)
        @@isset         = true  if !@@isset
        @@rainbow       = false if @@rainbow
        @@code_fg_color = convert_to_code("ForeGround", name)
    end

    # @param Symbol name
    # @return void
    def ch_bg(name)
        return nil if !name.instance_of?(Symbol)
        @@isset         = true if !@@isset
        @@rainbow       = false if @@rainbow
        @@code_bg_color = convert_to_code("BackGround", name)
    end

    # @param Symbol name
    # @return void
    def ch_tx(name)
        return nil if !name.instance_of?(Symbol)
        @@isset          = true if !@@isset
        @@rainbow        = false if @@rainbow
        @@code_text_attr = convert_to_code("TextAttr", name)
    end

    # @param Symbol fg
    # @param Symbol bg
    # @param Symbol tx
    # @return void
    def ch(fg, bg=nil, tx=nil)
        ch_fg(fg)
        ch_bg(bg)
        ch_tx(tx)
    end

    # return start color sequence code
    # @return String
    def get_start_code
        if @@rainbow
            return @@code_rainbow
        else
            return @@code_fg_color + @@code_bg_color + @@code_text_attr
        end
    end

    # @return String
    def get_reset_code
        return self::CODE_RESET
    end

    # add reset & start code to line feed code
    # @param String input
    def add_reset_line_feed(input)
        input.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_start_code)
        input += CE::get_reset_code
        return input
    end

    # change mode to rainbow
    # @return void
    def rainbow
        @@isset        = true if !@@isset
        @@rainbow      = true
        @@code_rainbow = @@code_bg_color + @@code_text_attr
    end

    # add code to be a rainbow color
    # @param String text
    # @return String
    def add_rainbow(text)
        cnt    = 0
        output = get_start_code

        text.each_char do |char|
            if char == $/
                output += get_reset_code + $/ + get_start_code
                next
            end

            case cnt
            when 0
                output += ForeGround::RED + char + CODE_RESET + get_start_code
            when 1
                output += ForeGround::GREEN + char + CODE_RESET + get_start_code
            when 2
                output += ForeGround::YELLOW + char + CODE_RESET + get_start_code
            when 3
                output += ForeGround::BLUE + char + CODE_RESET + get_start_code
            when 4
                output += ForeGround::MAGENTA + char + CODE_RESET + get_start_code
            when 5
                output += ForeGround::CYAN + char + CODE_RESET + get_start_code
            when 6
                output += ForeGround::WHITE + char + CODE_RESET + get_start_code
            end
            cnt += 1
            cnt  = 0 if cnt >= 7
        end

        output += get_reset_code

        return output
    end

    # get sequence code by symbol
    # @param String module_name
    # @param Symbol name
    # @return String
    def convert_to_code(module_name, name)
        begin
            code = eval(%{#{module_name}::#{name.to_s.swapcase!}})
        rescue NameError
            raise(NameError ,%{:#{name} is not defined! Please check reference.})
        end
        return code
    end

    # @return Proc
    def task
        return @@task
    end

    require_relative "alias_method.rb"

    module_function :available?,
                    :isset?,
                    :enable?,
                    :unuse,
                    :reset,
                    :off,
                    :disable,
                    :ch_fg,
                    :fg,
                    :ch_bg,
                    :bg,
                    :ch_tx,
                    :tx,
                    :ch,
                    :get_start_code,
                    :get_reset_code,
                    :add_reset_line_feed,
                    :add_rainbow,
                    :rainbow,
                    :convert_to_code,
                    :task
end
