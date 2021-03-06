# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_echo'

Gem::Specification.new do |s|
    s.name                  = CE::LIBS_NAME
    s.version               = CE::VERSION
    s.summary               = CE::SUMMARY
    s.description           = CE::DESCRIPTION
    s.homepage              = CE::HOMEPAGE
    s.authors               = ["khotta"]
    s.email                 = ["khotta116@gmail.com"]
    s.license               = "MIT"
    s.post_install_message  = "#{$-0}Thank you for installing! =(^x^="
    s.post_install_message += "#{$-0}See also #{CE::HOMEPAGE}#{$-0}#{$-0}"

    # include files to this gem package.
    s.files  = Dir["*.txt"]
    s.files += Dir["*.md"]
    s.files += Dir['lib/*.rb']
    s.files += Dir['lib/color_echo/*.rb']
    s.files += Dir['lib/color_echo/module/*.rb']
    s.files += Dir["bin/color_echo"]
    s.files += Dir["bin/lib/*.rb"]

    # platform this gem runs on.
    #s.platform = Gem::Platform.local

    # required ruby version
    s.required_ruby_version = '>= 2.0.0'

    # required path
    s.require_paths = ["lib"]

    # executable command
    s.executables << "colorecho"
end
