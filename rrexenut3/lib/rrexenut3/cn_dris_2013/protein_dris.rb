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
    # 蛋白质（和氨基酸）的参考摄入量。
    module ProteinDris
      include Aux

      protected

      ##
      # 蛋白质的参考摄入量。
      # DRI of Protein.
      #
      # 以氨基酸为基本单位，通过肽键连接起来的一类含氮大分子有机化合物。
      #
      #   :'PRO-'
      #
      # @return [Dri]
      def prot_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('9g/d'))
          when 0.5...1
            Dri.new(ear: un('15g/d'), rni: un('20g/d'))
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
          when 11...14
            male? ? Dri.new(ear: un('50g/d'), rni: un('60g/d')) : Dri.new(ear: un('45g/d'), rni: un('50g/d'))
          when 14...18
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

      # 必需氨基酸
      # Essential Amino Acids

      ##
      # 组氨酸的参考摄入量。
      # DRI of Histidine.
      #
      #   :HIS
      #
      # @return [Dri]
      def his_dri; end

      ##
      # 异亮氨酸的参考摄入量。
      # DRI of Isoleucine.
      #
      #   :ILE
      #
      # @return [Dri]
      def ild_dri; end

      ##
      # 亮氨酸的参考摄入量。
      # DRI of Leucine.
      #
      #   :LEU
      #
      # @return [Dri]
      def leu_dri; end

      ##
      # 赖氨酸的参考摄入量。
      # DRI of Lysine.
      #
      #   :LYS
      #
      # @return [Dri]
      def lys_dri; end

      ##
      # 甲硫氨酸的参考摄入量。
      # DRI of Methionine.
      #
      #   :MET
      #
      # @return [Dri]
      def met_dri; end

      ##
      # 苯丙氨酸的参考摄入量。
      # DRI of Phenylalanine.
      #
      #   :PHE
      #
      # @return [Dri]
      def phe_dri; end

      ##
      # 苏氨酸的参考摄入量。
      # DRI of Threonine.
      #
      #   :THR
      #
      # @return [Dri]
      def thr_dri; end

      ##
      # 色氨酸的参考摄入量。
      # DRI of Tryptophan.
      #
      #   :TRP
      #
      # @return [Dri]
      def trp_dri; end

      ##
      # 缬氨酸的参考摄入量。
      # DRI of Valine.
      #
      #   :VAL
      #
      # @return [Dri]
      def val_dri; end

      # 条件必须氨基酸
      # Conditionally Essential Amino Acids

      ##
      # 精氨酸的参考摄入量。
      # DRI of Arginine.
      #
      #   :ARG
      #
      # @return [Dri]
      def arg_dri; end

      ##
      # 半胱氨酸的参考摄入量。
      # DRI of Cysteine.
      #
      #   :CYS
      #
      # @return [Dri]
      def cys_dri; end

      ##
      # 谷氨酰胺的参考摄入量。
      # DRI of Glutamine.
      #
      #   :GLN
      #
      # @return [Dri]
      def gln_dri; end

      ##
      # 谷氨酸的参考摄入量。
      # DRI of Glycine.
      #
      #   :GLY
      #
      # @return [Dri]
      def gly_dri; end

      ##
      # 脯氨酸的参考摄入量。
      # DRI of Proline.
      #
      #   :PRO
      #
      # @return [Dri]
      def pro_dri; end

      ##
      # 酪氨酸的参考摄入量。
      # DRI of Tyrosine.
      #
      #   :TYR
      #
      # @return [Dri]
      def typ_dri; end

      # 非必须氨基酸
      # Non-essential Amino Acids

      ##
      # 丙氨酸的参考摄入量。
      # DRI of Alanine.
      #
      #   :ALA
      #
      # @return [Dri]
      def ala_dri; end

      ##
      # 天冬氨酸的参考摄入量。
      # DRI of Aspartic acid.
      #
      #   :ASP
      #
      # @return [Dri]
      def asp_dri; end

      ##
      # 天冬酰胺的参考摄入量。
      # DRI of Asparagine.
      #
      #   :ASN
      #
      # @return [Dri]
      def asn_dri; end

      ##
      # 谷氨酸的参考摄入量。
      # DRI of Glutamic acid.
      #
      #   :GLU
      #
      # @return [Dri]
      def glu_dri; end

      ##
      # 丝氨酸的参考摄入量。
      # DRI of Serine.
      #
      #   :SER
      #
      # @return [Dri]
      def ser_dri; end

      ##
      # 硒代半胱氨酸的参考摄入量。
      # DRI of Selenocysteine.
      #
      # @return [Dri]
      def sec_dri; end

      ##
      # 吡咯赖氨酸的参考摄入量。
      # DRI of Pyrrolysine.
      #
      # @return [Dri]
      def pyl_dri; end
    end
  end
end
