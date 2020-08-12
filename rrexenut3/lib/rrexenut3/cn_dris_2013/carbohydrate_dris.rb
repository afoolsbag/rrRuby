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
    # 碳水化合物的参考摄入量。
    #
    # 糖、寡糖、多糖的总称，是提供能量的重要营养素。
    module CarbohydrateDris
      include Aux

      protected

      ##
      # 碳水化合物的参考摄入量。
      # DRI of Carbohydrate.
      #
      #   :'CHO-'
      #
      # @return [Dri]
      def cho_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('60g/d'))
          when 0.5...1
            Dri.new(ai: un('85g/d'))
          when 1...11
            Dri.new(ear: un('120g/d'))
          when 11...18
            Dri.new(ear: un('150g/d'))
          when 18...65
            Dri.new(ear: un('120g/d'))
          else
            Dri.new
          end
        dri.ear = un('130g/d') if pregnancy?
        dri.ear = un('160g/d') if lactation?
        dri.lamdr = un('50%')
        dri.uamdr = un('65%')
        dri
      end

      ##
      # 添加糖的参考摄入量。
      # DRI if Sugar.
      #
      #   :SUGAR
      #
      # @return [Dri]
      def sugar_dri
        Dri.new(uamdr: un('10%'))
      end
    end
  end
end
