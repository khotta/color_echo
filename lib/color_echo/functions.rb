module CE
    # do not allow to use
    # @return void
    def unuse
        @@enable = false
    end

    # reset code
    # @param scope symbol|array
    # @return self
    def reset(scope=:all)
        if scope.is_a?(Array)
            scopes = scope
        else
            scopes = [scope]
        end

        scopes.each do |scope|
            case scope
            when :all
                reset_fg
                reset_bg
                reset_tx
                reset_pickup
                reset_highlight
                reset_rainbow
            when :fg
                reset_fg
            when :bg
                reset_bg
            when :tx
                reset_tx
            when :pickup
                reset_pickup
            when :highlight
                reset_highlight
            when :rainbow
                reset_rainbow
            end
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
        return nil if !name.is_a?(Symbol)

        @@rainbow       = false if @@rainbow
        @@code_fg_color = convert_to_code("ForeGround", name)

        return self
    end

    # @param symbol name
    # @return self
    def ch_bg(name)
        return nil if !name.is_a?(Symbol)

        @@rainbow       = false if @@rainbow
        @@code_bg_color = convert_to_code("BackGround", name)

        return self
    end

    # @param array name : Array of Symbols
    # @return self
    def ch_tx(*names)
        @@rainbow = false    if @@rainbow
        names     = names[0] if names[0].instance_of?(Array)

        names.each do |name|
            next if !name.is_a?(Symbol)
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
    def pickup(target, fg=:cyan, bg=nil, *txs)
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
                next if !name.is_a?(Symbol)
                code_tx += convert_to_code("TextAttr", name)
            end
        end

        @@pickup_list[key][:code]  = code_fg + code_bg + code_tx
        @@pickup_list[key][:index] = @@cnt_pickups
        @@cnt_pickups += 1

        return self
    end

    # change mode to rainbow
    # @return void
    def rainbow
        @@rainbow      = true
        @@code_rainbow = @@code_bg_color + @@code_text_attr

        return self
    end

    # change hit lines decoration
    # @return void
    def highlight(fg=nil, bg=nil, *txs)
        fg = convert_to_code("ForeGround", fg)
        bg = convert_to_code("BackGround", bg)
        tx = ""

        if txs.size > 0
            # if text attribute has input as array
            txs = txs[0] if txs[0].instance_of?(Array)

            txs.each do |name|
                next if !name.is_a?(Symbol)
                tx += convert_to_code("TextAttr", name)
            end
        end
        @@code_highlights << fg + bg + tx

        return self
    end

    # get decorated text
    # require "color_echo/get"
    # @param string text
    def get(text)
        if @@allow_output
            caller()[0] =~ /(.*?):(\d+)/
            warn (%([WARNING] #{$1} #{$2}: You can't call CE.get. You must read like -> require 'color_echo/get' ))
            return text
        end

        if !text.is_a?(String)
            text = text.to_s
        end

        @@task.call(text)
    end

    # Enable refresh flag
    # @return self
    def enable_refresh(scope=:all)
        if scope == :all
            @@refresh = true
        elsif scope == :prematch
            @@refresh_pre_match = true
        end

        return self
    end

    # Disable refresh flag
    # @return self
    def disable_refresh
        @@refresh = false
        @@refresh_pre_match = false
        return self
    end

    # CE.get will be stateful
    # @return self
    def stateful
        @@stateful_getter = true
        return self
    end

    # CE.get will be stateless
    def stateless
        @@stateful_getter = false
        return self
    end

    # @param symbol arg
    # @return array
    def withdraw(*arg)
        deleted = []
        arg.each do |target|
            deleted << @@assgined.delete(target)
        end

        return deleted
    end

    # @return array
    def get_assigned
        return @@assgined
    end

    # method alias
    alias_method :off,     :reset
    alias_method :disable, :reset
    alias_method :fg,      :ch_fg
    alias_method :bg,      :ch_bg
    alias_method :tx,      :ch_tx

    extend self
end
