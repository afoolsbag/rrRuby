#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-24 – 2020-08-27
# Unlicense

require 'rrexenut3/ifrs/cn_cdc_fct6_querier'
require 'rrexenut3/ifrs/cn_nhc_lpf_querier'
require 'rrexenut3/nutrients'

module RrExeNut3
  ##
  # 国际食品记录。
  # International Food Records.
  module Ifrs
    IFRI_HANDLER = {
      'CN.CDC.FCT6.': Ifrs::CnCdcFct6Querier,
      'CN.NHC.LPF.': Ifrs::CnNhcLpfQuerier
    }.freeze

    ##
    # 查询。
    #
    # 国际食品记录标识符形如：
    #
    #   CN.              # 中国
    #   CN.CDC.          # 中国疾病预防控制中心
    #   CN.CDC.FCT6.     # 中国食物成分表：第六版
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
    # @return [Array<String, Nutrients>, nil] 返回"名称、营养素对"，或返回空
    def self.query(ifri)
      IFRI_HANDLER.each { |k, v| return v.instance.query(ifri) if ifri.start_with?(k.to_s) }
      nil
    end
  end
end
