class TestColorEcho < MiniTest::Unit::TestCase
    def test_off
        exec %(CE.ch :h_green, :h_red, :underscore)
        puts "Dammy Dammy Dammy"

        exec %(CE.off :bg)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.ch :h_green, :h_red, :underscore)
        puts "Dammy Dammy Dammy"

        exec %(CE.off :fg)
        puts "Dammy Dammy Dammy" + $/

        exec %(CE.ch :h_green, :h_red, :underscore)
        puts "Dammy Dammy Dammy"

        exec %(CE.off)
        puts "Dammy Dammy Dammy"
    end
end
