class TestColorEcho < MiniTest::Unit::TestCase
    def test_bg
        exec %(CE.bg :h_red)
        puts @@dammy_string

        exec %(CE.fg :red)
        exec %(CE.tx :bold)
        exec %(CE.bg :index150)
        puts @@dammy_string

        exec %(CE.bg :index199)
        exec %(CE.fg :white)
        exec %(CE.tx :bold)
        puts @@dammy_string
    end
end
