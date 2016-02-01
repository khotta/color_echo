class TestColorEcho < Minitest::Test
    def test_puts
        info "pure output"
        puts_patterns

        set_colors
        puts_patterns
    end

    def test_p
        info "pure output"
        p_patterns

        set_colors
        p_patterns
    end

    def test_print
        info "pure output"
        print_patterns

        set_colors
        print_patterns
    end

    def test_printf
        info "pure output"
        dump_by_printf

        set_colors
        dump_by_printf
    end

    def test_putc
        info "pure output"
        dump_by_putc

        set_colors
        dump_by_putc
    end
end
