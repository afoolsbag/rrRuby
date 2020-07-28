#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 字符串
  #
  # 参见 {Ruby 内核参考：String}[https://ruby-doc.org/core/String.html]。
  class StringTest < Test::Unit::TestCase
    ##
    # <b>字符串字面量</b>
    #
    # 单引号字符串不支持插值，且仅支持 <tt>\\\\</tt> 和 <tt>\`</tt> 转义序列：
    #
    #   'string with single quote'
    #
    # 双引号字符串支持插值，并支持以下转义序列：
    # * <tt>\\\\</tt> 反斜线
    # * <tt>\"</tt> 双引号
    # * <tt>\a</tt> 告警 alert
    # * <tt>\b</tt> 退格 backspace
    # * <tt>\r</tt> 回车 carriage return
    # * <tt>\n</tt> 换行 newline
    # * <tt>\s</tt> 空格 space
    # * <tt>\t</tt> 制表符 tab
    #
    #   "string with double quote"
    def test_string_literal
      s = 'string'

      assert_instance_of(String, s)
      assert_equal(Object, s.class.superclass)
    end

    ##
    # 备用引号。
    #
    # 当字符串内同时包含单双引号时，可以使用 <tt>%q?...?</tt> 和 <tt>%[Q]?...?</tt> 以避免转义引号。
    def test_alternate_quotes
      _ = %q(string with single quote(') and double quote("))

      text = 'interpolation'
      _ = %(string with single quote('), double quote(") and #{text})
    end

    ##
    # 文档字符串。
    def test_here_documents
      _ = <<-END_OF_STRING_1, <<-END_OF_STRING_2
        This is a string with marked as #1.
      END_OF_STRING_1
        This is a string with marked as #2.
      END_OF_STRING_2
    end
  end
end
