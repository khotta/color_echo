class TestColorEcho < Minitest::Test
    def test_tx
        exec %(CE.tx :underscore)
        puts @@dammy_string

        exec %(CE.tx [:underscore, :blink, :bold])
        puts @@dammy_string

        exec %(CE.tx :underscore)
        exec %(CE.tx :blink)
        puts @@dammy_string

        exec %(CE.bg :red)
        exec %(CE.tx :bold)
        exec %(CE.tx [:underscore, :blink, :bold])
        puts @@dammy_string

        exec %(CE.fg :index199)
        exec %(CE.bg :white)
        exec %(CE.tx [:underscore, :blink, :bold])
        puts @@dammy_string
    end
end
