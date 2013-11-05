RSpec::Matchers.define :create_swap_file do |path|
  match do |chef_runner|
    ChefSpec::Matchers::ResourceMatcher.new(:swap_file, :create, path).matches?(chef_runner)
  end
end
