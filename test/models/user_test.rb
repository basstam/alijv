require "test_helper"

describe User do
  before do
    @user = User.create!(:email => 'bas@dovadi.nl', :password => 'admin1234')
  end

  it "must be valid" do
    @user.valid?.must_equal true
  end
end

