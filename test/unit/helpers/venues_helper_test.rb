require 'test_helper'

class VenuesHelperTest < ActionView::TestCase
  
  test "zip too small" do
    v=venues(:me)
    v.zip="1810"
    assert !v.save, "zip too short"
  end
  
end
