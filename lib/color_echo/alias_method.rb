module CE
    alias_method :off,     :reset
    alias_method :disable, :reset
    alias_method :fg,      :ch_fg
    alias_method :bg,      :ch_bg
    alias_method :tx,      :ch_tx
end
