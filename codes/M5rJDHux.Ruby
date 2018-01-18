require 'rails_helper'

RSpec.describe "Foo" do

  before do
    puts "Was bananas called yet?"
  end

  Given(:bar) { puts "bar" }
  Given!(:bananas) { puts "bananas" }

  When do
    bar
    bananas
  end
  Then do
    true
  end
end

RSpec.describe "Foo" do
  let(:bar) { puts "bar" }
  let!(:bananas) { puts "bananas" }

  before do
    puts "Was bananas called yet?"
  end
  it 'does stuff' do
    bar
    bananas
  end
end