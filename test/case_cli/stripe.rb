class TestColorEcho < Minitest::Test
    def test_cli_stripe
        cmd = %(colorecho --stripe < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -f white -b blue -t bold --stripe < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -f yellow --stripe -p hoge < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`
    end
end
