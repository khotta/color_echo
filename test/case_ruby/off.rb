class TestColorEcho < Minitest::Test
    def test_off
        set_colors
        puts @@dammy_string
        exec %(CE.off :fg)
        puts @@dammy_string

        set_colors
        puts @@dammy_string
        exec %(CE.off :bg)
        puts @@dammy_string

        set_colors
        puts @@dammy_string
        exec %(CE.off :tx)
        puts @@dammy_string

        exec %(CE.rainbow)
        puts @@dammy_string
        exec %(CE.off :rainbow)
        puts @@dammy_string

        set_colors
        puts @@dammy_string
        exec %(CE.pickup(/^Dammy/, :cyan))
        puts @@dammy_string
        exec %(CE.highlight(nil, :yellow, :underline))
        puts @@dammy_string
        exec %(CE.off :highlight)
        puts @@dammy_string
        exec %(CE.off :pickup)
        puts @@dammy_string

        set_colors
        puts @@dammy_string
        exec %(CE.off)
        puts @@dammy_string

        exec %(CE.unuse)
        set_colors
        puts @@dammy_string
    end
end
