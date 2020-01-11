#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-01-02
# Unlicense

require 'test/unit'

##
# 分支
#
# {Branches}[https://wikibooks.org/wiki/Ruby_Programming/Syntax/Control_Structures#Conditional_Branches]
#
class TestCaseForBranch < Test::Unit::TestCase

  ##
  # +if-elsif-else-end+ 分支语句
  #
  #   if <条件>
  #     <代码块>
  #   [elsif <条件>
  #     <代码块>]...
  #   [else
  #     <代码块>]
  #   end
  #
  def test_if_elsif_else_end
    score1 = rand(1..6)
    score2 = rand(1..6)
    score3 = rand(1..6)
    total_score = score1 + score2 + score3

    if score1 == score2 && score2 == score3
      puts "#{score1}、#{score2}、#{score3}，围骰！"
    elsif total_score <= 10
      puts "#{score1}、#{score2}、#{score3}，#{total_score}点小！"
    elsif 11 <= total_score
      puts "#{score1}、#{score2}、#{score3}，#{total_score}点大！"
    end
  end

  ##
  # 对于单行代码，建议使用 +if+ 修饰语法
  #
  #   <代码> if <条件>
  #
  def test_if_modifier
    passed = [true, false].sample
    puts '你直面深渊，它将你裹挟而去……'
    puts '你通过了理智检定，悚然惊醒！你挣脱了扭曲，重回理智。' if passed
  end

  ##
  # +unless-else-end+ 分支语句
  #
  #   unless <条件>
  #     <代码块>
  #   [else
  #     <代码块>]
  #   end
  #
  def test_unless_else_end
    hearts = rand(0..30)
    puts "剩余#{hearts}颗心。"
    unless hearts == 0
      puts '游戏仍在进行。'
    end
  end

  ##
  # 对于单行代码，建议使用 +unless+ 修饰语法
  #
  #   <代码> unless <条件>
  #
  def test_unless_modifier
    passed = [true, false].sample
    puts '你掠过一片浮光。'
    puts '浮光中隐射着深渊，你没有通过理智检定，你疯了！' unless passed
  end

  ##
  # +case-when-else-end+ 分支语句
  #
  #   case
  #   when <条件>
  #     <代码块>
  #   [when <条件>
  #     <代码块>]
  #   [else
  #     <代码块>]
  #   end
  #
  # 或者
  #
  #   case <表达式>
  #   when <值>
  #     <代码块>
  #   [when <值>
  #     <代码块>]
  #   [else
  #     <代码块>]
  #   end
  #
  def test_case_when_else_end
    score = rand(0..100)
    puts "摇得 #{score} 分。"
    case score
    when 0..59
      puts "不及格。"
    when 60..79
      puts "及格。"
    when 80..89
      puts "良好。"
    when 90..100
      puts "优秀。"
    else
      puts "？？？"
    end
  end

end
