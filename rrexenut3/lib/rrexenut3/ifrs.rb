#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-24 – 2020-09-03
# Unlicense

require 'rrexenut3/ifrs/cn_cdc_fcd_querier'
require 'rrexenut3/ifrs/cn_cdc_fct6_querier'
require 'rrexenut3/ifrs/cn_nhc_lpf_querier'
require 'rrexenut3/ifrs/xx_boohee_querier'
require 'rrexenut3/ifrs/nicknames'
require 'rrexenut3/nutrients'

module RrExeNut3
  ##
  # 国际食品记录。
  # International Food Records.
  module Ifrs
    QueryResult = Struct.new(
      # @return [String]
      :ifri,
      # @return [String]
      :name,
      # @return [Nutrients]
      :nutrients
    )

    ##
    # 查询。
    #
    # @param key [String] 关键字
    # @return [QueryResult, nil] 返回结果或返回空
    def self.query(key)
      # 尝试精确查询
      rv = _query(key)
      return rv if rv

      # 尝试昵称映射表
      rv = _query(NICKNAMES[key]) if NICKNAMES.include?(key)
      return rv if rv

      # 以 471 开头的 13 位数字，推断可能是属于中国台湾的 GTIN 码，尝试之
      rv = _query("CN.NHC.LPF.#{key}") if key =~ /^471\d{10}$/
      return rv if rv

      # 以 489 开头的 13 位数字，推断可能是属于中国香港的 GTIN 码，尝试之
      rv = _query("CN.NHC.LPF.#{key}") if key =~ /^489\d{10}$/
      return rv if rv

      # 以 69 开头的 13 位数字，推断可能是属于中国的 GTIN 码，尝试之
      rv = _query("CN.NHC.LPF.#{key}") if key =~ /^69\d{11}$/
      return rv if rv

      # 以 958 开头的 13 位数字，推断可能是属于中国澳门的 GTIN 码，尝试之
      rv = _query("CN.NHC.LPF.#{key}") if key =~ /^958\d{10}$/
      return rv if rv

      # 纯小写拉丁字母，推断可能属于薄荷网词条，尝试之
      rv = _query("XX.Boohee.#{key}") if key =~ /^[a-z]+$/
      return rv if rv

      nil
    end

    ##
    # 精确查询。
    #
    # 国际食品记录标识符形如：
    #
    #   CN.              # 中国
    #   CN.CDC.          # 中国疾病预防控制中心
    #   CN.CDC.FCT6.     # 中国食物成分表：第六版
    #   CN.CDC.FCD.      # 中国食物营养成分查询平台
    #   CN.NHC.          # 中国国家卫生健康委员会
    #   CN.NHC.LPF.      # 中国预包装食品标签（Label of Prepackaged Food）
    #   OC.              # 大洋洲
    #   UN.              # 联合国
    #   UN.FAO.          # 联合国粮食及农业组织
    #   UN.FAO.EAsia72.  # Food Composition Table for Use in East Asia, 1972.
    #   UN.FAO.NEast82.  # Food Composition Tables for the Near East, 1982.
    #   UN.UNU.          # 联合国大学
    #   UN.WHO.          # 世界卫生组织
    #   US.              # 美国
    #   US.USDA.         # 美国农业部
    #   US.USDA.FDC.     # 美国食物数据中心
    #   XX.Boohee.       # 薄荷网
    #   XX.SnEN3.        # 运动与营养：第 3 版
    #
    # 其中顶级域是 ISO 3166-1 所约定的国家代码；
    # 次级域是下属机构代码；
    # 三级域是出版物代码；
    # 四级和更多级是由出版物内定义的食品记录代码。
    #
    # 用户分配顶级域，如 +XX+ 用以容纳独立出版物。
    #
    # @see http://archive.unu.edu/unupress/unupbooks/80774e/80774E00.htm
    #
    # @param ifri [String] 国际食品记录标识符
    # @return [QueryResult, nil] 返回结果或返回空
    def self._query(ifri)
      HANDLERS.each { |k, v| return v.instance.query(ifri) if ifri.start_with?(k.to_s) }
      nil
    end

    private_class_method :_query
  end
end
