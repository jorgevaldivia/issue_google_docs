# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "issue_google_docs/version"

Gem::Specification.new do |s|
  s.name        = "issue_google_docs"
  s.version     = IssueGoogleDocs::VERSION
  s.authors     = ["Jorge Valdivia"]
  s.email       = ["jorge@valdivia.me"]
  s.homepage    = ""
  s.summary     = %q{Connects issue management systems like Jira and Fogbugz to Google Docs.}
  s.description = %q{Connects issue management systems like Jira and Fogbugz to Google Docs.}

  s.rubyforge_project = "issue_google_docs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency 'gdata'
  s.add_runtime_dependency 'pp'
  s.add_runtime_dependency 'nokogiri'
end
