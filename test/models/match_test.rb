require 'test_helper'

describe Match do

  it 'should be valid' do
    match = Match.create(:name => 'Veldloop', :year => 2014, :distance => 8)
    assert match
  end

end
