#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

# 循环
class TestCaseForLoop < Test::Unit::TestCase

  # while-end 循环语句
  def test_while_end
  end

  # 对于单行代码，建议使用 while 修饰语法
  def test_while_modifier
  end

  # until-end 循环语句
  def test_until_end
  end

  # 对于单行代码，建议使用 until 修饰语法
  def test_until_modifier
  end

  # loop-do-break-end 循环语句
  #   为了与 while 修饰区分，Ruby 不提供 do-while 循环，而以 loop-do-break-end 代之
  def test_loop_do_break_end
    i = 0
    loop do
      puts "loop #{i += 1}"
      break if [true, false].sample
    end
  end

end
