#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module Lexicals
  ##
  # 命名。
  #
  # [局部变量名]
  #     <tt>^[a-z]+[0-9A-Z_a-z]*$</tt>
  #
  # [实例变量名]
  #     <tt>^@[A-Za-z]+[0-9A-Z_a-z]*$</tt>
  #
  # [类变量名]
  #     <tt>^@@[A-Za-z]+[0-9A-Z_a-z]*$</tt>
  #
  # [全局变量名]
  #     <tt>^\$[A-Za-z]+[0-9A-Z_a-z]*$</tt>
  #
  # 参见 {Ruby 内核参考：Assignment}[https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html]。
  #
  # [文件名惯例]
  #     <tt>all_lower_with_underscore</tt>
  #
  # [模块名惯例]
  #     <tt>UpperCamelCase</tt>
  #
  # [类名惯例]
  #     <tt>UpperCamelCase</tt>
  #
  # [方法名惯例]
  #     <tt>all_lower_with_underscore</tt>
  #
  # [方法参数名惯例]
  #     <tt>all_lower_with_underscore</tt>
  #
  # [常量名惯例]
  #     <tt>ALL_UPPER_WITH_UNDERSCORE</tt>
  #
  # [全局变量名惯例]
  #     <tt>$all_lower_with_underscore</tt>
  #
  # [类变量名惯例]
  #     <tt>@@all_lower_with_underscore</tt>
  #
  # [实例变量名惯例]
  #     <tt>@all_lower_with_underscore</tt>
  #
  # [局部变量名惯例]
  #     <tt>all_lower_with_underscore</tt>
  #
  class NamesTest < Test::Unit::TestCase; end
end
