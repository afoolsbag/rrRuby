#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC_MyTest < Test::Unit::TestCase
  # def setup
  # end

  # def teardown
  # end

  def test_fail
    assert(false, 'Assertion was false.')
  end
end
