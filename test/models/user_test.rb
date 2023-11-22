# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test 'name_or_email' do
    user = users(:alice)
    assert_equal 'alice', user.name_or_email

    user = users(:bob)
    assert_equal 'bbb@example.com', user.name_or_email
  end
end
