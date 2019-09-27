require 'test_helper'

class RateTest < ActiveSupport::TestCase
  test "get_the_rate should be" do
    assert Rate.get_the_rate != nil
  end

  test "rate_should_not_be_zero" do
    params = {rate: "0", overwrite: Time.now}
    rate = Rate.get_the_rate
    assert false == rate.overwrite_the_rate(params)
    assert_equal rate.errors.full_messages, ["Rate can't be zero"]
  end

  test "rate_should_be_overwritten" do
    params = {rate: "98.1236", overwrite: Time.now.tomorrow}
    rate = Rate.get_the_rate
    assert rate.overwrite_the_rate(params)
    assert rate.mantissa == 98
    assert rate.fraction == 1236
  end

  test "update_the_rate" do
    assert Rate.update_the_rate 54, 1234
    rate = Rate.get_the_rate
    assert rate.mantissa == 54
    assert rate.fraction == 1234
  end

  test "update_the_rate_invalid" do
  	Rate.update_the_rate(54, 1234)
  	Rate.update_the_rate(0, 0)
    rate = Rate.get_the_rate
    assert rate.mantissa == 54
    assert rate.fraction == 1234
  end

end
