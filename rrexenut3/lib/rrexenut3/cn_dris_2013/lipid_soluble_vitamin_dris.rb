#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-12 – 2020-08-12
# Unlicense

require 'rrexenut3/cn_dris_2013/aux_'
require 'rrexenut3/cn_dris_2013/dri'

module RrExeNut3
  module CnDris2013
    ##
    # 脂溶性维生素的参考摄入量。
    #
    # 溶于有机溶剂而不溶于水的一类维生素，包括维生素 A、维生素 D、维生素 E 及维生素 K。
    # 吸收后与脂蛋白或某些特殊蛋白质结合而运输。
    # 可在体内贮存，排泄缓慢，如果摄入过多，可引起蓄积性中毒。
    module LipidSolubleVitaminDris
      include Aux

      protected

      ##
      # 维生素 A 的参考摄入量。
      # DRI of Vitamin A.
      #
      # 所有具有视黄醇生物活性的化合物，包括维生素 A-1 及维生素 A-2 两种。
      # 参与视觉功能、生殖系统、机体免疫和代谢、骨骼发育、胚胎器官建成等多种生理过程。
      # 安全摄入量范围较小。缺乏可致视觉功能损伤，生殖发育异常等。
      # 过量摄入动物源性的维生素 A 会产生明显毒性反应；孕妇和婴幼儿对维生素 A 过量较为敏感，导致流产或发育异常。
      #
      #   :'VITA-'
      #
      # @return [Dri] 视黄醇活性当量（Retinol Activity Equivalents）
      def vita_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('300ug/d'), ul: un('600ug/d'))
          when 0.5...1
            Dri.new(ai: un('350ug/d'), ul: un('600ug/d'))
          when 1...4
            Dri.new(ear: un('220ug/d'), rni: un('310ug/d'), ul: un('700ug/d'))
          when 4...7
            Dri.new(ear: un('260ug/d'), rni: un('360ug/d'), ul: un('900ug/d'))
          when 7...11
            Dri.new(ear: un('360ug/d'), rni: un('500ug/d'), ul: un('1500ug/d'))
          when 11...14
            male? ? Dri.new(ear: un('480ug/d'), rni: un('670ug/d'), ul: un('2100ug/d')) : Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2100ug/d')) # rubocop:disable Layout/LineLength
          when 14...18
            male? ? Dri.new(ear: un('590ug/d'), rni: un('820ug/d'), ul: un('2700ug/d')) : Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2700ug/d')) # rubocop:disable Layout/LineLength
          else
            male? ? Dri.new(ear: un('560ug/d'), rni: un('800ug/d'), ul: un('3000ug/d')) : Dri.new(ear: un('480ug/d'), rni: un('700ug/d'), ul: un('3000ug/d')) # rubocop:disable Layout/LineLength
          end

        if second_trimester?
          dri.ear += un('50ug/d')
          dri.rni += un('70ug/d')
        elsif third_trimester?
          dri.ear += un('50ug/d')
          dri.rni += un('70ug/d')
        elsif lactation?
          dri.ear += un('400ug/d')
          dri.rni += un('600ug/d')
        end

        dri
      end

      ##
      # 维生素 D 的参考摄入量。
      # DRI of Vitamin D.
      #
      # 一组脂溶性维生素。最具生物活性的形式为胆钙化醇（维生素 D-3）和麦角骨化醇（维生素 D-2）。具有维持钙磷代谢平衡的功能。
      # 维生素 D 缺乏可致佝偻病、骨质软化症和骨质疏松症。
      # 过量会致高钙血症和高钙尿症。
      # 一般植物性食物中维生素 D 含量较低，维生素 D 可通过皮肤暴露阳光或紫外线在体内合成。
      #
      #   :'VITD-'
      #
      # @return [Dri]
      def vitd_dri
        case @age
        when 0...1
          Dri.new(ai: un('10ug/d'), ul: un('20ug/d'))
        when 1...4
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('20ug/d'))
        when 4...7
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('30ug/d'))
        when 7...11
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('45ug/d'))
        when 11...65
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('50ug/d'))
        else
          Dri.new(ear: un('8ug/d'), rni: un('15ug/d'), ul: un('50ug/d'))
        end
      end

      ##
      # 维生素 E 的参考摄入量。
      # DRI of Vitamin E.
      #
      # 一组脂溶性维生素，包括 α-、β-、γ-、δ-生育酚和 α-、β-、γ-、δ-三烯生育酚，均具有抗氧化活性，其中 α-生育酚活性最强。
      # 维生素 E 过量可能的副作用是凝血机制损害，导致某些个体出现出血倾向。
      #
      #   :'VITE-'
      #
      # @return [Dri] α-生育酚当量（Alpha-tocopherol Equivalents）
      def vite_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('3mg/d'))
          when 0.5...1
            Dri.new(ai: un('4mg/d'))
          when 1...4
            Dri.new(ai: un('6mg/d'), ul: un('150mg/d'))
          when 4...7
            Dri.new(ai: un('7mg/d'), ul: un('200mg/d'))
          when 7...11
            Dri.new(ai: un('9mg/d'), ul: un('350mg/d'))
          when 11...14
            Dri.new(ai: un('13mg/d'), ul: un('500mg/d'))
          when 14...18
            Dri.new(ai: un('14mg/d'), ul: un('600mg/d'))
          else
            Dri.new(ai: un('14mg/d'), ul: un('700mg/d'))
          end
        dri.ai += un('3ug/d') if lactation?
        dri
      end

      ##
      # 维生素 K 的参考摄入量。
      # DRI of Vitamin K.
      #
      # 显示抗出血活性的一组化合物，是 2-甲基-1，4-萘醌 及其衍生物的总称。
      # 包括维生素 K-1、维生素 K-2 和维生素 K-3，为形成活性凝血因子 II、凝血因子 VII、凝血因子 XI 和凝血因子 X 所必需。
      # 缺乏维生素 K 时会使凝血时间延长和引起出血病症。
      # 维生素 K 广泛存在于绿叶蔬菜中，肠道细菌亦能合成。膳食中一般不会缺乏，但维生素 K 不能通过胎盘，新生儿又无肠道细菌，有可能出现缺乏。
      #
      #   :VITK
      #
      # @return [Dri]
      def vitk_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('2ug/d'))
          when 0.5...1
            Dri.new(ai: un('10ug/d'))
          when 1...4
            Dri.new(ai: un('30ug/d'))
          when 4...7
            Dri.new(ai: un('40ug/d'))
          when 7...11
            Dri.new(ai: un('50ug/d'))
          when 11...14
            Dri.new(ai: un('70ug/d'))
          when 14...18
            Dri.new(ai: un('75ug/d'))
          else
            Dri.new(ai: un('80ug/d'))
          end
        dri.ai += un('5ug/d') if lactation?
        dri
      end
    end
  end
end
