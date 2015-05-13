class TestColorEcho < Minitest::Test
    def test_clean
        text = %(\033[33m\033[4m\033[45minfected text\033[0m)
        puts text

        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.enableclean)
        exec %(CE.ch :black, :h_white, :bold)
        puts text

        exec %(CE.disableclean)
        exec %(CE.ch :black, :h_white, :bold)
        puts text
    end
end
