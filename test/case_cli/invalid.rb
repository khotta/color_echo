class TestColorEcho < Minitest::Test
    def test_cli_invalid
        cmd = %(colorecho --test)
        history cmd
        puts `#{cmd}`
    end
end
