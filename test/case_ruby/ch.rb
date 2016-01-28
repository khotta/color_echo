class TestColorEcho < Minitest::Test
    def test_ch
        exec %(CE.ch :index78)
        puts @@dammy_string

        exec %(CE.ch nil, :index66)
        puts @@dammy_string

        exec %(CE.ch nil, nil, :underline)
        puts @@dammy_string

        exec %(CE.ch nil, nil, :blink)
        puts @@dammy_string

        exec %(CE.off)

        exec %(CE.ch nil, nil, [:underline, :blink, :bold])
        puts @@dammy_string
    end
end
