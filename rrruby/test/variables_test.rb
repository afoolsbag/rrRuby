#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

##
# <b>变量</b>
#
# [常量] 常量以大写字母起头，一般采用全大写风格，如 +CONSTANT+；特别的，类和模组采用大驼峰风格，如 +Class+。
#
# [全局变量] 全局变量以 <code>$</code> 起头，如 <code>$global_variable</code>。
#
# [类变量] 类变量以 <code>@@</code> 起头，如 <code>@@class_property</code>。
#
# [实例变量] 实例变量以 <code>@</code> 起头，如 <code>@instance_property</code>。
#
# [局部变量] 局部变量以小写字母或下划线起头，如 +local_variable+。
#
class VariableTest < Test::Unit::TestCase

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
