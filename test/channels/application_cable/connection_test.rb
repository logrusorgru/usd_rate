require 'test_helper'

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects without params" do
    connect
    assert connection != nil
  end
end
