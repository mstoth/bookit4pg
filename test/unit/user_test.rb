require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "zip is 18103" do
    u=users(:mstoth)
    assert u.zip == "18103"
  end
  
  
end
