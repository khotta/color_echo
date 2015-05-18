class TestColorEcho < Minitest::Test
    def test_pickup_reg
        text = "HogexxxxxxxxxxHOGExxxxhogexxxxxxHoGexxxxxxXXXxxxxxhogexxxxxxxxxxxxxhoGe"
        info "Dammy text is -> " + text

        exec %(CE.pickup(/hoge/))
        puts text

        exec %(CE.fg :blue)
        puts text

        exec %(CE.pickup(/hoge$/i, :h_magenta))
        exec %(CE.fg :blue)
        puts text

        exec %(CE.off(:pickup))
        exec %(CE.pickup(/.hoge./))
        puts text

        exec %(CE.off(:pickup))
        exec %(CE.pickup(/hoge$/i, :green))
        puts text

        exec %(CE.off(:pickup))
        exec %(CE.pickup(/^hoge/i, :green))
        puts text

        exec %(CE.off)
        exec %(CE.pickup(/hoge/i, :h_yellow, :black))
        puts text

        exec %(CE.off)
        exec %(CE.pickup([/^hoge/i, /hoge$/i, "XXX"], :index99, nil, :blink))
        puts text
    end

    def test_pickup
        text = <<-EOS

A wonderful serenity has taken possession of my entire soul,
like these sweet mornings of spring which I enjoy with my whole heart.

I am alone, and feel the charm of existence in this spot,
which was created for the bliss of souls like mine. 

I am so happy, my dear friend, so absorbed in the exquisite sense of mere tranquil existence,
that I neglect my talents. 
        EOS

        exec %(CE.fg(:yellow).pickup("and", :h_red))

        puts text

        exec %(CE.off(:pickup))

        puts text

        exec %(CE.pickup(["and", "my"], nil, nil, :underscore))

        puts text

        exec %(CE.off)

        puts text

        exec %(CE.pickup(["and", "in"], :red, :h_yellow))

        puts text

        exec %(CE.off)

        exec %(CE.pickup(["and", "this", "so"], :index54, :index124, [:underscore, :blink]))

        puts text
    end
end
