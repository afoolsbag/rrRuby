#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-12 – 2020-08-26
# Unlicense

module RrExeNut3
  module CnDris2013
    ##
    # 某膳食营养素的参考摄入量。
    # Dietary Reference Intake.
    #
    # 可能的数据组合有
    #   1.       EER
    #   2. LAMDR AI(percent) UAMDR
    #   3. EAR   RNI      PI UL
    #   4.       AI(unit) PI UL
    #   5.       SPL      PI UL
    #
    # HACK: 为了令 IDE Hinting 识别，多余地继承自结构体。
    #--
    # rubocop:disable Layout/EmptyLinesAroundArguments, Layout/EndAlignment, Style/StructInheritance
    #++
    class Dri < Struct.new(
      # 平均需要量。
      # Estimated Average Requirement.
      #
      # 群体中各个体营养素需要量的平均值。
      #
      # 特定群体中 50% 个体满足需要的量。
      #
      # @return [Unit, nil]
      :ear,

      # 推荐摄入量。
      # Recommended Nutrient Intake.
      #
      # 可以满足某一特定性别、年龄及生理状况群体中绝大多数个体需要的营养素摄入水平。
      #
      # 特定群体中 97% 个体满足需要的量，自 EAR 推算。
      #
      # @return [Unit, nil]
      :rni,

      # 估计能量需要量。
      # Estimated Energy Requirement.
      #
      # 满足机体总能量消耗所需的能量。即满足基础代谢、身体活动、食物热效应等所消耗的能量，
      # 以及儿童期的生长发育、妊娠期的营养储备、哺乳期泌乳等所需要的能量。
      #
      # 特定群体中 97% 个体满足需要的量，专用于能量。
      #
      # @return [Unit, nil]
      :eer,

      # 适宜摄入量
      # Adequate Intake.
      #
      # 营养素的一个安全摄入水平。是通过观察或实验获得的健康人群某种营养素的摄入量。
      #
      # 当研究资料不足而无法统计出 EAR 时，谨慎替代 RNI。
      #
      # @return [Unit, nil]
      :ai,

      # 可耐受最高摄入量。
      # Tolerable Upper Intake Level.
      #
      # 平均每日可以摄入营养素的最高量。此量对一般人群中的几乎所有个体都不至于造成损害。
      #
      # @return [Unit, nil]
      :ul,

      # 宏量营养素可接受范围下限。
      # Lower Limit of Acceptable Macronutrient Distribution Range.
      #
      # 为预防产能营养素缺乏，同时又降低慢性病风险而提出的每日摄入量的下限。
      #
      # 专用于脂肪、蛋白质和碳水化合物。
      #
      # @return [Unit, nil]
      :lamdr,

      # 宏量营养素可接受范围上限。
      # Upper Limit of Acceptable Macronutrient Distribution Range.
      #
      # 为预防产能营养素缺乏，同时又降低慢性病风险而提出的每日摄入量的上限。
      #
      # 专用于脂肪、蛋白质和碳水化合物。
      #
      # @return [Unit, nil]
      :uamdr,

      # 预防非传染性慢性病的建议摄入量。
      # Proposed Intake for Preventing Non-communicable Chronic Diseases.
      #
      # @return [Unit, nil]
      :pi,

      # 特定建议值。
      # Specific Proposed Level.
      #
      # @return [Unit, nil]
      :spl,

      keyword_init: true
    ) do
      ##
      # 仅当所有字段都为 +nil+ 时返回 +true+。
      # @return [Boolean]
      def empty?
        members.empty? || members.reduce { |memo, member| memo && self[member].nil? }
      end

      ##
      # 是否含有 <tt>EER</tt>。
      # @return [Boolean]
      def contains_eer?
        !eer.nil?
      end

      ##
      # 是否含有 <tt>LAMDR</tt>、<tt>AI</tt>（百分比）、<tt>UAMDR</tt> 中的一项或几项。
      # @return [Boolean]
      def contains_lamdr_aipct_uamdr?
        !lamdr.nil? || ai&.kind == :unitless || !uamdr.nil?
      end

      ##
      # 是否含有 <tt>EAR</tt>、<tt>RNI</tt>、<tt>PI</tt>、<tt>UL</tt> 中的一项或几项。
      # @return [Boolean]
      def contains_ear_rni_pi_ul?
        !ear.nil? || !rni.nil? || !pi.nil? || !ul.nil?
      end

      ##
      # 是否含有 <tt>AI</tt>（单位量）、<tt>PI</tt>、<tt>UL</tt> 中的一项或几项。
      # @return [Boolean]
      def contains_aiunit_pi_ul?
        (!ai.nil? && ai.kind != :unitless) || !pi.nil? || !ul.nil?
      end

      ##
      # 是否含有 <tt>SPL</tt>、<tt>PI</tt>、<tt>UL</tt> 中的一项或几项。
      # @return [Boolean]
      def contains_spl_pi_ul?
        !spl.nil? || !pi.nil? || !ul.nil?
      end

      ##
      # 为某字段生成标签，形如
      #
      #   <AI 1.7 L/d>
      #
      # @param field [Symbol, #to_sym] 字段
      # @param force [Boolean] 即使值为空，也生成标签
      # @return [String, nil]
      def label(field, force: false)
        field = field.to_sym unless field.is_a?(Symbol)

        if self[field]
          "<#{field.to_s.upcase} #{self[field]}>"
        elsif force && members.include?(field)
          "<#{field.to_s.upcase} nil>"
        end
      end
    end; end

    # rubocop:enable Layout/EmptyLinesAroundArguments, Layout/EndAlignment, Style/StructInheritance
  end
end
