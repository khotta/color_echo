class TestColorEcho < Minitest::Test
    def test_tx
        exec %(CE.tx :underline)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.tx :bold)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.tx :blink)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.tx :reverse_video)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.tx :concealed)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.tx :underline)
        puts @@dammy_string
        exec %(CE.tx :bold)
        puts @@dammy_string
        exec %(CE.tx :blink)
        puts @@dammy_string
        exec %(CE.tx :reverse_video)
        puts @@dammy_string

        exec %(CE.reset)
        exec %(CE.fg :index199)
        exec %(CE.bg :white)
        exec %(CE.tx [:underline, :blink, :bold])
        puts @@dammy_string
    end
end
