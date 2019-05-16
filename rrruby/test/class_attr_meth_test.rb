#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class Clazz
  @@class_var = 0

  def Clazz.count_new_times
    return @@class_var
  end

  attr_reader :readable_attr
  attr_writer :writable_attr
  attr_accessor :accessible_attr

  def initialize
    @@class_var += 1

    @readable_attr = nil
    @writable_attr = nil
    @accessible_attr = nil
    @inner_var = nil
  end

  def virtual_attr
    @inner_var
  end

  def virtual_attr=(val)
    @inner_var = val
  end

end

class TC4Class < Test::Unit::TestCase
end
