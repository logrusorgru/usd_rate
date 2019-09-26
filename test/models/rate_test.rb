require 'test_helper'

class RateTest < ActiveSupport::TestCase
  test "get_the_rate should be" do
    assert Rate.get_the_rate != nil
  end
end
