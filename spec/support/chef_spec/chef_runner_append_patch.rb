class ChefSpec::Runner
  def append(recipe)
    runner = Chef::Runner.new(recipe.run_context)
    runner.converge
    self
  end
end
