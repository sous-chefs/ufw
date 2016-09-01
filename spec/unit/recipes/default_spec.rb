require 'spec_helper'

describe 'ufw::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
