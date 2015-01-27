class TestColorEcho < Minitest::Test
    def test_rainbow_puts
        info "Not overwrite"
        puts_patterns

        exec %(CE.rainbow)
        puts_patterns
    end

    def test_rainbow_print
        info "Not overwrite"
        print_patterns

        exec %(CE.rainbow)
        print_patterns
    end
    def test_rainbow_p
        info "Not overwrite"
        p_patterns

        exec %(CE.rainbow)
        p_patterns
    end
end
