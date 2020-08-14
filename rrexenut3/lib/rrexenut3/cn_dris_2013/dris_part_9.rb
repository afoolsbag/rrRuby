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
    # 参考摄入量第九部分：其他膳食成分。
    # DRIs Part 9: Non-nutrient Diet Components.
    module DrisPart9
      include Aux

      # 饮水和膳食纤维

      ##
      # 饮水的参考摄入量。
      # DRI of Water.
      #
      #   :WATER
      #
      # @return [Dri]
      def water_dri
        dri =
          case @age.scalar
          when 1...4
            Dri.new
          when 4...7
            Dri.new(ai: un('0.8L/d'))
          when 7...11
            Dri.new(ai: un('1.0L/d'))
          when 11...14
            male? ? Dri.new(ai: un('1.3L/d')) : Dri.new(ai: un('1.1L/d'))
          when 14...18
            male? ? Dri.new(ai: un('1.4L/d')) : Dri.new(ai: un('1.2L/d'))
          else
            male? ? Dri.new(ai: un('1.7L/d')) : Dri.new(ai: un('1.5L/d'))
          end
        dri.ai += un('0.2L/d') if pregnancy?
        dri.ai += un('0.6L/d') if lactation?
        dri
      end

      ##
      # 膳食纤维的参考摄入量。
      # DRI of Fibre.
      #
      # 物性食物中含有的，不能被人体小肠消化吸收的，对人体有健康意义的碳水化合物。
      # 包括纤维素、半纤维素、果胶、菊粉等，还包括木质素等其他一些成分。
      #
      #   :'FIB-'
      #
      # @return [Dri]
      def fib_dri
        Dri.new(ai: un('25g/d'))
      end

      # 酚类

      ##
      # 儿茶素的参考摄入量。
      # DRI of Catechin.
      #
      # @return [Dri]
      def cat_dri; end

      ##
      # 原花青素的参考摄入量。
      # DRI of Proanthocyanidin.
      #
      # @return [Dri]
      def pa_dri
        Dri.new(ul: un('800mg/d'))
      end

      ##
      # 槲皮素的参考摄入量。
      # DRI of Quercetin.
      #
      # @return [Dri]
      def que_dri; end

      ##
      # 花色苷的参考摄入量。
      # DRI of Anthocyanin.
      #
      # @return [Dri]
      def acn_dri
        Dri.new(spl: un('50mg/d'))
      end

      ##
      # 大豆异黄酮的参考摄入量。
      # DRI of Soy Isoflavone.
      #
      # 指绝经后妇女。
      #
      # @return [Dri]
      def soyiso_dri
        Dri.new(spl: un('55mg/d'), ul: un('120mg/d'))
      end

      ##
      # 姜黄素的参考摄入量。
      # DRI of Curcumin.
      #
      # @return [Dri]
      def cur_dri
        Dri.new(ul: un('720mg/d'))
      end

      ##
      # 绿原酸的参考摄入量。
      # DRI of Chlorogenic Acid.
      #
      # @return [Dri]
      def cga_dri; end

      ##
      # 白藜芦醇的参考摄入量。
      # DRI of Resveratrol.
      #
      # @return [Dri]
      def res_dri; end

      # 萜类

      ##
      # 番茄红素的参考摄入量。
      # DRI of Lycopene.
      #
      #   :LYCPN
      #
      # @return [Dri]
      def lycpn_dri
        Dri.new(spl: un('18mg/d'), ul: un('70mg/d'))
      end

      ##
      # 叶黄素的参考摄入量。
      # DRI of Lutein.
      #
      #   :LUTN
      #
      # @return [Dri]
      def lutn_dri
        Dri.new(spl: un('10mg/d'), ul: un('40mg/d'))
      end

      ##
      # 植物甾醇的参考摄入量。
      # DRI of Phytosterol.
      #
      #   :PHYSTR
      #
      # @return [Dri]
      def phystr_dri
        Dri.new(spl: un('0.9g/d'), ul: un('2.4g/d'))
      end

      # 含硫化合物

      ##
      # 异硫氰酸盐的参考摄入量。
      # DRI of Isothiocyanate.
      #
      # @return [Dri]
      def itc_dri; end

      ##
      # 硫辛酸的参考摄入量。
      # DRI of Thioctic Acid.
      #
      # @return [Dri]
      def ta_dri; end

      ##
      # 大蒜素的参考摄入量。
      # DRI of Allicin.
      #
      # @return [Dri]
      def all_dri; end

      # 其它

      ##
      # γ-氨基丁酸的参考摄入量。
      # DRI of Gamma-aminobutyric Acid.
      #
      # @return [Dri]
      def gaba_dri; end

      ##
      # 左旋肉碱的参考摄入量。
      # DRI of L-carnitine.
      #
      # @return [Dri]
      def lc_dri; end

      ##
      # 氨基葡糖糖的参考摄入量。
      # DRI of Glucosamine.
      #
      # @return [Dri]
      def glcn_dri
        Dri.new(spl: un('1000mg/d'))
      end

      ##
      # 低聚果糖的参考摄入量。
      # DRI of Fructooligosaccharide.
      #
      # @return [Dri]
      def fos_dri; end
    end
  end
end
