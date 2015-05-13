class TestColorEcho < Minitest::Test
    def output_text
        puts "HogexxxxxxxxxxHOGExxxxhogexxxxxxHoGexxxxxxXXXxxxxxhogexxxxxxxxxxxxxhoGe"
        puts "HogexxxxxxxxxxPiYOxxxxhogexxxxxxpiyoxxxxxxXXXxxxxxhogexxxxxxxxxxxxxhoGe"
        puts "xxXXXXXxxxxxxxFooxxxxxXXxxxxxxxxxxxxxXXxxxxXxxxxxxxxxxxxxxxxxxxxxxxxxxX"
    end

    def test_hitline
        text = <<-EOS
        EOS
        info "Dammy text is -> " + text

        exec %(CE.hitline :yellow)
        output_text

        exec %(CE.pickup /piyo/, :red)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup(/piyo/, :blue))
        output_text

        exec %(CE.fg :gray)
        output_text

        exec %(CE.hitline :index99, nil)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup /piyo/, :red)
        exec %(CE.hitline nil, nil, :underscore)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup /hoge/i, :red, :gray, :underscore)
        exec %(CE.hitline nil, :h_red, [:underscore,:bold])
        output_text
    end
end
