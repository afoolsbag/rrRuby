#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-12 – 2020-08-12
# Unlicense

require 'ruby-units'

module RrExeNut3
  module CnDris2013
    ##
    # 辅助。
    module Aux
      protected

      ##
      # 男性？
      #
      # 非女性即男性，本参考摄入量不支持第三性。
      #
      # @return [Boolean]
      def male?
        case @sex
        when :male
          true
        else
          false
        end
      end

      ##
      # 女性？
      #
      # 非男性即女性，本参考摄入量不支持第三性。
      #
      # @return [Boolean]
      def female?
        case @sex
        when :female, :first_trimester, :second_trimester, :third_trimester, :lactation
          true
        else
          false
        end
      end

      ##
      # 孕早期？
      def first_trimester?
        case @sex
        when :first_trimester
          true
        else
          false
        end
      end

      ##
      # 孕中期？
      def second_trimester?
        case @sex
        when :second_trimester
          true
        else
          false
        end
      end

      ##
      # 孕晚期？
      def third_trimester?
        case @sex
        when :third_trimester
          true
        else
          false
        end
      end

      ##
      # 孕期？
      #
      # @return [Boolean]
      def pregnancy?
        case @sex
        when :first_trimester, :second_trimester, :third_trimester
          true
        else
          false
        end
      end

      ##
      # 哺乳期？
      #
      # @return [Boolean]
      def lactation?
        case @sex
        when :lactation
          true
        else
          false
        end
      end

      ##
      # 孕期或哺乳期？
      #
      # @return [Boolean]
      def pregnancy_or_lactation?
        case @sex
        when :first_trimester, :second_trimester, :third_trimester, :lactation
          true
        else
          false
        end
      end

      ##
      # Unit.new(*args) 的缩写方法。
      #
      # @return [Unit]
      def un(*args)
        Unit.new(*args)
      end
    end
  end
end
