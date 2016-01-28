class TestColorEcho < Minitest::Test
    def test_cli_display
        cmd = %(colorecho)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -v)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho --version)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -s)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho --symbol-list)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -l)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho --index-list)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -h)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho --help)
        history cmd
        puts `#{cmd}`
    end
end
