class TestColorEcho < Minitest::Test
    def test_cli_display
        cmd = %(color_echo)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -v)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -s)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -l)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -h)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo --symbol-list)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo --index-list)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo --symbol_list)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo --index_list)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_invalid
        cmd = %(color_echo --test)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_std
        cmd = %(color_echo Hello\!\!)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -f red Hello\!\! color_echo, color color color)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo Dammy Dammy Dammy -b red)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -f black Dammy Dammy Dammy -b index188)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore,bold,blink,reverse_video Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -t underscore Dammy Dammy Dammy -f index188)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo Dammy Dammy Dammy -t bold -b green)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -n Dammy Dammy Dammy; color_echo Dammy Dammy Dammy; color_echo Dammy Dammy Dammy)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo "hoge\\nhoge")
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo "hoge\\nhoge" -e)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo "hoge\\rho\\nge" -e)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo "hoge\\r\\nhoge")
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo "hoge\\r\\nhoge" -e)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_pipe
        cmd = %(echo FooFoOfOO | color_echo -t reverse_video)
        history cmd
        puts `#{cmd}`

        cmd = %(echo FooFoOfOO | color_echo -f index130 -p /foo$/i | color_echo -f index180 -p /^foo/i)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo hogepiyofuga -p fuga)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo hogepiyofuga -p fuga -p hoge -t blink -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(netstat -na | color_echo -p ":80" | color_echo -p "127.0.0.1" -f h_cyan | head)
        history cmd
        puts `#{cmd}`

        cmd = %(cat case/dammy.txt | color_echo -p "123.456.789.12" -f h_cyan -t underscore)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo foo -f green | color_echo bar -f red)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo foo -f green -n | color_echo bar -f red)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_redirect
        cmd = %(color_echo < case/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -b red -t underscore,bold -p "foo" < case/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %((color_echo -f cyan -p /\\\\s2..\\\\s/ | color_echo -f h_green -p /\\\\s4..\\\\s/ | color_echo -f h_red -p /\\\\s5..\\\\s/) < case/dammy.txt)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_stripe
        cmd = %(color_echo --stripe < case/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -f white -b blue -t bold --stripe < case/dammy.txt)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo -f h_blue --stripe -p hoge < case/dammy.txt)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_watch
        history %(Do -> tailf /var/log/httpd/access_log | color_echo -w)
        history %(Do -> tailf /var/log/httpd/access_log | color_echo -w -p "some pattern")
        history %(DO -> tailf /var/log/httpd/access_log | color_echo -w -f black -b index150 -t bold --stripe)
        history %(DO -> tailf /var/log/httpd/access_log | color_echo -w -f black -b index150 -t bold --stripe -p hoge)
        history %(DO -> tailf /var/log/httpd/access_log | colorecho -w -f index235 -r | colorecho -w -p "pattern1" -f index3 -t underscore,bold -H index85 -r | colorecho -w -p "pattern2" -f index28,nil -t underscore,bold -H index46 -r | colorecho -w -p "pattern3" -t bold,underscore -f index198 -H index178 -r)
    end

    def test_cli_optperse
        cmd = %(color_echo --help)
        history cmd
        puts `#{cmd}`

        cmd = %(color_echo --version)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_link
        cmd = %(colorecho)
        history cmd
        puts `#{cmd}`
    end

    def test_cli_highlight
        pt1 = "HogeHOgeHOGE"
        pt2 = "PIyopiyoPIYO"
        pt3 = "FooFofoooFoO"

        cmd  = %(  echo #{pt1} | colorecho -f index150)
        cmd += %(; echo #{pt2} | colorecho -f index150)
        cmd += %(; echo #{pt3} | colorecho -f index150)
        history cmd
        puts `#{cmd}`

        cmd  = %(  echo #{pt1} | colorecho -f index150 -p /piyo$/i)
        cmd += %(; echo #{pt2} | colorecho -f index150 -p /piyo$/i)
        cmd += %(; echo #{pt3} | colorecho -f index150 -p /piyo$/i)
        history cmd
        puts `#{cmd}`

        cmd  = %(  echo #{pt1} | colorecho -f index150 -p /piyo$/i -H "index10")
        cmd += %(; echo #{pt2} | colorecho -f index150 -p /piyo$/i -H "index10")
        cmd += %(; echo #{pt3} | colorecho -f index150 -p /piyo$/i -H "index10")
        history cmd
        puts `#{cmd}`

        cmd = %(echo #{pt2} | colorecho -b index150 -f black -t underscore -p /piyo$/i --highlight "nil,black")
        history cmd
        puts `#{cmd}`

        cmd = %(echo #{pt2} | colorecho -b index150 -f black -t underscore -p /piyo$/i -H "nil,nil,blink,bold,underscore")
        history cmd
        puts `#{cmd}`

        cmd  = %(  echo #{pt1} | colorecho -f index234 | colorecho -p /piyo$/i -H yellow -f h_yellow -t underscore,bold -r)
        cmd += %(; echo #{pt2} | colorecho -f index234 | colorecho -p /piyo$/i -H yellow -f h_yellow -t underscore,bold -r)
        cmd += %(; echo #{pt3} | colorecho -f index234 | colorecho -p /piyo$/i -H yellow -f h_yellow -t underscore,bold -r)
        history cmd
        puts `#{cmd}`

        cmd = %(netstat -nat | colorecho -p ESTABLISHED -H "cyan,nil,underscore")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_refresh
        cmd = %(colorecho test -f red | colorecho -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -r -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -R -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -f green -p /^t/)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -r -f green -p /^t/)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red | colorecho -R -f green -p /^t/)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red -b index199 -t bold | colorecho -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red -b index199 -t bold | colorecho --refresh-pre-match -f green)
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho test -f red -b index199 -t bold | colorecho --refresh -f green)
        history cmd
        puts `#{cmd}`
    end
end
