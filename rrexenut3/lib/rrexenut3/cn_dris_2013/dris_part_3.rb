#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-12 – 2020-08-13
# Unlicense

require 'rrexenut3/cn_dris_2013/aux_'
require 'rrexenut3/cn_dris_2013/dri'

module RrExeNut3
  module CnDris2013
    ##
    # 参考摄入量第三部分：脂质。
    # DRIs Part 3: Lipids.
    module DrisPart3
      include Aux

      ##
      # 总脂质的参考摄入量。
      # DRI of Fat.
      #
      #   :FAT
      #
      # @return [Dri]
      def fat_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('48%'))
        when 0.5...1
          Dri.new(ai: un('40%'))
        when 1...4
          Dri.new(ai: un('35%'))
        else
          Dri.new(lamdr: un('20%'), uamdr: un('30%'))
        end
      end

      ##
      # 饱和脂肪酸的参考摄入量。
      # DRI of Saturated Fatty Acid.
      #
      # 碳链上不含双键的脂肪酸。如软脂酸、硬脂酸。
      #
      #   :FASAT
      #
      # @return [Dri]
      def sfa_dri
        case @age.scalar
        when 0...4
          Dri.new
        when 4...18
          Dri.new(uamdr: un('8%'))
        else
          Dri.new(uamdr: un('10%'))
        end
      end

      ##
      # 单不饱和脂肪酸的参考摄入量。
      # DRI of Mono-unsaturated Fatty Acids.
      #
      # 碳链上含有一个双键的脂肪酸。如油酸、棕榈油酸。
      #
      #   :FAMS
      #
      # @return [Dri]
      def mufa_dri; end

      ##
      # ω-6 多不饱和脂肪酸的参考摄入量。
      # DRI of n-6 Poly-unsaturated Fatty Acid.
      #
      # 第一个双键位于从甲基端开始的第 6，7 位碳原子之间的多不饱和脂肪酸，
      # 包括亚油酸和花生四烯酸。
      #
      #   :FAPUN6
      #
      # @return [Dri]
      def n6pufa_dri
        case @age.scalar
        when 0...18
          Dri.new
        else
          Dri.new(lamdr: un('2.5%'), uamdr: un('9.0%'))
        end
      end

      ##
      # 亚油酸的参考摄入量。
      # DRI of Linoleic Acid.
      #
      #   :F18D2CN6
      #
      # @return [Dri]
      def la_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('7.3%'))
        when 0.5...1
          Dri.new(ai: un('6.0%'))
        else
          Dri.new(ai: un('4.0%'))
        end
      end

      ##
      # 花生四希酸的参考摄入量。
      # DRI of Arachidonic acid.
      #
      #   :F20D4
      #
      # @return [Dri]
      def ara_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('150mg/d'))
        else
          Dri.new
        end
      end

      ##
      # ω-3 多不饱和脂肪酸的参考摄入量。
      # DRI of n-3 Poly-unsaturated Fatty Acid.
      #
      # 第一个双键位于从甲基端开始的第 3，4 位碳之间的多不饱和脂肪酸，
      # 包括 α-亚麻酸、二十碳五烯酸（EPA）、二十二碳五烯酸（DPA）和二十二碳六烯酸（DHA）。
      #
      #   :FAPUN3
      #
      # @return [Dri]
      def n3pufa_dri
        case @age.scalar
        when 0...18
          Dri.new
        else
          Dri.new(lamdr: un('0.5%'), uamdr: un('2.0%'))
        end
      end

      ##
      # α-亚麻酸的参考摄入量。
      # DRI of Alpha-Linolneic Acid.
      #
      #   :F18D3N3
      #
      # @return [Dri]
      def alac_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('0.87%'))
        when 0.5...1
          Dri.new(ai: un('0.66%'))
        else
          Dri.new(ai: un('0.60%'))
        end
      end

      ##
      # 二十碳五烯酸的参考摄入量。
      # DRI of Eicosa-pentaenoic Acid.
      #
      #   :F20D5N3
      #
      # @return [Dri]
      def epa_dri
        if pregnancy_or_lactation?
          Dri.new(ai: un('50mg/d'))
        else
          Dri.new
        end
      end

      ##
      # 二十二碳六烯酸的参考摄入量。
      # DRI of Docosa-hexaenoic Acid.
      #
      #   :F22D6N3
      #
      # @return [Dri]
      def dha_dri
        if pregnancy_or_lactation?
          Dri.new(ai: un('200mg/d'))
        elsif @age.scalar.between?(0, 4)
          Dri.new(ai: un('100mg/d'))
        else
          Dri.new
        end
      end

      ##
      # 反式脂肪酸的参考摄入量。
      # DRI of Trans Fatty Acids.
      #
      #   :FATRN
      #
      # @return [Dri]
      def tfa_dri; end
    end
  end
end
