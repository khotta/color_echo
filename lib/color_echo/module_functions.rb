module CE
    # is allow to use?
    # @return bool
    def enable?
        return @@enable
    end

    # is allow to use? and is set code?
    # @return bool
    def available?
        return @@enable && isset?
    end

    # is set code?
    # @return bool
    def isset?
        return get_start_code != "" || @@pickup_list.size > 0 || @@rainbow
    end

    # do not allow to use
    # @return void
    def unuse
        @@enable = false
    end

    # reset code
    # @return self
    def reset(target=nil)
        if target == :fg
            @@code_fg_color = ""

        elsif target == :bg
            @@code_bg_color = ""

        elsif target == :pickup
            @@pickup_list    = {}

        else
            @@code_bg_color  = ""
            @@code_fg_color  = ""
            @@code_text_attr = ""
            @@code_rainbow   = ""
            @@rainbow        = false
            @@pickup_list    = {}
        end

        return self
    end

    # auto off until output set count
    # @params int cnt
    # @return self
    def times(cnt)
        @@cnt_limit = cnt
        return self
    end

    def once
        times(1)
    end

    # @param symbol name
    # @return self
    def ch_fg(name)
        return nil if !name.instance_of?(Symbol)

        @@rainbow = false if @@rainbow
        @@code_fg_color = convert_to_code("ForeGround", name)

        return self
    end

    # @param symbol name
    # @return self
    def ch_bg(name)
        return nil if !name.instance_of?(Symbol)

        @@rainbow = false if @@rainbow
        @@code_bg_color = convert_to_code("BackGround", name)

        return self
    end

    # @param array name : Array of Symbols
    # @return self
    def ch_tx(*names)
        @@rainbow = false    if @@rainbow
        names     = names[0] if names[0].instance_of?(Array)

        names.each do |name|
            next if !name.instance_of?(Symbol)
            @@code_text_attr += convert_to_code("TextAttr", name)
        end

        return self
    end

    # @param symbol fg
    # @param symbol bg
    # @param symbol|array txs
    # @return self
    def ch(fg, bg=nil, txs=nil)
        ch_fg(fg)
        ch_bg(bg)
        ch_tx(*txs)  # passing expand

        return self
    end

    # to decorate only the specified target
    # @param string|regexp|array target
    # @param symbol fg
    # @param symbol bg
    # @param symbol tx
    # @return self
    def pickup(target, fg=:red, bg=nil, *txs)
        key = target.object_id.to_s
        @@pickup_list[key] = {}

        if target.is_a?(Array)
            @@pickup_list[key][:patterns] = target
        else
            @@pickup_list[key][:patterns] = [target]
        end

        if fg.instance_of?(Symbol)
            code_fg = convert_to_code("ForeGround", fg)
        else
            code_fg = ""
        end

        if bg.instance_of?(Symbol)
            code_bg = convert_to_code("BackGround", bg)
        else
            code_bg = ""
        end

        code_tx = ""
        if txs.size > 0
            txs = txs[0] if txs[0].instance_of?(Array)
            txs.each do |name|
                next if !name.instance_of?(Symbol)
                code_tx += convert_to_code("TextAttr", name)
            end
        end

        @@pickup_list[key][:code] = code_fg + code_bg + code_tx

        return self
    end

    # change mode to rainbow
    # @return void
    def rainbow
        @@rainbow      = true
        @@code_rainbow = @@code_bg_color + @@code_text_attr
    end

    # return start escape sequence code
    # @return string
    def get_start_code
        if @@rainbow
            return @@code_rainbow
        else
            return @@code_fg_color + @@code_bg_color + @@code_text_attr
        end
    end

    # @return String
    def get_reset_code
        return self::Off::ALL
    end

    # add reset & start code to line feed code
    # @param string input
    def add_reset_line_feed(input)
        input.gsub!(/#{$/}/, CE::get_reset_code + $/ + CE::get_start_code)
        input += CE::get_reset_code
        return input
    end

    # add code to be a rainbow color
    # @param string text
    # @return string
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
                output += ForeGround::RED + char + Off::ALL + get_start_code
            when 1
                output += ForeGround::GREEN + char + Off::ALL + get_start_code
            when 2
                output += ForeGround::YELLOW + char + Off::ALL + get_start_code
            when 3
                output += ForeGround::BLUE + char + Off::ALL + get_start_code
            when 4
                output += ForeGround::MAGENTA + char + Off::ALL + get_start_code
            when 5
                output += ForeGround::CYAN + char + Off::ALL + get_start_code
            when 6
                output += ForeGround::WHITE + char + Off::ALL + get_start_code
            end
            cnt += 1
            cnt  = 0 if cnt >= 7
        end

        output += get_reset_code

        return output
    end

    # add pickup code
    # @param string text
    # @return string
    def add_pickup_code(text)
        @@pickup_list.each_pair do |key, hash|
            patterns = hash[:patterns]
            code     = hash[:code]

            # repeat to each specified pickup pattern
            patterns.each do |pattern|
                # pattern is Regexp
                if pattern.is_a?(Regexp)
                    after_text = ""
                    # global match
                    (text.scan(pattern)).size.times do
                        pattern =~ text
                        after_text += $` + code + $& + get_reset_code + get_start_code
                        text = $'
                    end
                    text = after_text + text

                # pattern is String
                else
                    text.gsub!(pattern, code + pattern + get_reset_code + get_start_code)
                end
            end
        end

        return text
    end

    # get sequence code by symbol
    # @param string module_name
    # @param symbol name
    # @return string
    def convert_to_code(module_name, name)
        return "" if (name == nil || name == "")

        begin
            cname = name.to_s.swapcase

            # specified color index
            if cname.index("INDEX")
                num = cname.sub("INDEX", "").to_i - 1
                return eval(%{#{module_name}::INDEX}) + num.to_s + "m"
            end

            code = eval(%{#{module_name}::#{cname}})
        rescue NameError
            raise(NameError ,%{:#{name} is not defined! Please check reference.})
        end
        return code
    end

    # @return proc
    def task
        return @@task
    end

    # method alias
    alias_method :off,     :reset
    alias_method :disable, :reset
    alias_method :fg,      :ch_fg
    alias_method :bg,      :ch_bg
    alias_method :tx,      :ch_tx

    module_function :available?,
                    :isset?,
                    :enable?,
                    :unuse,
                    :reset,
                    :off,
                    :disable,
                    :times,
                    :once,
                    :ch_fg,
                    :fg,
                    :ch_bg,
                    :bg,
                    :ch_tx,
                    :tx,
                    :ch,
                    :pickup,
                    :rainbow,
                    :get_start_code,
                    :get_reset_code,
                    :add_reset_line_feed,
                    :add_rainbow,
                    :add_pickup_code,
                    :convert_to_code,
                    :task
end
