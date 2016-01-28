class TestColorEcho < Minitest::Test
    def test_fg
        exec %(CE.fg :h_red)
        puts @@dammy_string

        exec %(CE.bg :red)
        exec %(CE.tx :bold)
        exec %(CE.fg :index150)
        puts @@dammy_string

        exec %(CE.fg :index199)
        exec %(CE.bg :white)
        exec %(CE.tx :bold)
        puts @@dammy_string
    end
end
