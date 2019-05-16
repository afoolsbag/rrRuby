#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC4RegExp < Test::Unit::TestCase
  def test_regular_expression
    regexp = /word_one|word_two/
    assert_match(regexp, 'word_one')
    assert_not_nil('word_two' =~ regexp)
  end

end
