class TestColorEcho < Minitest::Test
    def test_cli_watch
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w)
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w -p "pattern")
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w -f gray -p pattern,h_red,nil,bold,underline -H h_cyan)
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w --stripe)
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -f index205 -w | colorecho -w --stripe -f index156 -R)
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w -f gray -p "pattern1,h_yellow,nil,bold,underline" -H index156 -p "pattern2,h_red,nil,bold,underline" -H index197)
        history %(Do -> tailf /var/log/httpd/access_log | colorecho -w -f index235 -p "pattern1,index3,nil,underline,bold" -H index85 -p "pattern2,index28,nil,underline,bold" -H index46 -p "pattern3,index198,nil,bold,underline" -H index178)
    end
end
