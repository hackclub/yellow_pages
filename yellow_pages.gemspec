# frozen_string_literal: true

require_relative "lib/yellow_pages/version"

Gem::Specification.new do |spec|
  spec.name = "yellow_pages"
  spec.version = YellowPages::VERSION
  spec.authors = ["Max Wofford"]
  spec.email = ["max@maxwofford.com"]

  spec.summary = "A hand-crafted list of Merchant IDs from Stripe."
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/hackclub/yellow_pages"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/commits/main/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
