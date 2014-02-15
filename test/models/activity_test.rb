require 'test_helper'

describe Activity do
  
  it 'should have a description' do
    activity = Activity.create(:name => 'Veldloop')
    activity.errors[:description].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a name' do
    activity = Activity.create(:name => 'Veldloop')
    activity.errors[:description].must_equal ["moet opgegeven zijn"]
  end
end