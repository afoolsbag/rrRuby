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
    # 能量的参考摄入量。
    # Dietary Energy.
    #
    # 膳食中的蛋白质、脂肪和碳水化合物等营养素在人体代谢中产生的能量。
    module EnergyDri
      include Aux

      # 碳水化合物的食物热效应（thermic effect of food），5% ~ 10%
      CHO_TEF = 0.075
      # 脂肪的食物热效应，0% ~ 5%
      FAT_TEF = 0.025
      # 蛋白质的食物热效应，20% ~ 30%
      PRO_TEF = 0.250
      # 每日因食物热效应而增加的能量消耗，约为基础代谢的 10%
      BMR_TEF = 0.100

      ##
      # 能量的参考摄入量。
      #
      # @return [Dri]
      def energy_dri
        dri = Dri.new(eer: @weight * bmr * pal)
        dri.eer += un('50kcal/d') if first_trimester?
        dri.eer += un('300kcal/d') if second_trimester?
        dri.eer += un('450kcal/d') if third_trimester?
        dri
      end

      private

      ##
      # 基础代谢率。
      # Basal Metabolic Rate.
      #
      # @return [Unit]
      def bmr
        rv = male? ? un('22.3kcal/kg*d') : un('21.2kcal/kg*d')
        rv *= 0.95 if @age >= 50
        rv
      end

      ##
      # 身体活动水平。
      # Physical Activity Level.
      #
      # 总能量消耗（TEE）与基础能量消耗（BEE）的比值，用以表示身体活动强度。
      #
      # @return [Float]
      def pal # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
        case @age
        when 0...3
          1.35
        when 3...6
          1.45
        when 6...8
          1.57
        when 8...10
          1.59
        when 10...12
          1.63
        when 12...15
          1.66
        when 15...18
          1.76
        else
          rv =
            case @lifestyle
            when :rest # 1.2
              1.2
            when :sedentary # 1.4 ~ 1.5
              1.45
            when :handicraft # 1.6 ~ 1.7
              1.65
            when :light_labor # 1.8 ~ 1.9
              1.85
            when :heavy_labor # 2.0 ~ 2.4
              2.2
            end
          rv += 0.3 if @extra_exercise
          rv -= 0.05 if @age >= 80
          rv
        end
      end
    end
  end
end
