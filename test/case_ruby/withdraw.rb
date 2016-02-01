class TestColorEcho < Minitest::Test
    def test_withdraw
        exec %(STDOUT.print CE.get_assigned)
        exec %(STDOUT.print CE.get_assigned.class)
        dump_assigned

        exec %(STDOUT.print CE.withdraw(:p))
        exec %(STDOUT.print CE.get_assigned)
        dump_assigned

        exec %(STDOUT.print CE.withdraw("puts"))
        exec %(STDOUT.print CE.get_assigned)
        dump_assigned

        exec %(STDOUT.print CE.withdraw(:puts, "putc", :print))
        exec %(STDOUT.print CE.get_assigned)
        dump_assigned
    end

    private
    def dump_assigned
        exec %(CE.fg :red)
        puts "puts"

        exec %(CE.fg :green)
        print "print"

        exec %(CE.fg :blue)
        p "p"

        exec %(CE.fg :yellow)
        printf "%s", "printf"

        exec %(CE.fg :magenta)
        putc "putc"
        STDOUT.puts "\n\n" + "=" * 50 + "\n\n"
    end
end
