#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-31 – 2020-07-31
# Unlicense

require 'tag_information'

module RrExeNut3
  module Infoods
    ##
    # +.txt+ 文件解析类。
    #
    # 从 +.txt+ 文件中解析标签信息。
    #
    # FIXME: 预设文档符合约定，未进行健壮性测试。
    class TxtParser
      ##
      # 喂入一行文本。
      # 参数为 +nil+ 表示文件读完。
      #
      # @param line [String, nil]
      # @return [TagInformation, nil]
      def feed(line)
        return normalize if line.nil?

        return if line.strip.empty?

        case line
        when /^<(\w+-?)>(.*)/ # ^<TAGNAME> BRIEFS[0]
          tmp = normalize
          unless cur_info.nil?
          end

          cur_info = TagInformation.new
          cur_info.tag = $1

          cur_info.briefs = [$2]
          cur_field = :briefs

        when /^\s+Unit: (.*)/ # ^ Unit: UNIT

        else
          cur_info[cur_field]

        end

        current_info ||=
          if info.nil?
            info =

          else

          end

        info.tag = hash[:tagname]
        info.briefs = [hash[:short_description]]
        info.detail = hash[:description]
        info.unit = hash[:recommended_units]
        info.comment = hash[:comment]

        unless hash[:synonyms].nil?
          more_briefs = hash[:synonyms].tr(';', '').split(%r{\s*,\s*})
          info.briefs.concat(more_briefs)
        end

        tag_set[info.tag.to_sym] = info
      end

      ##
      # 归一化数据，输出结果。
      #
      # @return [TagInformation, nil]
      def normalize
      end
    end
  end
end
