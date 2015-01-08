class TestColorEcho < MiniTest::Unit::TestCase
    def test_textattr
        exec %(CE.once.tx :underscore)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.once.ch :h_cyan, :h_red, :underscore)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.once.ch :h_white, :h_green, [:underscore, :blink, :bold])
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.once.tx [:underscore, :blink, :bold])
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.tx :underscore)
        puts "Dammy Dammy Dammy"

        exec %(CE.tx :blink)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.off)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.once.ch :cyan, nil, :underscore)
        puts "Dammy Dammy Dammy" + $/
    end
end
