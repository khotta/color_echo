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

    # reset foreground code
    # @return self
    def reset_fg
        @@code_fg_color = ""
        return self
    end

    # reset background code
    # @return self
    def reset_bg
        @@code_bg_color = ""
        return self
    end

    # reset text attr code
    # @return self
    def reset_tx
        @@code_text_attr = ""
        return self
    end

    # reset pickup code
    # @return self
    def reset_pickup
        @@pickup_list = {}
        return self
    end

    # reset hitline code
    # @return self
    def reset_hitline
        @@code_hitline_bg_color  = ""
        @@code_hitline_fg_color  = ""
        @@code_hitline_text_attr = ""
        return self
    end

    # reset and off raubow mode
    # @return self
    def reset_rainbow
        @@code_rainbow = ""
        @@rainbow      = false
        return self
    end

    # reset all state of code
    # @return self
    def reset_all
        reset_fg
        reset_bg
        reset_tx
        reset_pickup
        reset_rainbow
        return self
    end

    # return start escape sequence code
    # @return string
    def get_start_code(type=nil)
        if @@rainbow
            return @@code_rainbow
        elsif type == :hitline
            return @@code_hitline_fg_color + @@code_hitline_bg_color + @@code_hitline_text_attr
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
        input = input.unpack("C*").pack("U*") if !input.valid_encoding?
        input.gsub!(/#{$/}/, get_reset_code + $/ + get_start_code)
        input += get_reset_code
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

            # TODO This way so lame...
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
        if @@refresh_pre_match
            # remove sequence code from given If it matches pickups
            orgtext = text.clone
            text    = cleanup_text(text)
        end

        is_match = false
        @@pickup_list.each_pair do |key, hash|
            patterns    = hash[:patterns]
            code_pickup = hash[:code]

            # repeat to each specified pickup pattern
            patterns.each do |pattern|
                # pattern is Regexp
                if pattern.is_a?(Regexp)
                    after_text = ""
                    # global match
                    (text.scan(pattern)).size.times do
                        pattern =~ text
                        after_text += $` + get_reset_code + code_pickup + $& + get_reset_code + get_start_code + get_start_code(:hitline)
                        text = $'
                    end
                    text     = after_text + text
                    is_match = ($& != nil) if (!is_match)

                # pattern is String
                else
                    res      = text.gsub!(pattern, get_reset_code + code_pickup + pattern + get_reset_code + get_start_code + get_start_code(:hitline))
                    is_match = (res != nil) if (!is_match)
                end
            end
        end

        if is_match
            text = get_start_code(:hitline) + text + get_reset_code
        elsif @@refresh_pre_match
            text = orgtext
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

    # try to remove escape sequence code
    # @param string text
    # @return texgt
    def cleanup_text(text)
        text.gsub!(/\e\[[0-9;]+[mK]/, "")
        return text
    end
end
