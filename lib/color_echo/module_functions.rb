module CE
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
            if char == $/
                output += $/
                next
            end

            case cnt
            when 0
                output += ForeGround::RED + char + CODE_RESET
            when 1
                output += ForeGround::GREEN + char + CODE_RESET
            when 2
                output += ForeGround::YELLOW + char + CODE_RESET
            when 3
                output += ForeGround::BLUE + char + CODE_RESET
            when 4
                output += ForeGround::MAGENTA + char + CODE_RESET
            when 5
                output += ForeGround::CYAN + char + CODE_RESET
            when 6
                output += ForeGround::WHITE + char + CODE_RESET
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
        return code
    end

    def task
        return @@task
    end

    require_relative "alias_method.rb"

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
