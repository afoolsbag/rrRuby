#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC4Flow < Test::Unit::TestCase
  def test_branch
    con = 1 + rand(5)
    if 4 < con
      assert_true 5 <= con && con <= 6
    elsif 2 < con
      assert_true 3 <= con && con <= 4
    else
      assert_true 1 <= con && con <= 2
    end
  end

  def test_loop
    i = 9
    while 0 < i
      i -= 1
    end
  end

  def test_modifiers
    failed = false
    assert_fail_assertion if failed

    i = 9
    i -= 1 while 0 < i
    assert_equal(0, i)
  end

end
