class TestColorEcho < Minitest::Test
    def test_refresh
        text = %(\033[33m\033[4m\033[45minfected text\033[0m)
        puts text

        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.enable_refresh)
        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.disable_refresh)
        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.enable_refresh :prematch)
        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.pickup "test")
        exec %(CE.enable_refresh :prematch)
        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.pickup "inf")
        exec %(CE.enable_refresh :prematch)
        exec %(CE.ch :black, :h_white, :bold)
        puts text
    end
end
