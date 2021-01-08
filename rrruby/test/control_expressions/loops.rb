#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 控制表达式：循环。
#
# 参见 {Control Expressions}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html]。
#
# zhengrr
# 2019-12-31 – 2021-01-08
# Unlicense

require 'minitest/autorun'

##
# 循环的测试，
class LoopsTest < Minitest::Test
  ##
  # 当（ +while+ ）循环。
  #
  #   while <条件> [do]
  #     <代码块>
  #   end
  #
  # 参见 {while Loop}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-while+Loop]。
  def test_that_while_loop
    nil
  end

  ##
  # 后置条件和无限循环。
  #
  #   loop do
  #     <代码块>
  #     break if <后置条件>
  #   end
  def test_that_do_while_loop
    nil
  end

  ##
  # 直到（ +until+ ）循环。
  #
  #   until <条件> [do]
  #     <代码块>
  #   end
  #
  # 参见 {until Loop}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-until+Loop]。
  def test_that_until_loop
    nil
  end

  ##
  # 迭代（ +for+ ）循环。
  #
  #   for <迭代变量> in <可迭代表达式> [do]
  #     <代码块>
  #   end
  #
  # 因历史遗留，+for+ 循环未隔离变量作用域，通常使用 +.each+ 方法：
  #
  #   <可迭代表达式>.each do |迭代变量|
  #     <代码块>
  #   end
  #
  # 参见 {for Loop}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-for+Loop]。
  def test_that_for_loop
    nil
  end

  ##
  # 修饰符当（ +while+ ）和直到（ +until+ ）。
  #
  #   <代码> while <条件>
  #
  #   <代码> until <条件>
  #
  # 参见 {Modifier while and until}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Modifier+while+and+until]。
  def test_that_modifier_while_and_until
    nil
  end

end

