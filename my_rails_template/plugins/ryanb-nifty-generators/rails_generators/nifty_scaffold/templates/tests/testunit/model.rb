require 'test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  test "should be valid" do
    assert <%= class_name %>.new.valid?
  end
end
