# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test 'name_or_email' do
    user = users(:alice)
    assert_equal user.name_or_email, 'Alice'

    user = users(:bob)
    assert_equal user.name_or_email, 'bob@example.com'
  end
end
