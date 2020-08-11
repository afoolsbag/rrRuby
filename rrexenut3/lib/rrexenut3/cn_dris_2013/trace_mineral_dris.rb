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
    # 痕量矿物质的参考摄入量。
    #
    # 在人体内的含量小于 0.01% 体重的矿物质。分为三类：
    # 第一类为人体必需的微量元素，有铁、碘、锌、硒、铜、钼、铬、钴 8 种；
    # 第二类为人体可能必需的微量元素，有锰、硅、镍、硼、钒 5 种；
    # 第三类为具有潜在毒性，但在低剂量时，对人体可能是有益的微量元素，包括氟、铅、镉、汞、砷、铝、锂、锡 8 种。
    module TraceMineralDris # rubocop:disable Metrics/ModuleLength
      include Aux

      ##
      # 铁的参考摄入量。
      #
      # @return [Dri]
      def iron_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('0.3mg/d'))
          elsif @age < 1
            Dri.new(ear: un('7mg/d'), rni: un('10mg/d'))
          elsif @age < 4
            Dri.new(ear: un('6mg/d'), rni: un('9mg/d'), ul: un('25mg/d'))
          elsif @age < 7
            Dri.new(ear: un('7mg/d'), rni: un('10mg/d'), ul: un('30mg/d'))
          elsif @age < 11
            Dri.new(ear: un('10mg/d'), rni: un('13mg/d'), ul: un('35mg/d'))
          elsif @age < 14 && male?
            Dri.new(ear: un('11mg/d'), rni: un('15mg/d'), ul: un('40mg/d'))
          elsif @age < 14 && female?
            Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d'))
          elsif @age < 18 && male?
            Dri.new(ear: un('12mg/d'), rni: un('16mg/d'), ul: un('40mg/d'))
          elsif @age < 18 && female?
            Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d'))
          elsif @age < 50 && male?
            Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d'))
          elsif @age < 50 && female?
            Dri.new(ear: un('15mg/d'), rni: un('20mg/d'), ul: un('42mg/d'))
          else
            Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d'))
          end

        case @sex
        when :second_trimester
          dri.ear += un('4mg/d')
          dri.rni += un('4mg/d')
        when :third_trimester
          dri.ear += un('7mg/d')
          dri.rni += un('9mg/d')
        when :lactation
          dri.ear += un('3mg/d')
          dri.rni += un('4mg/d')
        end

        dri
      end

      ##
      # 碘的参考摄入量。
      #
      # @return [Dri]
      def iodine_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('85ug/d'))
          elsif @age < 1
            Dri.new(ai: un('115ug/d'))
          elsif @age < 4
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'))
          elsif @age < 7
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('200ug/d'))
          elsif @age < 11
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('300ug/d'))
          elsif @age < 14
            Dri.new(ear: un('75ug/d'), rni: un('110ug/d'), ul: un('400ug/d'))
          elsif @age < 18
            Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('500ug/d'))
          else
            Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('600ug/d'))
          end

        if pregnancy?
          dri.ear += un('75ug/d')
          dri.rni += un('110ug/d')
        end

        if lactation?
          dri.ear += un('85ug/d')
          dri.rni += un('120ug/d')
        end

        dri
      end

      ##
      # 锌的参考摄入量。
      #
      # @return [Dri]
      def zinc_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('2mg/d'))
          elsif @age < 1
            Dri.new(ear: un('2.8mg/d'), rni: un('3.5mg/d'))
          elsif @age < 4
            Dri.new(ear: un('3.2mg/d'), rni: un('4mg/d'), ul: un('8mg/d'))
          elsif @age < 7
            Dri.new(ear: un('4.6mg/d'), rni: un('5.5mg/d'), ul: un('12mg/d'))
          elsif @age < 11
            Dri.new(ear: un('5.9mg/d'), rni: un('7mg/d'), ul: un('19mg/d'))
          elsif @age < 14 && male?
            Dri.new(ear: un('8.2mg/d'), rni: un('10mg/d'), ul: un('28mg/d'))
          elsif @age < 14 && female?
            Dri.new(ear: un('7.6mg/d'), rni: un('9mg/d'), ul: un('28mg/d'))
          elsif @age < 18 && male?
            Dri.new(ear: un('9.7mg/d'), rni: un('11.5mg/d'), ul: un('35mg/d'))
          elsif @age < 18 && female?
            Dri.new(ear: un('6.9mg/d'), rni: un('8.5mg/d'), ul: un('35mg/d'))
          elsif male?
            Dri.new(ear: un('10.4mg/d'), rni: un('12.5mg/d'), ul: un('40mg/d'))
          elsif female?
            Dri.new(ear: un('6.1mg/d'), rni: un('7.5mg/d'), ul: un('40mg/d'))
          end

        if pregnancy?
          dri.ear += un('1.7mg/d')
          dri.rni += un('2mg/d')
        end

        if lactation?
          dri.ear += un('3.8mg/d')
          dri.rni += un('4.5mg/d')
        end

        dri
      end

      ##
      # 硒的参考摄入量。
      #
      # @return [Dri]
      def selenium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('15ug/d'), ul: un('55ug/d'))
          elsif @age < 1
            Dri.new(ai: un('20ug/d'), ul: un('80ug/d'))
          elsif @age < 4
            Dri.new(ear: un('20ug/d'), rni: un('25ug/d'), ul: un('100ug/d'))
          elsif @age < 7
            Dri.new(ear: un('25ug/d'), rni: un('30ug/d'), ul: un('150ug/d'))
          elsif @age < 11
            Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
          elsif @age < 14
            Dri.new(ear: un('45ug/d'), rni: un('55ug/d'), ul: un('300ug/d'))
          elsif @age < 18
            Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('350ug/d'))
          else
            Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('400ug/d'))
          end

        if pregnancy?
          dri.ear += un('4ug/d')
          dri.rni += un('5ug/d')
        end

        if lactation?
          dri.ear += un('15ug/d')
          dri.rni += un('18ug/d')
        end

        dri
      end

      ##
      # 铜的参考摄入量。
      #
      # @return [Dri]
      def copper_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 1
            Dri.new(ai: un('20mg/d'))
          elsif @age < 4
            Dri.new(ear: un('0.25mg/d'), rni: un('0.3mg/d'), ul: un('2mg/d'))
          elsif @age < 7
            Dri.new(ear: un('0.3mg/d'), rni: un('0.4mg/d'), ul: un('3mg/d'))
          elsif @age < 11
            Dri.new(ear: un('0.4mg/d'), rni: un('0.5mg/d'), ul: un('4mg/d'))
          elsif @age < 14
            Dri.new(ear: un('0.55mg/d'), rni: un('0.7mg/d'), ul: un('6mg/d'))
          elsif @age < 18
            Dri.new(ear: un('0.6mg/d'), rni: un('0.8mg/d'), ul: un('7mg/d'))
          else
            Dri.new(ear: un('0.6mg/d'), rni: un('0.8mg/d'), ul: un('8mg/d'))
          end

        if pregnancy?
          dri.ear += un('0.1mg/d')
          dri.rni += un('0.1mg/d')
        end

        if lactation?
          dri.ear += un('0.5mg/d')
          dri.rni += un('0.6mg/d')
        end

        dri
      end

      ##
      # 氟的参考摄入量。
      #
      # @return [Dri]
      def fluorine_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        if @age < 0.5
          Dri.new(ai: un('0.01mg/d'))
        elsif @age < 1
          Dri.new(ai: un('0.23mg/d'))
        elsif @age < 4
          Dri.new(ai: un('0.6mg/d'), ul: un('0.8mg/d'))
        elsif @age < 7
          Dri.new(ai: un('0.7mg/d'), ul: un('1.1mg/d'))
        elsif @age < 11
          Dri.new(ai: un('1mg/d'), ul: un('1.7mg/d'))
        elsif @age < 14
          Dri.new(ai: un('1.3mg/d'), ul: un('2.5mg/d'))
        elsif @age < 18
          Dri.new(ai: un('1.5mg/d'), ul: un('3.1mg/d'))
        else
          Dri.new(ai: un('1.5mg/d'), ul: un('3.5mg/d'))
        end
      end

      ##
      # 铬的参考摄入量。
      #
      # @return [Dri]
      def chromium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('0.2ug/d'))
          elsif @age < 1
            Dri.new(ai: un('4ug/d'))
          elsif @age < 4
            Dri.new(ai: un('15ug/d'))
          elsif @age < 7
            Dri.new(ai: un('20ug/d'))
          elsif @age < 11
            Dri.new(ai: un('25ug/d'))
          elsif @age < 14
            Dri.new(ai: un('30ug/d'))
          elsif @age < 18
            Dri.new(ai: un('35ug/d'))
          else
            Dri.new(ai: un('30ug/d'))
          end

        case @sex
        when :first_trimester
          dri.ai += un('1ug/d')
        when :second_trimester
          dri.ai += un('4ug/d')
        when :third_trimester
          dri.ai += un('6ug/d')
        when :lactation
          dri.ai += un('7ug/d')
        end

        dri
      end

      ##
      # 锰的参考摄入量。
      #
      # @return [Dri]
      def manganese_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('0.01mg/d'))
          elsif @age < 1
            Dri.new(ai: un('0.7mg/d'))
          elsif @age < 4
            Dri.new(ai: un('1.5mg/d'))
          elsif @age < 7
            Dri.new(ai: un('2mg/d'), ul: un('3.5mg/d'))
          elsif @age < 11
            Dri.new(ai: un('3mg/d'), ul: un('5mg/d'))
          elsif @age < 14
            Dri.new(ai: un('4mg/d'), ul: un('8mg/d'))
          elsif @age < 18
            Dri.new(ai: un('4.5mg/d'), ul: un('10mg/d'))
          else
            Dri.new(ai: un('4.5mg/d'), ul: un('11mg/d'))
          end
        dri.ai += un('0.4mg/d') if pregnancy?
        dri.ai += un('0.3mg/d') if lactation?
        dri
      end

      ##
      # 钼的参考摄入量。
      #
      # @return [Dri]
      def molybdenum_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('2ug/d'))
          elsif @age < 1
            Dri.new(ai: un('15ug/d'))
          elsif @age < 4
            Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
          elsif @age < 7
            Dri.new(ear: un('40ug/d'), rni: un('50ug/d'), ul: un('300ug/d'))
          elsif @age < 11
            Dri.new(ear: un('55ug/d'), rni: un('65ug/d'), ul: un('450ug/d'))
          elsif @age < 14
            Dri.new(ear: un('75ug/d'), rni: un('90ug/d'), ul: un('650ug/d'))
          elsif @age < 18
            Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('800ug/d'))
          else
            Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('900ug/d'))
          end

        if pregnancy?
          dri.ear += un('7ug/d')
          dri.rni += un('10ug/d')
        end

        if lactation?
          dri.ear += un('3ug/d')
          dri.rni += un('3ug/d')
        end

        dri
      end
    end
  end
end
