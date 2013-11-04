RSpec::Matchers.define :create_postgresql_database do |database|
  match do |chef_runner|
    ChefSpec::Matchers::ResourceMatcher.new(:postgresql_database, :create, database).matches?(chef_runner)
  end
end
