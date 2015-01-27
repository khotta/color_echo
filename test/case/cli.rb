class TestColorEcho < Minitest::Test
    def test_cli_display
        cmd = %(color_echo)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -v)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -s)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -l)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -h)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo --symbol-list)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo --index-list)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo --symbol_list)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo --index_list)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_invalid
        cmd = %(color_echo --test)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_std
        cmd = %(color_echo Hello\!\!)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -f red Hello\!\! color_echo, color color color)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo Dammy Dammy Dammy -b red)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -f black Dammy Dammy Dammy -b index188)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore Dammy Dammy Dammy)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore,bold,blink,reverse_video Dammy Dammy Dammy)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore Dammy Dammy Dammy -f index188)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo Dammy Dammy Dammy -t bold -b green)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -n Dammy Dammy Dammy; color_echo Dammy Dammy Dammy; color_echo Dammy Dammy Dammy)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_pipe
        cmd = %(echo FooFoOfOO | color_echo -t reverse_video)
        info cmd
        puts `#{cmd}`

        cmd = %(echo FooFoOfOO | color_echo -f index130 -p /foo$/i | color_echo -f index180 -p /^foo/i)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo hogepiyofuga -p fuga)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo hogepiyofuga -p fuga -p hoge -t blink -f green)
        info cmd
        puts `#{cmd}`

        cmd = %(netstat -na | color_echo -p ":80" | color_echo -p "127.0.0.1" -f h_cyan | head)
        info cmd
        puts `#{cmd}`

        cmd = %(cat case/dammy.txt | color_echo -p "123.456.789.12" -f h_cyan -t underscore)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo foo -f green | color_echo bar -f red)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo foo -f green -n | color_echo bar -f red)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_redirect
        cmd = %(color_echo < case/dammy.txt)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -b red -t underscore,bold -p "foo" < case/dammy.txt)
        info cmd
        puts `#{cmd}`

        cmd = %((color_echo -f cyan -p /\\\\s2..\\\\s/ | color_echo -f h_green -p /\\\\s4..\\\\s/ | color_echo -f h_red -p /\\\\s5..\\\\s/) < case/dammy.txt)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_stripe
        cmd = %(color_echo --stripe < case/dammy.txt)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -f white -b blue -t bold --stripe < case/dammy.txt)
        info cmd
        puts `#{cmd}`

        cmd = %(color_echo -f h_blue --stripe -p hoge < case/dammy.txt)
        info cmd
        puts `#{cmd}`
    end

    def test_cli_watch
        info %(Do -> tailf /var/log/httpd/access_log | color_echo -w)
        info %(Do -> tailf /var/log/httpd/access_log | color_echo -w -p "some pattern")
        info %(DO -> tailf /var/log/httpd/access_log | color_echo -w -f black -b index150 -t bold --stripe)
        info %(DO -> tailf /var/log/httpd/access_log | color_echo -w -f black -b index150 -t bold --stripe -p hoge)
    end
end
