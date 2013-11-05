require "spec_helper"

describe "deploy::swapfile" do
  let(:chef) { ChefSpec::Runner.new }

  subject(:chef_run) { chef.converge(described_recipe) }

  it { should create_swap_file("/mnt/swap") }
end
