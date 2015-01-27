class TestColorEcho < Minitest::Test
    def test_puts
        info "Not overwrite"
        puts_patterns

        set_colors
        puts_patterns
    end

    def test_print
        info "Not overwrite"
        print_patterns

        set_colors
        print_patterns
    end

    def test_p
        info "Not overwrite"
        p_patterns

        set_colors
        p_patterns
    end
end
