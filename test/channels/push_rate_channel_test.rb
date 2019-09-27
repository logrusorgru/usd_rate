require "test_helper"

class PushRateChannelTest < ActionCable::Channel::TestCase
  test "subscribes and stream for room" do
    subscribe
    assert subscription.confirmed?
    assert_has_stream :push_rate_channel
  end
end
