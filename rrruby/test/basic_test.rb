#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC4Basic < Test::Unit::TestCase
  def test_everything_is_object
    assert_kind_of(Object, false)
    assert_kind_of(Object, 12345)
    assert_kind_of(Object, 'abc')
  end

  def test_invoke_with_parentheses
    assert_true(true, 'this is okay')
    assert_true true, 'this is okay too'
  end

  def test_string_literal
    assert_equal(2, '\n'.length)
    assert_equal(1, "\n".length)

    key12value23 = 'the string length is 23'
    assert_equal(15, '#{key12value23}'.length)
    assert_equal(23, "#{key12value23}".length)

    $key13value23 = 'the string length is 23'
    assert_equal(14, '#$key13value23'.length)
    assert_equal(23, "#$key13value23".length)

    @@key14value23 = 'the string length is 23'
    assert_equal(15, '#@@key14value23'.length)
    assert_equal(23, "#@@key14value23".length)
  end

  def test_method_return
    assert_true method_with_return
    assert_true method_without_return
  end

  def test_variable
    local_variable = nil
    $global_variable = nil
    @instance_variable = nil
    @@class_variable = nil
  end

  CONSTANT_VARIABLE = nil

end


def method_with_return
  return true
end


def method_without_return
  true
end
