class TestColorEcho < Minitest::Test
    def test_once
        exec %(CE.once.ch :h_yellow, :h_red, :underscore)
        puts @@dammy_string
        puts @@dammy_string

        exec %(CE.times(3).rainbow)
        puts @@dammy_string
        puts @@dammy_string
        puts @@dammy_string
        puts @@dammy_string

        exec %(CE.times(3).fg :h_yellow)
        exec %(CE.pickup(/^Dammy/, :h_green))
        puts @@dammy_string
        puts @@dammy_string
        puts @@dammy_string
        puts @@dammy_string
    end
end
