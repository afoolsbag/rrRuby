#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

##
# 变量
#
# [局部变量] 局部变量以小写字母或下划线起头，如 +local_variable+。
#
# [实例变量] 实例变量以 <tt>@</tt> 起头，如 <tt>@instance_property</tt>。
#
# [类变量] 类变量以 <tt>@@</tt> 起头，如 <tt>@@class_property</tt>。
#
# [全局变量] 全局变量以 <tt>$</tt> 起头，如 <tt>$global_variable</tt>。
#
# [常量] 常量以大写字母起头，一般采用全大写风格，如 +CONSTANT+；特别的，类采用大驼峰风格，如 +Class+。
#
class TestCaseForVariable < Test::Unit::TestCase

  def test_variable
    ref1 = 0
    ref2 = ref1
    assert_equal(ref1.object_id, ref2.object_id)
  end

  def test_parallel_assignment
    var1, var2 = 'loo', 'zoo'
    var1, var2 = var2, var1
    assert_equal('zoo', var1)
    assert_equal('loo', var2)
  end
end
