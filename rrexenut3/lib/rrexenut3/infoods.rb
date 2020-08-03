#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-07-31
# Unlicense

require 'roo'
require 'roo-xls'

require 'rrexenut3/infoods/tagname'
require 'rrexenut3/infoods/txt_parser'

module RrExeNut3
  ##
  # 国际食品数据系统网络（INFOODS）。
  module Infoods
    ##
    # 将信息插入标签集。
    #
    # @param tagname [Tagname, nil] 标签
    # @param tagnames [Hash{Symbol=>Tagname}] 标签集
    # @return [void]
    def self.insert_tagname_to_tagnames(tagname, tagnames)
      return if tagname.nil?

      sym = tagname.tagname.to_sym
      # raise %(Infoods tagname "#{sym}" re-defined) if tagnames.key?(sym)

      tagnames[sym] = tagname
    end

    ##
    # 从 .txt 文件中加载标签。
    #
    # @param txt_path [String] <tt>.txt</tt> 文件路径
    # @param tagnames [Hash{Symbol=>TagInformation}] 标签集
    def self.load_tagnames_from_txt(txt_path, tagnames)
      parser = TxtParser.new
      File.readlines(txt_path).each do |line|
        tagname = parser.feed(line)
        insert_tagname_to_tagnames(tagname, tagnames)
      end
      tagname = parser.flush
      insert_tagname_to_tagnames(tagname, tagnames)
    end

    ##
    # 从 .xls 文件中加载标签。
    #
    # 其表名为 +TAGNAMES+，表列与字段的对应为：
    #
    #   TAGNAME           -> :tagname
    #   Short description ->  _
    #   Description       -> :name
    #   Recommended units -> :unit
    #   Comment           -> :comment
    #   SYNONYMS          -> :synonyms
    #
    # @param xls_path [String] <tt>.xls</tt> 文件路径
    # @param tagnames [Hash{Symbol=>TagInformation}] 标签集
    #
    # FIXME: 预设文档符合约定，未进行健壮性测试。
    #--
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    #++
    def self.load_tagnames_from_xls(xls_path, tagnames)
      xls = Roo::Spreadsheet.open(xls_path, mode: 'rb')
      sheet = xls.sheet('TAGNAMES')
      sheet.each(clean: true,
                 tagname: 'TAGNAME',
                 description: 'Description',
                 recommended_units: 'Recommended units',
                 comment: 'Comment',
                 synonyms: 'SYNONYMS') do |hash|
        next if hash[:tagname].nil? || hash[:tagname].empty? || hash[:tagname] == 'TAGNAME'

        tagname = Tagname.new
        tagname.tagname = hash[:tagname]&.gsub(/s+/, ' ')&.strip
        tagname.name = hash[:description]&.gsub(/s+/, ' ')&.strip
        tagname.unit = hash[:recommended_units]&.gsub(/s+/, ' ')&.strip
        tagname.synonyms = hash[:synonyms].gsub(/s+/, ' ').strip.split(/\s*,\s*/) unless hash[:synonyms].nil?
        tagname.comments = hash[:comment]&.gsub(/s+/, ' ')&.strip

        insert_tagname_to_tagnames(tagname, tagnames)
      end
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    ##
    # 从各既定数据源中加载标签信息。
    #
    # @return [Hash{Symbol=>TagInformation}] 标签集
    #--
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    #++
    def self.load_tagnames_from_established_files
      base_dir = File.expand_path('infoods', __dir__)
      tagnames = {}

      part1_file = File.join(base_dir, 'PART1.TXT')
      load_tagnames_from_txt(part1_file, tagnames)

      part2_file = File.join(base_dir, 'PART2.TXT')
      load_tagnames_from_txt(part2_file, tagnames)

      part3_file = File.join(base_dir, 'PART3.TXT')
      load_tagnames_from_txt(part3_file, tagnames)

      part4_file = File.join(base_dir, 'PART4.TXT')
      load_tagnames_from_txt(part4_file, tagnames)

      part5_file = File.join(base_dir, 'PART5.TXT')
      load_tagnames_from_txt(part5_file, tagnames)

      addendum2008_file = File.join(base_dir, 'TAGREV__1.xls')
      load_tagnames_from_xls(addendum2008_file, tagnames)

      addendum2010_file = File.join(base_dir, 'Tagname_new_April_2010-web__2.xls')
      load_tagnames_from_xls(addendum2010_file, tagnames)

      tagnames
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    unless defined? RrExeNut3::Infoods::TAGNAMES
      RrExeNut3::Infoods::TAGNAMES = RrExeNut3::Infoods.load_tagnames_from_established_files
      RrExeNut3::Infoods::TAGNAMES.freeze
    end
  end
end
