class TestColorEcho < Minitest::Test
    def test_rainbow_puts
        info "pure output"
        puts_patterns

        exec %(CE.rainbow)
        puts_patterns
    end

    def test_rainbow_p
        info "pure output"
        p_patterns

        exec %(CE.rainbow)
        p_patterns
    end

    def test_rainbow_print
        info "pure output"
        print_patterns

        exec %(CE.rainbow)
        print_patterns
    end

    def test_rainbow_printf
        info "pure output"
        dump_by_printf

        exec %(CE.rainbow)
        dump_by_printf
    end

    def test_rainbow_putc
        info "pure output"
        dump_by_putc

        exec %(CE.rainbow)
        dump_by_putc
    end
end
