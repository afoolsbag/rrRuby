#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-31 – 2020-07-31
# Unlicense

require 'rrexenut3/infoods/tagname'

module RrExeNut3
  module Infoods
    ##
    # +.txt+ 文件解析类。
    #
    # 从 +.txt+ 文件中解析标签信息。
    #
    # FIXME: 预设文档符合约定，未进行健壮性测试。
    class TxtParser
      def initialize
        super()
        @cache_tagname = nil
        @current_field = nil
      end

      ##
      # 喂入一行文本。
      #
      # @param line [String]
      # @return [Tagname, nil]
      #--
      # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
      #++
      def feed(line)
        return if line.strip.empty?
        return if @cache_tagname.nil? && !(line =~ /^<\w+-?>/)

        case line
        when /^<(\w+-?)>(.*)/
          # ^<this_is_tagname> this_is_name
          # 新的一项，归一化缓存，输出结果
          tmp = normalize

          @cache_tagname = Tagname.new
          @cache_tagname.tagname = Regexp.last_match(1)

          @cache_tagname.name = Regexp.last_match(2)
          @current_field = :name

          return tmp

        when /^\s+[Uu]nits?:? (.*)/
          # ^ {U|u}nit[s]: this_is_unit
          # 单位字段
          @cache_tagname.unit = Regexp.last_match(1)
          @current_field = :unit

          return nil

        when /^\s+Synonyms: (.*)/
          # ^ Synonyms: this_is_synonyms
          # 别名字段
          @cache_tagname.synonyms = Regexp.last_match(1)
          @current_field = :synonyms

          return nil

        when /^\s+Comments: (.*)/
          # ^ Comments: this_is_comments
          # 注解字段
          @cache_tagname.comments = Regexp.last_match(1)
          @current_field = :comments

          return nil

        when /^\s+Tables: (.*)/
          # ^ Tables: this_is_tables
          # 已知的引用该标签的表，字段
          @cache_tagname.tables = Regexp.last_match(1) # 临时地存储为字符串，在规则化时再分割为数组
          @current_field = :tables

          return nil

        when /^\s+Note: (.*)/
          # ^ Note: this_is_notes
          # 说明字段
          @cache_tagname.notes = Regexp.last_match(1)
          @current_field = :notes

          return nil

        when /^\s+Keywords: (.*)/
          # ^ Keywords: this_is_keywords
          # 关键字字段
          @cache_tagname.keywords = Regexp.last_match(1)
          @current_field = :keywords

          return nil

        when /^\s+Examples: (.*)/
          # ^ Examples: this_is_examples
          # 示例字段
          @cache_tagname.examples = Regexp.last_match(1)
          @current_field = :examples

          return nil

        else
          @cache_tagname[@current_field] += line

          return nil

        end
      end

      # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

      ##
      # 清空缓存。
      #
      # @return [Tagname, nil]
      def flush
        normalize
      end

      private

      ##
      # 归一化缓存，输出结果。
      #
      # @return [Tagname, nil]
      #--
      # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
      #++
      def normalize
        return if @cache_tagname.nil?

        tmp = @cache_tagname
        @cache_tagname = nil

        tmp.name&.gsub!(/\s+/, ' ')&.strip!
        tmp.unit = tmp.unit.split('.').first.strip
        tmp.synonyms = tmp.synonyms.gsub(/\s+/, ' ').strip.split(/\s*[,;]\s/) unless tmp.synonyms.nil?
        tmp.comments&.gsub!(/\s+/, ' ')&.strip!
        tmp.tables = nil
        tmp.notes = nil
        tmp.keywords = nil
        tmp.examples = nil

        tmp
      end

      # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    end
  end
end
