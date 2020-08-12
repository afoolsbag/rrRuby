#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-06 – 2020-08-12
# Unlicense

require 'roo'
require 'roo-xls'

require 'rrexenut3/infoods/tagname'

module RrExeNut3
  module Infoods
    ##
    # +.xls+ 文件解析类。
    #
    # 从 +.xls+ 文件中解析标签信息。
    #
    # FIXME: 预设文档符合约定，未进行健壮性测试。
    class XlsParser
      COLUMN_SYMBOL_NAME_MAPPING = {
        tagname: 'TAGNAME',
        description: 'Description',
        recommended_units: 'Recommended units',
        comment: 'Comment',
        synonyms: 'SYNONYMS'
      }.freeze

      ##
      # 解析一个 +.xls+ 文件。
      #
      # 约定，其表名为 +TAGNAMES+，表列与字段的对应为
      #
      #   TAGNAME           -> :tagname
      #   Short description ->  _
      #   Description       -> :name
      #   Recommended units -> :unit
      #   Comment           -> :comment
      #   SYNONYMS          -> :synonyms
      #
      # @param xls_path [String] +.xls+ 文件路径
      # @param block [Proc<Tagname>] 每当成功解析一项，调用一次
      def self.parse(xls_path, &block)
        xls = Roo::Spreadsheet.open(xls_path, mode: 'rb')
        sheet = xls.sheet('TAGNAMES')
        sheet.each(clean: true, **COLUMN_SYMBOL_NAME_MAPPING) do |hash|
          next if hash[:tagname].nil? || hash[:tagname].empty? || hash[:tagname] == 'TAGNAME'

          tagname = Tagname.new
          tagname.tagname = hash[:tagname].gsub(/s+/, ' ').strip
          tagname.name = hash[:description]&.gsub(/s+/, ' ')&.strip
          tagname.unit = hash[:recommended_units]&.gsub(/s+/, ' ')&.strip
          tagname.synonyms = hash[:synonyms]&.gsub(/s+/, ' ')&.strip&.split(/\s*,\s*/)
          tagname.comments = hash[:comment]&.gsub(/s+/, ' ')&.strip

          block.call(tagname)
        end
      end
    end
  end
end
