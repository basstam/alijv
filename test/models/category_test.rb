require 'test_helper'

describe Category do

  before do
     @activity    = activities(:one)
     @category    = Category.create( :activity_id => @activity.id, :description => "M 18plus", :age_from => 18, :distance => 10, :gender => 'M')
  end

  it 'should be valid' do
    assert @category
  end

  it 'should belong to one participant' do
    @category.activity.must_equal @activity
  end
  
  it 'should have a description' do
    category = Category.create(:distance => 2)
    category.errors[:description].must_equal ["moet opgegeven zijn"]
  end

  it 'should have a distance' do
    category = Category.create(:description => 'Mannen senioren')
    category.errors[:distance].must_equal ["moet opgegeven zijn"]
  end

 it 'should have a gender' do
    category = Category.create(:description => 'Mannen senioren')
    category.errors[:gender].must_equal ["moet opgegeven zijn"]
  end

 it 'should have a age_from' do
    category = Category.create(:description => 'Mannen senioren')
    category.errors[:age_from].must_equal ["moet opgegeven zijn"]
  end


end