# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scout_apm/version"

has_make = false
ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
  if File.exist?(path) && File.directory?(path) && File.readable?(path) && Dir.entries(path).include?('make')
    has_make = true
    break
  end
end

Gem::Specification.new do |s|
  s.name        = "scout_apm"
  s.version     = ScoutApm::VERSION
  s.authors     = ["Derek Haynes", 'Andre Lewis']
  s.email       = ["support@scoutapp.com"]
  s.homepage    = "https://github.com/scoutapp/scout_apm_ruby"
  s.summary     = "Ruby application performance monitoring"
  s.description = "Monitors Ruby apps and reports detailed metrics on performance to Scout."

  s.rubyforge_project = "scout_apm"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib","data"]

  if has_make
    s.extensions << 'ext/allocations/extconf.rb'
    s.extensions << 'ext/stacks/extconf.rb'
  end

  s.add_runtime_dependency "rusage", '~> 0.2.0'

  s.add_development_dependency "minitest"
  s.add_development_dependency "pry"
  s.add_development_dependency "m"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rake-compiler"
end
