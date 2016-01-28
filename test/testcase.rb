require 'minitest/autorun'
require 'minitest/unit'

# List of test cases
require_relative "case_ruby/output"
require_relative "case_ruby/ch"
require_relative "case_ruby/fg"
require_relative "case_ruby/bg"
require_relative "case_ruby/tx"
require_relative "case_ruby/off"
require_relative "case_ruby/once"
require_relative "case_ruby/pickup"
require_relative "case_ruby/highlight"
require_relative "case_ruby/rainbow"
require_relative "case_ruby/refresh"
require_relative "case_ruby/get"
require_relative "case_cli/display"
require_relative "case_cli/highlight"
require_relative "case_cli/pickup"
require_relative "case_cli/invalid"
require_relative "case_cli/pipe"
require_relative "case_cli/redirect"
require_relative "case_cli/refresh"
require_relative "case_cli/std"
require_relative "case_cli/stripe"
require_relative "case_cli/watch"
require_relative "case_cli/conf"

def require_color_echo
    require "color_echo"
end

def require_color_echo_get
    require "color_echo/get"
end

class TestColorEcho < Minitest::Test
    @@dammy_string = "Dammy Dammy Dammy" + $/
    @@dammy_multi  = "hoge", "piyo", "foo", "bar"
    @@dammy_array  = ["HOGE", "PIYO", "FOO", "BAR"]
    @@dammy_hash   = {
                         :entryA => @@dammy_string,
                         :entryB => {:key1 => 1, "key2" => "2"},
                         :entryC => @@dammy_array,
                         :entryD => {:str => String}
                     } 
    @@dammy_long = <<-EOM
Lorem ipsum dolor sit amet,
consectetur adipisicing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.
        EOM

    def setup
    end

    def teardown
        CE.reset if defined?(CE)
    end

    def exec(cm)
        require_color_echo
        eval cm
        $stdout.print <<-EOS

  #----------------------------------------------------------------------------------------------------------------------
  #
  #  * Executed ->  #{cm}
  #
  #----------------------------------------------------------------------------------------------------------------------
        EOS
    end

    def history(cm)
        $stdout.print <<-EOS

  #----------------------------------------------------------------------------------------------------------------------
  #
  #  * Executed ->  #{cm}
  #
  #----------------------------------------------------------------------------------------------------------------------
        EOS
    end

    def info(mes)
        $stdout.puts $/ + "  * [INFO] " + mes
    end

    def test_list
        ls = public_methods(false).grep(/^test_/)
        ls.delete(__method__)
        puts "    >>> Test case list"
        ls.each do |name|
            puts "        * #{name}"
        end
    end

    def set_colors
        exec %(CE.ch :h_white, :blue, :underline)
    end

    def output_line
        hr = "-" * 10
        $stdout.print <<-EOS

#{hr}

        EOS
    end

    def puts_patterns
        puts @@dammy_string
        output_line
        puts @@dammy_multi
        output_line
        puts @@dammy_array
        output_line
        puts @@dammy_hash
        output_line
        puts @@dammy_long
        output_line
    end

    def print_patterns
        print @@dammy_string
        output_line
        print @@dammy_multi
        output_line
        print @@dammy_array
        output_line
        print @@dammy_hash
        output_line
        print @@dammy_long
        output_line
    end

    def p_patterns
        p @@dammy_string
        output_line
        p @@dammy_multi
        output_line
        p @@dammy_array
        output_line
        p @@dammy_hash
        output_line
        p @@dammy_long
        output_line
    end
end
