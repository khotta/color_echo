class TestColorEcho < Minitest::Test
    def output_text
        puts "HogexxxxxxxxxxHOGExxxxhogexxxxxxHoGexxxxxxXXXxxxxxhogexxxxxxxxxxxxxhoGe"
        puts "HogexxxxxxxxxxPiYOxxxxhogexxxxxxpiyoxxxxxxXXXxxxxxhogexxxxxxxxxxxxxhoGe"
        puts "xxXXXXXxxxxxxxFooxxxxxXXxxxxxxxxxxxxxXXxxxxXxxxxxxxxxxxxxxxxxxxxxxxxxxX"
    end

    def test_highlight
        exec %(CE.highlight :yellow)
        output_text

        exec %(CE.pickup /piyo/, :red)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup(/piyo/, :blue))
        output_text

        exec %(CE.fg :gray)
        output_text

        exec %(CE.highlight :index99, nil)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup /piyo/, :red)
        exec %(CE.highlight nil, nil, :underline)
        output_text

        exec %(CE.reset)

        exec %(CE.pickup /hoge/i, :red, :gray, :underline)
        exec %(CE.highlight nil, :h_red, [:underline,:bold])
        output_text
    end

    def test_duplicate_highlight
        exec %(CE.fg(:black))
        exec %(CE.highlight(:index206,nil,[:underline,:bold]))
        exec %(CE.highlight(:index144))
        exec %(CE.pickup([/^foo/, /oof/i], :red, nil, :bold))
        exec %(CE.pickup(/bar/, :yellow, nil, :bold))
        exec %(CE.pickup(/ooo/, :green))

        puts "xxxxxxxxxxxxxxxxxxxxxxxxxx"
        puts "fooxfooxxxxxxxxxxxoOFxxxxx"
        puts "xxxxxxxxxxxxxxxxxxxxxxxxxx"
        puts "xxxxxxxxxxxxxxxxxxxxxxxxxx"
        puts "xxxxxxxxxbarxxxxxxxxxxxxxx"
        puts "xxxxxxxxxxxxxxxxxxxxxxxbar"
        puts "xxxxxxxxxxxxxxfooxxxxxxxxx"
        puts "xxxxbarbarxxxxxxxxOofxxxxx"
        puts "xxxxxxxxxxxxxxxxxxxxxxxxxx"
        puts "xxxxxxxxxoooxxxxxxxxxxxxxx"
        puts "foooxxbarxooOOFooooofxxfoo"
        puts "xxxxbarbarxxxxxxoofxxxxxxx"
    end
end
