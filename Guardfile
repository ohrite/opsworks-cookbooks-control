#!/usr/bin/env ruby
notification :terminal

guard :bundler do
  watch("Gemfile")
end

guard :librarian do
  watch("Cheffile")
  watch(%r{^deploy/.+})
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch("spec/spec_helper.rb")  { "spec" }
  watch(%r{^cookbooks/(.+)/recipes/(.+)\.rb}) do |match|
    "spec/cookbooks/#{match[1]}/recipes/#{match[2]}_spec.rb"
  end
  watch(%r{^cookbooks/(.+)/.+}) { |m| "spec/cookbooks/#{m[1]}/.*_spec\.rb" }
end

guard :foodcritic, cookbook_paths: ["deploy"], all_on_start: false do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
end
