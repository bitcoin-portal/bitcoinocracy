require "rails_helper"

RSpec.describe Argument, :type => :model do
  it "strips and squishes the statement upon creation" do
    argument = Argument.create(statement: ' test  is a test ')
    expect(argument.reload.statement).to eq('test is a test')
  end
end
