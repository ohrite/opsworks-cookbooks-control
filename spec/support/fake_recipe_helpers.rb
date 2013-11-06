module FakeRecipeHelpers
  def fake_recipe(cookbook_name, recipe_name, run, &block)
    recipe = Chef::Recipe.new(cookbook_name, recipe_name, run.run_context)
    recipe.instance_eval(&block)
  end
end
