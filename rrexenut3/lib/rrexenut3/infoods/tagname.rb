#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-08-03
# Unlicense

module RrExeNut3
  module Infoods
    ##
    # 标签类。
    #
    # @!attribute [rw] tagname
    #   @return [String] 标签名
    # @!attribute [rw] name
    #   @return [String] 名称
    # @!attribute [rw] unit
    #   @return [String] 单位
    # @!attribute [rw] synonyms
    #   @return [Array<String>] 别名
    # @!attribute [rw] comments
    #   @return [String] 注解
    # @!attribute [rw] tables
    #   @return [Array<String>] 已知的引用该标签的表
    # @!attribute [rw] notes
    #   @return [String] 说明
    # @!attribute [rw] keywords
    #   @return [String] 关键字
    # @!attribute [rw] examples
    #   @return [String] 示例
    #
    # @see http://archive.unu.edu/unupress/unupbooks/80734e/80734E01.htm
    Tagname = Struct.new(
      :tagname,
      :name,
      :unit,
      :synonyms,
      :comments,
      :tables,
      :notes,
      :keywords,
      :examples
    )
  end
end
