class TestColorEcho < Minitest::Test
    def test_cli_redirect
        cmd = %(colorecho < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -b red -t underline,bold -p "foo" < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %((colorecho -f gray -p /\\\\s2..\\\\s/ -p /\\\\s4..\\\\s/,h_green -p /\\\\s5..\\\\s/,h_red) < case_cli/dammy.txt)
        history cmd
        puts `#{cmd}`
    end
end
