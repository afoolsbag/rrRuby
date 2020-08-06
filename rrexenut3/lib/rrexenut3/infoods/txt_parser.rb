#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-31 – 2020-08-06
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
    #--
    # rubocop:disable Metrics/ClassLength
    #++
    class TxtParser
      ##
      # 初始化。
      def initialize
        super()
        @cache = nil
        @field = nil
      end

      ##
      # 喂入一行文本。
      #
      # @param line [String] 一行文本
      # @return [Tagname, nil]
      #--
      # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
      #++
      def feed(line)
        # 略过空行
        return if line.strip.empty?

        case line
        when /^<(\w+-?)>(.*)$/
          parse_new_tag_line(Regexp.last_match(1).to_s, Regexp.last_match(2).to_s)
        when /^\s+[Uu]nits?:? (.*)$/
          parse_unit_field_line(Regexp.last_match(1).to_s)
        when /^\s+Synonyms: (.*)$/
          parse_synonyms_field_line(Regexp.last_match(1).to_s)
        when /^\s+Comments: (.*)$/
          parse_comments_field_line(Regexp.last_match(1).to_s)
        when /^\s+Tables: (.*)$/
          parse_tables_field_line(Regexp.last_match(1).to_s)
        when /^\s+Note: (.*)$/
          parse_notes_field_line(Regexp.last_match(1).to_s)
        when /^\s+Keywords: (.*)$/
          parse_keywords_field_line(Regexp.last_match(1).to_s)
        when /^\s+Examples: (.*)$/
          parse_examples_field_line(Regexp.last_match(1).to_s)
        else
          parse_other_line(line)
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
      # 解析新标签行。
      #
      #   ^<TAGNAME[-]>part_of_name$
      #
      # @param tagname [String] 标签名
      # @param part_of_name [String] 名称的一部分
      # @return [Tagname, nil]
      def parse_new_tag_line(tagname, part_of_name)
        rv = normalize
        @cache = Tagname.new
        @cache.tagname = tagname
        @cache.name = part_of_name
        @field = :name
        rv
      end

      ##
      # 解析单位字段行。
      #
      #   ^ [Uu]nit[s][:] part_of_unit$
      #
      # @param part_of_unit [String] 单位的一部分
      # @return [nil]
      def parse_unit_field_line(part_of_unit)
        return if @cache.nil?

        @cache.unit = part_of_unit
        @field = :unit
        nil
      end

      ##
      # 解析别名字段行。
      #
      #   ^ Synonyms: part_of_synonyms$
      #
      # @param part_of_synonyms [String] 别名的一部分
      # @return [nil]
      def parse_synonyms_field_line(part_of_synonyms)
        return if @cache.nil?

        @cache.synonyms = part_of_synonyms
        @field = :synonyms
        nil
      end

      ##
      # 解析注解字段行。
      #
      #   ^ Comments: part_of_comments$
      #
      # @param part_of_comments [String] 别名的一部分
      # @return [nil]
      def parse_comments_field_line(part_of_comments)
        return if @cache.nil?

        @cache.comments = part_of_comments
        @field = :comments
        nil
      end

      ##
      # 解析已知表字段行。
      #
      #   ^ Tables: part_of_tables$
      #
      # @param part_of_tables [String] 已知表的一部分
      # @return [nil]
      def parse_tables_field_line(part_of_tables)
        return if @cache.nil?

        @cache.tables = part_of_tables
        @field = :tables
        nil
      end

      ##
      # 解析说明字段行。
      #
      #   ^ Note: part_of_notes$
      #
      # @param part_of_notes [String] 说明的一部分
      # @return [nil]
      def parse_notes_field_line(part_of_notes)
        return if @cache.nil?

        @cache.notes = part_of_notes
        @field = :notes
        nil
      end

      ##
      # 解析关键字字段行。
      #
      #   ^ Keywords: part_of_keywords$
      #
      # @param part_of_keywords [String] 已知表的一部分
      # @return [nil]
      def parse_keywords_field_line(part_of_keywords)
        return if @cache.nil?

        @cache.keywords = part_of_keywords
        @field = :keywords
        nil
      end

      ##
      # 解析已知表字段行。
      #
      #   ^ Examples: part_of_examples$
      #
      # @param part_of_examples [String] 已知表的一部分
      # @return [nil]
      def parse_examples_field_line(part_of_examples)
        return if @cache.nil?

        @cache.examples = part_of_examples
        @field = :examples
        nil
      end

      ##
      # 解析其它行。
      #
      # @param line [String] 一行文本
      # @return [nil]
      def parse_other_line(line)
        return if @cache.nil?

        @cache[@field] += line
        nil
      end

      ##
      # 归一化缓存，输出结果。
      #
      # @return [Tagname, nil]
      #--
      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      #++
      def normalize
        return if @cache.nil?

        rv = @cache
        @cache = nil

        # 移除名称的多余空白
        rv.name = rv.name.gsub(/\s+/, ' ').strip
        # 移除单位后随的说明
        rv.unit = rv.unit.split('.').first.strip
        # 移除别名的多余空白，并按 , 和 ; 分割
        rv.synonyms = rv.synonyms.gsub(/\s+/, ' ').strip.split(/\s*[,;]\s*/) unless rv.synonyms.nil?
        # 移除注解的多余空白
        rv.comments = rv.comments.gsub(/\s+/, ' ').strip unless rv.comments.nil?
        # 暂不解析该项
        rv.tables = nil
        # 暂不解析该项
        rv.notes = nil
        # 暂不解析该项
        rv.keywords = nil
        # 暂不解析该项
        rv.examples = nil

        rv
      end

      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
    end

    # rubocop:enable Metrics/ClassLength
  end
end
