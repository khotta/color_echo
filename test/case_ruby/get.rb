class TestColorEcho < Minitest::Test
    def do_get
        history %(greet  = CE.fg(:yellow).get("Hello"))
        greet  = CE.fg(:yellow).get("Hello")

        history %(name   = CE.ch(:h_blue, :gray).get("Foo"))
        name   = CE.ch(:h_blue, :gray).get("Foo")

        history %(myname = CE.tx(:underline).rainbow.get("Bar"))
        myname = CE.tx(:underline).rainbow.get("Bar")

        history %(puts greet + ", " + name + "!")
        puts greet + ", " + name + "!"

        history %(puts "My name is " + myname)
        puts "My name is " + myname

        history %(output = CE.fg(:blue).pickup(/color$/, :index199).pickup(/^color/, :h_green).get("color color color"))
        output = CE.fg(:blue).pickup(/color$/, :index199).pickup(/^color/, :h_green).get("color color color")

        history %(puts "output is -> " + output)
        puts "output is -> " + output
    end

    def test_get
        info %(required "color_echo/get")
        require_color_echo_get
        do_get
    end

    def test_get_state
        info %(required "color_echo/get")
        require_color_echo_get

        history %(CE.ch(:white, :red))
        CE.ch(:white, :red)

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(CE.stateful)
        CE.stateful

        history %(CE.ch(:white, :red))
        CE.ch(:white, :red)

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(CE.stateful)
        CE.stateful

        history %(CE.stateless)
        CE.stateless

        history %(CE.ch(:white, :red))
        CE.ch(:white, :red)

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")

        history %(puts CE.get("Color Echo"))
        puts CE.get("Color Echo")
    end

    def test_get_err
        info %(required "color_echo")
        require_color_echo
        do_get
    end
end
