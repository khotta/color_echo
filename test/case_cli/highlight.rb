class TestColorEcho < Minitest::Test
    def test_cli_highlight
        pt  = "FoofooFOO\\n"
        pt += "BarbarBAR\\n"
        pt += "bazbAzBAz"

        cmd  = %(colorecho -e "#{pt}" -p bAz,h_yellow -H yellow)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p bAz,h_yellow -H yellow,gray)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p bAz,h_yellow -H yellow,gray,bold,underline)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p bAz,h_yellow -H yellow,nil,underline -f gray)
        history cmd
        puts `#{cmd}`

        cmd  = %(colorecho -e "#{pt}" -p bAz,h_yellow -H nil,nil,underline -f gray)
        history cmd
        puts `#{cmd}`
    end
end
