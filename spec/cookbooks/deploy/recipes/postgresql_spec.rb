require "spec_helper"

describe "deploy::postgresql" do
  let(:chef) { ChefSpec::Runner.new }

  subject(:chef_run) { chef.converge(described_recipe) }

  before do
    Chef::Recipe.any_instance.stub(:include_recipe).with("deploy")
  end

  it "includes the deploy recipe" do
    Chef::Recipe.any_instance.should_receive(:include_recipe).with("deploy")
    chef.converge(described_recipe)
  end

  context "when no app exists" do
    before { chef.node.set[:deploy] = {} }

    it { should_not create_postgresql_database }
  end

  context "when an app exists" do
    context "when no database is specified" do
      before { chef.node.set[:deploy][:um] = {} }

      it { should_not create_postgresql_database }
    end

    context "when the wrong kind of database is specified" do
      before { chef.node.set[:deploy][:um][:database][:adapter] = "hotdoge" }

      it { should_not create_postgresql_database }
    end

    context "when a postgresql database is specified" do
      before do
        chef.node.set[:deploy][:um][:database][:adapter] = "postgresql"
        chef.node.set[:deploy][:um][:database][:database] = "taco panic"
      end

      context "when postgresql is not configured" do
        specify { expect { chef_run }.to raise_error(NoMethodError) }
      end

      context "when postgresql is correctly configured" do
        before do
          chef.node.set[:postgresql][:config][:port] = 666
          chef.node.set[:postgresql][:password][:postgres] = "wailing hell"
        end

        it { should create_postgresql_database("taco panic") }
      end
    end
  end
end
