#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-08-13
# Unlicense

module RrExeNut3
  module Infoods
    ##
    # 标签结构体。
    #
    # @see http://archive.unu.edu/unupress/unupbooks/80734e/80734E01.htm
    #
    # HACK: 为了令 IDE Hinting 识别，多余地继承自结构体。
    #--
    # rubocop:disable Layout/EmptyLinesAroundArguments, Style/StructInheritance
    #++
    class Tagname < Struct.new(
      # 标签名。
      #
      # @return [String]
      :tagname,

      # 名称。
      #
      # @return [String]
      :name,

      # 单位。
      #
      # @return [String]
      :unit,

      # 别名。
      #
      # @return [Array<String>, nil]
      :synonyms,

      # 注解。
      #
      # @return [String, nil]
      :comments,

      # 已知的引用该标签的表
      #
      # @return [Array<String>, nil]
      :tables,

      # 说明
      #
      # @return [String, nil]
      :notes,

      # 关键字
      #
      # @return [String, nil]
      :keywords,

      # 示例
      #
      # @return [String, nil]
      :examples,

      keyword_init: true
    ); end

    # rubocop:enable Layout/EmptyLinesAroundArguments, Style/StructInheritance
  end
end
