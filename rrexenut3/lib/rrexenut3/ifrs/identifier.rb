#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-24 – 2020-08-24
# Unlicense

module RrExeNut3
  module Ifrs
    # 标识符。
    #
    # 形如：
    #
    #   CN.              # 中国
    #   CN.CDC.          # 中国疾病预防控制中心
    #   CN.CDC.CNFCT6.   # 中国食物成分表：第六版
    #   OC.              # 大洋洲
    #   UN.              # 联合国
    #   UN.FAO.          # 联合国粮食及农业组织
    #   UN.FAO.EAsia72.  # Food Composition Table for Use in East Asia, 1972.
    #   UN.FAO.NEast82.  # Food Composition Tables for the Near East, 1982.
    #   UN.UNU.          # 联合国大学
    #   UN.WHO.          # 世界卫生组织
    #   US.              # 美国
    #   US.USDA.         # 美国农业部
    #   US.USDA.USFDC.   # 美国食物数据中心
    #   XX.S&EN3.        # 运动与营养：第 3 版
    #
    # 其中顶级域是 ISO 3166-1 所约定的国家代码；
    # 次级域是下属机构代码；
    # 三级域是出版物代码；
    # 四级和更多级是由出版物内定义的食品记录代码。
    #
    # 保留顶级域 +XX+ 用以容纳独立出版物。
    #
    # @see http://archive.unu.edu/unupress/unupbooks/80774e/80774E00.htm
    class Identifier
      attr_reader :country,
                  :organization,
                  :publication,
                  :code

      # @param string [String]
      def initialize(string)
        if string[1..3] == 'XX.'
          @country, @publication, *@code = string.split('.')
        else
          @country, @organization, @publication, *@code = string.split('.')
        end
      end

      # @return [Boolean]
      def as_country?
        @country && @organization.nil? && @publication.nil? && @code.nil?
      end

      # @return [Identifier]
      def try_strip_as_country
        Identifier.new(@country, nil, nil, nil)
      end

      # @return [Boolean]
      def as_organization?
        @country && @organization && @publication.nil? && @code.nil?
      end

      # @return [Identifier]
      def try_strip_as_organization
        Identifier.new(@country, @organization, nil, nil)
      end

      # @return [Boolean]
      def as_publication?
        if @country == 'XX'
          @country && @organization.nil? && @publication && @code.nil?
        else
          @country && @organization && @publication && @code.nil?
        end
      end

      # @return [Identifier]
      def try_strip_as_publication
        Identifier.new(@country, @organization, @publication, nil)
      end

      # @return [Integer]
      def hash
        to_sym.hash
      end

      # @return [String]
      def to_s
        "#{@country}.#{@organization}.#{@publication}.#{@code}"
      end

      # @return [Symbol]
      def to_sym
        to_s.to_sym
      end
    end
  end
end
