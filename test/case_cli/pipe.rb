class TestColorEcho < Minitest::Test
    def test_cli_pipe
        cmd = %(echo FooFoOfOO | colorecho -t reverse_video)
        history cmd
        puts `#{cmd}`

        cmd = %(echo FooFoOfOO | colorecho -p /foo$/i,green | colorecho -p /^foo/i,red -f yellow)
        history cmd
        puts `#{cmd}`

        cmd = %(netstat -na | colorecho -p ":80" -f green | colorecho -p "127.0.0.1" -r -f blue | head)
        history cmd
        puts `#{cmd}`

        cmd = %(cat case_cli/dammy.txt | colorecho -p "123.456.789.12",red -f cyan -t underline)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho foo -f green | colorecho bar -f red)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho foo -f green -n | colorecho bar -f red)
        history cmd
        puts `#{cmd}`
    end
end
