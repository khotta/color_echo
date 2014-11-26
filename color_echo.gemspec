# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'color_echo'
docs_page = "https://github.com/khotta/color_echo"

Gem::Specification.new do |spec|
  spec.name                  = "color_echo"
  spec.version               = CE::VERSION
  spec.summary               = %q{To add color to the command line output.}
  spec.description           = %q{To add color to the command line output.This Library will extend the Kernel module's functions(#print, #puts, #p). required StringIO.}
  spec.homepage              = docs_page
  spec.authors               = ["nyanko"]
  spec.email                 = ["nyanko@dammy"]
  spec.license               = "MIT"
  spec.post_install_message  = "#{$-0}\e[5mThank you for installing! (^-^)\e[0m"
  spec.post_install_message += "#{$-0}See also \e[31m\e[47m \e[4m#{docs_page} \e[0m#{$-0}#{$-0}"

  # include files to this gem package.
  spec.files  = Dir["*.txt"]
  spec.files += Dir["*.md"]
  spec.files += Dir['lib/*.rb']

  # The platform this gem runs on.
  #spec.platform = Gem::Platform.local

  # required ruby version
  #spec.required_ruby_version = '>= 1.9.0'

  # required path from simple_rotate
  spec.require_paths = ["lib"]

  #spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files  = spec.files.grep(%r{^(test|spec|features)/})
end
