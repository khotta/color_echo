# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_echo'

Gem::Specification.new do |s|
    s.name                  = CE::LIBS_NAME
    s.version               = CE::VERSION
    s.summary               = CE::SUMMARY
    s.description           = CE::DESCRIPTION
    s.homepage              = CE::DOCS_PAGE
    s.authors               = ["khotta"]
    s.license               = "MIT"
    s.post_install_message  = "#{$-0}Thank you for installing! =(^x^="
    s.post_install_message += "#{$-0}See also #{CE::DOCS_PAGE}#{$-0}#{$-0}"

    # include files to this gem package.
    s.files  = Dir["*.txt"]
    s.files += Dir["*.md"]
    s.files += Dir['lib/*.rb']
    s.files += Dir['lib/color_echo/*.rb']
    s.files += Dir['lib/color_echo/module/*.rb']
    s.files += Dir["bin/color_echo"]

    # platform this gem runs on.
    #s.platform = Gem::Platform.local

    # required ruby version
    s.required_ruby_version = '>= 1.9.3'

    # required path
    s.require_paths = ["lib"]

    # executable command
    s.executables = s.files.grep(%r{^bin/}) do |f|
        File.basename(f)
    end
end
