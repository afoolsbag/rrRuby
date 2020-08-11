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

      ##
      # 维生素 A 的参考摄入量。
      #
      # @return [Dri]
      def vitamin_a_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('300ug/d'), ul: un('600ug/d'))
          elsif @age < 1
            Dri.new(ai: un('350ug/d'), ul: un('600ug/d'))
          elsif @age < 4
            Dri.new(ear: un('220ug/d'), rni: un('310ug/d'), ul: un('700ug/d'))
          elsif @age < 7
            Dri.new(ear: un('260ug/d'), rni: un('360ug/d'), ul: un('900ug/d'))
          elsif @age < 11
            Dri.new(ear: un('360ug/d'), rni: un('500ug/d'), ul: un('1500ug/d'))
          elsif @age < 14 && male?
            Dri.new(ear: un('480ug/d'), rni: un('670ug/d'), ul: un('2100ug/d'))
          elsif @age < 14 && female?
            Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2100ug/d'))
          elsif @age < 18 && male?
            Dri.new(ear: un('590ug/d'), rni: un('820ug/d'), ul: un('2700ug/d'))
          elsif @age < 18 && female?
            Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2700ug/d'))
          elsif male?
            Dri.new(ear: un('560ug/d'), rni: un('800ug/d'), ul: un('3000ug/d'))
          elsif female?
            Dri.new(ear: un('480ug/d'), rni: un('700ug/d'), ul: un('3000ug/d'))
          end

        case @sex
        when :second_trimester
          dri.ear += un('50ug/d')
          dri.rni += un('70ug/d')
        when :third_trimester
          dri.ear += un('50ug/d')
          dri.rni += un('70ug/d')
        when :lactation
          dri.ear += un('400ug/d')
          dri.rni += un('600ug/d')
        end

        dri
      end

      ##
      # 维生素 D 的参考摄入量。
      #
      # @return [Dri]
      def vitamin_d_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        if @age < 1
          Dri.new(ai: un('10ug/d'), ul: un('20ug/d'))
        elsif @age < 4
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('20ug/d'))
        elsif @age < 7
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('30ug/d'))
        elsif @age < 11
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('45ug/d'))
        elsif @age < 65
          Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('50ug/d'))
        else
          Dri.new(ear: un('8ug/d'), rni: un('15ug/d'), ul: un('50ug/d'))
        end
      end

      ##
      # 维生素 E 的参考摄入量。
      #
      # @return [Dri]
      def vitamin_e_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('3mg/d'))
          elsif @age < 1
            Dri.new(ai: un('4mg/d'))
          elsif @age < 4
            Dri.new(ai: un('6mg/d'), ul: un('150mg/d'))
          elsif @age < 7
            Dri.new(ai: un('7mg/d'), ul: un('200mg/d'))
          elsif @age < 11
            Dri.new(ai: un('9mg/d'), ul: un('350mg/d'))
          elsif @age < 14
            Dri.new(ai: un('13mg/d'), ul: un('500mg/d'))
          elsif @age < 18
            Dri.new(ai: un('14mg/d'), ul: un('600mg/d'))
          else
            Dri.new(ai: un('14mg/d'), ul: un('700mg/d'))
          end
        dri.ai += un('3ug/d') if lactation?
        dri
      end

      ##
      # 维生素 K 的参考摄入量。
      #
      # @return [Dri]
      def vitamin_k_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('2ug/d'))
          elsif @age < 1
            Dri.new(ai: un('10ug/d'))
          elsif @age < 4
            Dri.new(ai: un('30ug/d'))
          elsif @age < 7
            Dri.new(ai: un('40ug/d'))
          elsif @age < 11
            Dri.new(ai: un('50ug/d'))
          elsif @age < 14
            Dri.new(ai: un('70ug/d'))
          elsif @age < 18
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
