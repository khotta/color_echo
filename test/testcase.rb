#
# List of Test Cases
#
require 'minitest/autorun'
require 'minitest/unit'

require_relative "case/output"
require_relative "case/ch"
require_relative "case/fg"
require_relative "case/bg"
require_relative "case/tx"
require_relative "case/off"
require_relative "case/once"
require_relative "case/pickup"
require_relative "case/hitline"
require_relative "case/rainbow"
require_relative "case/clean"
require_relative "case/get"
require_relative "case/cli"

def require_color_echo
    require "color_echo"
    #require_relative "../lib/color_echo"
end

def require_color_echo_get
    require "color_echo/get"
    #require_relative "../lib/color_echo/get"
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
        exec %(CE.ch :h_green, :h_red, :underscore)
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
