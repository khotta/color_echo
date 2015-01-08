class TestColorEcho < MiniTest::Unit::TestCase
    def test_color_echo
        info %(color_echo)
        print `color_echo`
        print $/+$/

        info %(color_echo -v)
        print `color_echo -v`
        print $/+$/

        info %(color_echo -s)
        print `color_echo -s`
        print $/+$/

        info %(color_echo -l)
        print `color_echo -l`
        print $/+$/
    end
end
