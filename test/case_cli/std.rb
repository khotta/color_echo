class TestColorEcho < Minitest::Test
    def test_cli_std
        cmd = %(colorecho Hello\!\!)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -f red Hello\!\! colorecho, color color color)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho Dammy Dammy Dammy -b red)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -f black Dammy Dammy Dammy -b index188)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -t underline Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -t underline,bold,blink,reverse_video Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -t underline Dammy Dammy Dammy -f index188)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho Dammy Dammy Dammy -t bold -b green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -n Dammy Dammy Dammy; colorecho Dammy Dammy Dammy; colorecho Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "hoge\\nhoge")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "hoge\\nhoge" -e)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "hoge\\rho\\nge" -e)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "hoge\\r\\nhoge")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "hoge\\r\\nhoge" -e)
        history cmd
        puts `#{cmd}`
    end
end
