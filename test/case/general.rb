class TestColorEcho < MiniTest::Unit::TestCase
    def test_general
        do_test_general
    end

    def test_general_unuse
        exec %(CE.unuse)
        do_test_general
    end

    def do_test_general
        exec %(CE.ch :yellow)
        puts "fooooooooo"
        puts "baaaaaaaar"
        puts "AAAAA", "BBBBB", "CCCCC"

        exec %(CE.ch :white, :red)
        print "fooooooooo"
        print "baaaaaaaar"
        print "AAAAA", "BBBBB", "CCCCC"

        exec %(CE.ch :black, :magenta, :underscore)
        p "fooooooooo"
        p "baaaaaaaar"
        p "AAAAA", "BBBBB", "CCCCC"

        ary = ["Duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate"]

        exec %(CE.off)
        puts "switch off all colors and attribute."

        exec %(CE.fg :red)
        puts ary

        exec %(CE.bg :cyan)
        print ary

        exec %(CE.tx :underscore)
        p ary

        exec %(CE.fg(:black).bg(:white).tx(:blink))
        puts <<-EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.
        EOM

        exec %(CE.off)
        exec %(CE.rainbow)
        puts "fooooooooo"
        puts "baaaaaaaar"
        puts "AAAAA", "BBBBB", "CCCCC"
        puts ary

        print "fooooooooo"
        print "baaaaaaaar"
        print "AAAAA", "BBBBB", "CCCCC"
        print ary

        p "fooooooooo"
        p "baaaaaaaar"
        p "AAAAA", "BBBBB", "CCCCC"
        p ary

        puts <<-EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.
        EOM

        exec %(CE.tx(:underscore).bg(:black))
        exec %(CE.rainbow)
        hash = {:foo => [111, 222, 333], :bar => {:str => String}}
        p hash
        p "fooooooo", ["AAA", "BBB", "CCC"]

        exec %(CE.off)
        puts "Disable rainbow mode."

        exec %(CE.ch :h_red, nil, :underscore)
        puts "Dammy Dammy Dammy"
    end
end
