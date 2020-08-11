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
    # 蛋白质的参考摄入量。
    #
    # 以氨基酸为基本单位，通过肽键连接起来的一类含氮大分子有机化合物。
    module ProteinDris
      include Aux

      ##
      # 蛋白质的参考摄入量。
      #
      # @return [Dri]
      def protein_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('9g/d'))
          when 0.5...1
            Dri.new(ear: un('15g/d'), rni: un('25g/d'))
          when 1...3
            Dri.new(ear: un('20g/d'), rni: un('25g/d'))
          when 3...6
            Dri.new(ear: un('25g/d'), rni: un('30g/d'))
          when 6...7
            Dri.new(ear: un('25g/d'), rni: un('35g/d'))
          when 7...9
            Dri.new(ear: un('30g/d'), rni: un('40g/d'))
          when 9...10
            Dri.new(ear: un('40g/d'), rni: un('45g/d'))
          when 10...11
            Dri.new(ear: un('40g/d'), rni: un('50g/d'))
          when 11...12
            male? ? Dri.new(ear: un('45g/d'), rni: un('55g/d')) : Dri.new(ear: un('40g/d'), rni: un('50g/d'))
          when 12...13
            male? ? Dri.new(ear: un('50g/d'), rni: un('60g/d')) : Dri.new(ear: un('45g/d'), rni: un('55g/d'))
          when 13...14
            male? ? Dri.new(ear: un('55g/d'), rni: un('65g/d')) : Dri.new(ear: un('50g/d'), rni: un('60g/d'))
          when 14...15
            male? ? Dri.new(ear: un('60g/d'), rni: un('70g/d')) : Dri.new(ear: un('50g/d'), rni: un('60g/d'))
          when 15...18
            male? ? Dri.new(ear: un('60g/d'), rni: un('75g/d')) : Dri.new(ear: un('50g/d'), rni: un('60g/d'))
          else
            Dri.new(ear: @weight * un('0.9g/kg*d'), rni: @weight * un('0.98g/kg*d'))
          end

        if second_trimester?
          dri.ear += un('10g/d')
          dri.rni += un('15g/d')
        elsif third_trimester?
          dri.ear += un('25g/d')
          dri.rni += un('30g/d')
        elsif lactation?
          dri.ear += un('20g/d')
          dri.rni += un('25g/d')
        end

        dri.ul = 2 * dir.rni

        dri
      end
    end
  end
end
