# frozen_string_literal: true

require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test 'should get find' do
    get addresses_find_url
    assert_response :success
  end

  test 'should get show' do
    get addresses_show_url
    assert_response :success
  end
end
