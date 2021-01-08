#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 控制表达式：分支。
#
# 参见 {Control Expressions}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html]。
#
# zhengrr
# 2019-12-31 – 2021-01-08
# Unlicense

require 'minitest/autorun'

##
# 分支的测试，
class BranchesTest < Minitest::Test
  ##
  # 如果（ +if+ ）表达式。
  #
  #   if <条件> [then]
  #     <代码块>
  #   [elsif <条件> [then]
  #     <代码块>]...
  #   [else
  #     <代码块>]
  #   end
  #
  # 参见 {if Expression}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-if+Expression]。
  def test_that_if_expression
    condition = [true, false].sample

    x = if condition
          'true'
        else
          'false'
        end

    assert_equal(condition.to_s, x)
  end

  ##
  # 三元如果（ +if+ ）表达式。
  #
  #   <条件> ? <为真时的表达式> : <为假时的表达式>
  #
  # 参见 {Ternary if}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Ternary+if]。
  def test_that_ternary_if
    condition = [true, false].sample

    x = condition ? 'true' : 'false'

    assert_equal(condition.to_s, x)
  end

  ##
  # 除非（ +unless+ ）表达式。
  #
  #   unless <条件> [then]
  #     <代码块>
  #   [else
  #     <代码块>]
  #   end
  #
  # 参见 {unless Expression}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-unless+Expression]。
  def test_that_unless_expression
    condition = [true, false].sample

    # rubocop:disable Style/UnlessElse
    x = unless condition
          'false'
        else
          'true'
        end
    # rubocop:enable Style/UnlessElse

    assert_equal(condition.to_s, x)
  end

  ##
  # 修饰符如果（ +if+ ）和除非（ +unless+ ）。
  #
  #   <为真时的代码> if <条件>
  #
  #   <为假时的代码> unless <条件>
  #
  # 参见 {Modifier if and unless}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Modifier+if+and+unless]。
  def test_that_modifier_if_and_unless
    condition = [true, false].sample

    x = nil
    x = 'true' if condition
    x = 'false' unless condition

    assert_equal(condition.to_s, x)
  end

  ##
  # 情形（ +case+ ）表达式。
  #
  #   case <表达式>
  #   when <值>,... [then]
  #     <代码块>
  #   [when <值>,... [then]
  #     <代码块>]...
  #   [else
  #     <代码块>]
  #   end
  #
  # 或
  #
  #   case
  #   when <条件>,... [then]
  #     <代码块>
  #   [when <条件>,... [then]
  #     <代码块>]...
  #   [else
  #     <代码块>]
  #   end
  #
  # 参见 {case Expression}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-case+Expression]。
  def test_that_case_expression
    condition = [true, false].sample

    # rubocop:disable Style/EmptyElse
    x = case condition
        when true
          'true'
        when false
          'false'
        else
          nil
        end
    # rubocop:enable Style/EmptyElse

    assert_equal(condition.to_s, x)
  end

end
