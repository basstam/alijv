require 'test_helper'

describe Category do

  before do
    @category = Category.new
  end

  it { @category.must have_many(:participations).dependent(:destroy)}
  it { @category.must belong_to(:activity) }

  it { @category.must validate_presence_of(:distance) }

  it { @category.must validate_presence_of(:description) }

  it { @category.must validate_presence_of(:gender) }

  it { @category.must validate_presence_of(:age_from) }
  

end