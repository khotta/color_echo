class TestColorEcho < Minitest::Test
    def test_cli_pickup
        pt  = "FoofooFOO\\n"
        pt += "BarbarBAR\\n"
        pt += "bazbAzBAz"

        cmd  = %(colorecho -e "#{pt}" -p /baz/i)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "baz")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "foo" --stripe)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "foo,green")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "/foo/i,h_white,blue")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "baz,index99,black,bold")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "baz,index199,white,bold,blink,underline")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "a,nil,nil,bold,underline")
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "a,nil,nil,bold,underline" -f gray)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p "a,red,white,bold,underline" -f black -b white -t underline)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p /Foo/ -p OO -p BAR -p Az)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -f gray -p /Foo/,red -p OO,green -p BAR,yellow -p Az,magenta,nil,bold)
        history cmd
        puts `#{cmd}`
    end
end
