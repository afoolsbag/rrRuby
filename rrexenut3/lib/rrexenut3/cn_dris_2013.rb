#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-07 – 2020-08-07
# Unlicense

require 'ruby-units'

require_all 'rrexenut3/cn_dris_2013/*.rb'
require 'rrexenut3/nutrients'

module RrExeNut3
  ##
  # 中国居民膳食营养素参考摄入量（2013版）。
  # Chinese Dietary Reference Intakes 2013.
  class CnDris2013
    ##
    # 初始化。
    #
    # +sex+ 的可选值有：
    #   :male             # 男性
    #   :female           # 女性
    #   :first_trimester  # 孕早期
    #   :second_trimester # 孕中期
    #   :third_trimester  # 孕晚期
    #   :lactation        # 哺乳期
    #
    # +lifestyle+ 的可选值有：
    #   :rest             # 静养，如不能自理的老年人或残疾人
    #   :sedentary        # 久坐，如办公室职员或精密仪器机械师
    #   :handicraft       # 手工，有时需要站立或走动，如实验室助理，司机，学生或装配线工人
    #   :light_labor      # 轻劳作，主要是站立或走动工作，如家庭主妇，销售员，侍应生，机械师或交易员
    #   :heavy_labor      # 重劳作，如建筑工人，农民，林业人员，矿工或运动员
    #
    # +extra_exercise+ 的评判标准：
    # 额外有明显的体育运动量或重体力休闲活动，每周 4 ~ 5 次，每次 30 ~ 60 分钟。
    #
    # @param sex [Symbol] 生理性别、孕期或哺乳期
    # @param age [Float] 实际年龄
    # @param weight [Unit] 体重
    # @param lifestyle [Symbol] 生活方式
    # @param extra_exercise [Boolean] 额外运动
    # @return [void]
    def initialize(sex:, age:, weight:,
                   lifestyle: :sedentary, extra_exercise: false)
      @sex = sex
      @age = age
      @weight = weight
      @lifestyle = lifestyle
      @extra_exercise = extra_exercise
    end

    ##
    # 对今日营养素的摄入、消耗进行总结，生成总结报告。
    #
    # @param nutrients [Nutrients] 摄入营养素，忽略其取样单位。
    # @return [String] 报告。
    def summary_ascii(nutrients) end

    include EnergyDri
    include ProteinDris
    include LipidDris
    include CarbohydrateDris
    include MacroMineralDris
    include TraceMineralDris
    include LipidSolubleVitaminDris
    include WaterSolubleVitaminDris
    include OtherDris
  end
end
