#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-07-31
# Unlicense

require 'roo'
require 'roo-xls'

require 'infoods/tag_information'
require 'infoods/txt_parser'

module RrExeNut3
  ##
  # 国际食品数据系统网络（INFOODS）。
  module Infoods
    ##
    # 将信息插入标签集。
    #
    # @param info [TagInformation] 标签信息
    # @param tag_set [Hash{Symbol=>TagInformation}] 标签集
    # @return [void]
    def self.insert_info_to_tag_set(info, tag_set)
      return if info.nil?

      sym = info.tag.to_sym
      raise %(Infoods tag "#{sym}" redefine) if tag_set.key?(sym)

      tag_set[sym] = info
    end

    ##
    # 从 .txt 文件中加载标签信息。
    #
    # @param txt_file [String] 文件路径
    # @param tag_set [Hash{Symbol=>TagInformation}] 标签集
    def self.load_tags_from_txt(txt_file, tag_set)
      parser = TxtParser.new
      File.readlines(txt_file).each do |line|
        info = parser.feed(line)
        insert_info_to_tag_set(info, tag_set)
      end
      info = parser.feed(nil)
      insert_info_to_tag_set(info, tag_set)
    end

    ##
    # 从 .xls 文件中加载标签信息。
    #
    # 其表名为 +TAGNAMES+，表列与字段的对应为：
    #
    #   TAGNAME           -> :tag
    #   Short description -> :briefs[#]
    #   Description       -> :detail
    #   Recommended units -> :unit
    #   Comment           -> :comment
    #   SYNONYMS          -> :briefs[#]
    #
    # @param xls_file [String] 文件路径
    # @param tag_set [Hash{Symbol=>TagInformation}] 标签集
    #
    # FIXME: 预设文档符合约定，未进行健壮性测试。
    def self.load_tags_from_xls(xls_file, tag_set)
      xls = Roo::Spreadsheet.open(xls_file, mode: 'rb')
      sheet = xls.sheet('TAGNAMES')
      sheet.each(clean: true, tagname: 'TAGNAME',
                 short_description: 'Short description',
                 description: 'Description',
                 recommended_units: 'Recommended units',
                 comment: 'Comment',
                 synonyms: 'SYNONYMS') do |hash|
        next if hash[:tagname].nil? || hash[:tagname].empty? || hash[:tagname] == 'TAGNAME'

        info = TagInformation.new
        info.tag = hash[:tagname]
        info.briefs = [hash[:short_description]]
        info.detail = hash[:description]
        info.unit = hash[:recommended_units]
        info.comment = hash[:comment]
        unless hash[:synonyms].nil?
          more_briefs = hash[:synonyms].tr(';', '').split(%r{\s*,\s*})
          info.briefs.concat(more_briefs)
        end

        insert_info_to_tag_set(info, tag_set)
      end
    end

    ##
    # 从各既定数据源中加载标签信息。
    #--
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    #++
    def self.load_tags_from_established_files
      base_dir = File.expand_path('infoods', __dir__)
      tags = {}

      part1_file = File.join(base_dir, 'PART1.TXT')
      load_tags_from_txt(part1_file, tags)

      part2_file = File.join(base_dir, 'PART2.TXT')
      load_tags_from_txt(part2_file, tags)

      part3_file = File.join(base_dir, 'PART3.TXT')
      load_tags_from_txt(part3_file, tags)

      part4_file = File.join(base_dir, 'PART4.TXT')
      load_tags_from_txt(part4_file, tags)

      part5_file = File.join(base_dir, 'PART5.TXT')
      load_tags_from_txt(part5_file, tags)

      addendum2008_file = File.join(base_dir, 'TAGREV__1_without_hyperlink.xls')
      load_tags_from_xls(addendum2008_file, tags)

      addendum2010_file = File.join(base_dir, 'Tagname_new_April_2010-web__2_without_hyperlink.xls')
      load_tags_from_xls(addendum2010_file, tags)

      tags
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end

  unless defined? RrExeNut3::INFOODS_TAGS
    RrExeNut3::INFOODS_TAGS = RrExeNut3.load_infoods_tags_from_established_files
    RrExeNut3::INFOODS_TAGS.freeze
  end
end
