#
# Test Code
#
#require_relative "../lib/color_echo.rb"
require "color_echo"

require 'minitest/unit'
require 'minitest/autorun'

require_relative "case/general"
require_relative "case/once"
require_relative "case/off"
require_relative "case/textattr"
require_relative "case/pickup"
require_relative "case/bin"

class TestColorEcho < MiniTest::Unit::TestCase
    def setup
        #$stdout.print $/ + "    >>> Test case start!"
        #exec %(CE.off)
        CE.off
    end

    def teardown
        #$stdout.print $/ + "    >>> Test case finished!"
        #exec %(CE.off)
        CE.off
    end

    def exec(cm)
        eval cm
        $stdout.print <<-EOS

  #----------------------------------------------------------------------------------------------------------------------
  #
  #  * Executed ->  #{cm}
  #
  #----------------------------------------------------------------------------------------------------------------------
        EOS
    end

    def info(mes)
        $stdout.puts "  * [INFO] " + mes
    end

    def test_list
        ls = public_methods(false).grep(/^test_/)
        ls.delete(__method__)
        puts "    >>> Test case list"
        ls.each do |name|
            puts "        * #{name}"
        end
    end
end

