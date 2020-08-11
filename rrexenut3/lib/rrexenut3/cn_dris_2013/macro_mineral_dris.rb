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
    # 宏量矿物质的参考摄入量。
    #
    # 在人体内的含量大于 0.01% 体重的矿物质。
    # 包括钾、钠、钙、镁、硫、磷、氯等，都是人体必需的微量营养素。
    module MacroMineralDris # rubocop:disable Metrics/ModuleLength
      include Aux

      ##
      # 钙的参考摄入量。
      #
      # @return [Dri]
      def calcium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('200mg/d'), ul: un('1000mg/d'))
          elsif @age < 1
            Dri.new(ai: un('250mg/d'), ul: un('1500mg/d'))
          elsif @age < 4
            Dri.new(ear: un('500mg/d'), rni: un('600mg/d'), ul: un('1500mg/d'))
          elsif @age < 7
            Dri.new(ear: un('650mg/d'), rni: un('800mg/d'), ul: un('2000mg/d'))
          elsif @age < 11
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          elsif @age < 14
            Dri.new(ear: un('1000mg/d'), rni: un('1200mg/d'), ul: un('2000mg/d'))
          elsif @age < 18
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          elsif @age < 50
            Dri.new(ear: un('650mg/d'), rni: un('800mg/d'), ul: un('2000mg/d'))
          else
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          end

        case @sex
        when :second_trimester, :third_trimester, :lactation
          dri.ear += un('160mg/d')
          dri.rni += un('200mg/d')
        end

        dri
      end

      ##
      # 磷的参考摄入量。
      #
      # @return [Dri]
      def phosphorus_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('100mg/d'))
          elsif @age < 1
            Dri.new(ai: un('180mg/d'))
          elsif @age < 4
            Dri.new(ear: un('250mg/d'), rni: un('300mg/d'))
          elsif @age < 7
            Dri.new(ear: un('290mg/d'), rni: un('350mg/d'))
          elsif @age < 11
            Dri.new(ear: un('400mg/d'), rni: un('470mg/d'))
          elsif @age < 14
            Dri.new(ear: un('540mg/d'), rni: un('640mg/d'))
          elsif @age < 18
            Dri.new(ear: un('590mg/d'), rni: un('710mg/d'))
          elsif @age < 65
            Dri.new(ear: un('600mg/d'), rni: un('720mg/d'), ul: un('3500mg/d'))
          elsif @age < 80
            Dri.new(ear: un('590mg/d'), rni: un('700mg/d'), ul: un('3000mg/d'))
          else
            Dri.new(ear: un('560mg/d'), rni: un('670mg/d'), ul: un('3000mg/d'))
          end
        dri.ul = un('3500mg/d') if pregnancy_or_lactation?
        dri
      end

      ##
      # 钾的参考摄入量。
      #
      # @return [Dri]
      def potassium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('350mg/d'))
          elsif @age < 1
            Dri.new(ai: un('550mg/d'))
          elsif @age < 4
            Dri.new(ai: un('900mg/d'))
          elsif @age < 7
            Dri.new(ai: un('1200mg/d'), pi: un('2100mg/d'))
          elsif @age < 11
            Dri.new(ai: un('1500mg/d'), pi: un('2800mg/d'))
          elsif @age < 14
            Dri.new(ai: un('1900mg/d'), pi: un('3400mg/d'))
          elsif @age < 18
            Dri.new(ai: un('2200mg/d'), pi: un('3900mg/d'))
          else
            Dri.new(ai: un('2000mg/d'), pi: un('3600mg/d'))
          end
        dri.ai += un('400mg/d') if lactation?
        dri
      end

      ##
      # 钠的参考摄入量。
      #
      # @return [Dri]
      def sodium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        if @age < 0.5
          Dri.new(ai: un('170mg/d'))
        elsif @age < 1
          Dri.new(ai: un('350mg/d'))
        elsif @age < 4
          Dri.new(ai: un('700mg/d'))
        elsif @age < 7
          Dri.new(ai: un('900mg/d'), pi: un('1200mg/d'))
        elsif @age < 11
          Dri.new(ai: un('1200mg/d'), pi: un('1500mg/d'))
        elsif @age < 14
          Dri.new(ai: un('1400mg/d'), pi: un('1900mg/d'))
        elsif @age < 18
          Dri.new(ai: un('1600mg/d'), pi: un('2200mg/d'))
        elsif @age < 50
          Dri.new(ai: un('1500mg/d'), pi: un('2000mg/d'))
        elsif @age < 65
          Dri.new(ai: un('1400mg/d'), pi: un('1900mg/d'))
        elsif @age < 80
          Dri.new(ai: un('1400mg/d'), pi: un('1800mg/d'))
        else
          Dri.new(ai: un('1300mg/d'), pi: un('1700mg/d'))
        end
      end

      ##
      # 镁的参考摄入量。
      #
      # @return [Dri]
      def magnesium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          if @age < 0.5
            Dri.new(ai: un('20mg/d'))
          elsif @age < 1
            Dri.new(ai: un('65mg/d'))
          elsif @age < 4
            Dri.new(ear: un('110mg/d'), rni: un('140mg/d'))
          elsif @age < 7
            Dri.new(ear: un('130mg/d'), rni: un('160mg/d'))
          elsif @age < 11
            Dri.new(ear: un('180mg/d'), rni: un('220mg/d'))
          elsif @age < 14
            Dri.new(ear: un('250mg/d'), rni: un('300mg/d'))
          elsif @age < 18
            Dri.new(ear: un('270mg/d'), rni: un('320mg/d'))
          elsif @age < 65
            Dri.new(ear: un('280mg/d'), rni: un('330mg/d'))
          elsif @age < 80
            Dri.new(ear: un('270mg/d'), rni: un('320mg/d'))
          else
            Dri.new(ear: un('260mg/d'), rni: un('310mg/d'))
          end

        if pregnancy?
          dri.ear += un('30mg/d')
          dri.rni += un('40mg/d')
        end

        dri
      end

      ##
      # 氯的参考摄入量。
      #
      # @return [Dri]
      def chloride_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        if @age < 0.5
          Dri.new(ai: un('260mg/d'))
        elsif @age < 1
          Dri.new(ai: un('550mg/d'))
        elsif @age < 4
          Dri.new(ai: un('1100mg/d'))
        elsif @age < 7
          Dri.new(ai: un('1400mg/d'))
        elsif @age < 11
          Dri.new(ai: un('1900mg/d'))
        elsif @age < 14
          Dri.new(ai: un('2200mg/d'))
        elsif @age < 18
          Dri.new(ai: un('2500mg/d'))
        elsif @age < 50
          Dri.new(ai: un('2300mg/d'))
        elsif @age < 80
          Dri.new(ai: un('2200mg/d'))
        else
          Dri.new(ai: un('2000mg/d'))
        end
      end
    end
  end
end
