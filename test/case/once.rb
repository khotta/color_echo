class TestColorEcho < MiniTest::Unit::TestCase
    def test_once
        exec %(CE.once.ch :h_yellow, :h_red, :underscore)
        puts "decorated"
        puts "switch off" + $/

        exec %(CE.times(3).rainbow)
        puts "one"
        puts "two"
        puts "three"
        puts "switch off"
    end
end
