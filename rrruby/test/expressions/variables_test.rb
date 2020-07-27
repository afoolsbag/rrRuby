#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-27 – 2020-07-27
# Unlicense

require 'test/unit'

module Expressions
  ##
  # 变量。
  #
  # 参见 {Ruby 内核参考：Assignment}[https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html]。
  class VariablesTest < Test::Unit::TestCase
    ##
    # 赋值。
    def test_variable
      ref1 = 0
      ref2 = ref1
      assert_equal(ref1.object_id, ref2.object_id)
    end

    ##
    # 多重赋值。
    #
    # 参见 {Ruby 内核参考：Assignment：Multiple Assignment
    # }[https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Multiple+Assignment]。
    def test_multiple_assignment
      var1 = 'lu'
      var2 = 'zoo'
      var1, var2 = var2, var1
      assert_equal('zoo', var1)
      assert_equal('lu', var2)
    end
  end
end
