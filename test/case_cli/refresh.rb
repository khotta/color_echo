class TestColorEcho < Minitest::Test
    def test_cli_refresh
        cmd = %(colorecho test -f red | colorecho -f green)
        history cmd
        info %(expect: red)
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -r -f green)
        history cmd
        info %(expect: red)
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -R -f green)
        history cmd
        info %(expect: green)
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -f green -p /^t/)
        history cmd
        info %(expect: red)
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -r -f green -p /^t/)
        history cmd
        info %(expect: cyan, green)
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -R -f green -p /^t/)
        history cmd
        info %(expect: cyan, green)
        puts `#{cmd}`

        cmd = %(colorecho test -f h_white -b blue -t bold | colorecho -f green)
        history cmd
        info %(expect: fg is h_white)
        puts `#{cmd}`

        cmd = %(colorecho test -f h_white -b blue -t bold | colorecho --refresh-match -f green)
        history cmd
        info %(expect: fg is h_white)
        puts `#{cmd}`

        cmd = %(colorecho test -f h_white -b blue -t bold | colorecho --refresh -f green)
        history cmd
        info %(expect: fg is green)
        puts `#{cmd}`
    end
end
