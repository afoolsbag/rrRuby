#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-08-06
# Unlicense

require 'rrexenut3/infoods/tagname'
require 'rrexenut3/infoods/txt_parser'
require 'rrexenut3/infoods/xls_parser'

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
    # @param tagnames [Hash{Symbol=>TagName}] 标签集
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
    # @param xls_path [String] <tt>.xls</tt> 文件路径
    # @param tagnames [Hash{Symbol=>TagName}] 标签集
    def self.load_tagnames_from_xls(xls_path, tagnames)
      XlsParser.parse(xls_path) do |tagname|
        insert_tagname_to_tagnames(tagname, tagnames)
      end
    end

    # 既定数据源目录
    ESTABLISHED_DATA_SOURCE_DIR = File.expand_path('infoods', __dir__)

    ##
    # 从各既定数据源中加载标签信息。
    #
    # @return [Hash{Symbol=>Tagname}] 标签集
    def self.load_tagnames_established
      tagnames = {}
      Dir.glob(File.expand_path('*.txt', ESTABLISHED_DATA_SOURCE_DIR)) do |txt_path|
        load_tagnames_from_txt(txt_path, tagnames)
      end
      Dir.glob(File.expand_path('*.xls', ESTABLISHED_DATA_SOURCE_DIR)) do |xls_path|
        load_tagnames_from_xls(xls_path, tagnames)
      end
      tagnames
    end

    # @return [Hash<Symbol=>RrExeNut3::Infoods::Tagname]
    TAGNAMES = RrExeNut3::Infoods.load_tagnames_established.freeze
  end
end
