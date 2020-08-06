#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-07-27
# Unlicense

require 'ruby-units'

require 'rrexenut3/infoods'

module RrExeNut3
  ##
  # 营养成分。
  #
  class Nutrients
    # 取样单位
    # @return [Unit]
    attr_reader :sampling_unit

    # 所含营养成分，其中键必须包含在 Infoods::TAGNAMES.keys 中，值必须是质量。
    # @return [Hash<Symbol, Unit>]
    def contained_nutrients
      @contained_nutrients.dup.freeze
    end

    ##
    # 初始化方法。
    #
    # @param sampling_unit [Unit] 取样单位
    #
    # @example 每 100g 所含营养成分
    #   Nutrients.new(Unit.new('100 g'))
    # @example 每 1day 所需营养成分
    #   Nutrients.new(Unit.new('100 day'))
    def initialize(sampling_unit: Unit.new('1'))
      @contained_nutrients = {}
      @sampling_unit = sampling_unit
    end

    ##
    # 取某项营养成分。
    #
    # @param tagname [Symbol] INFOODS 标签
    # @return [Unit]
    def [](tagname)
      @contained_nutrients[tagname].clone
    end

    UNIT_MASS = Unit.new('1kg').freeze

    ##
    # 赋某项营养成分。
    #
    # @param tagname [Symbol] INFOODS 标签
    # @param mass [Unit] 质量
    # @return [void]
    def []=(tagname, mass)
      raise ArgumentError, '未知的标签' unless Infoods::TAGNAMES.keys.include?(tagname)
      raise ArgumentError, '营养成分值必须为质量' unless mass =~ UNIT_MASS

      @contained_nutrients[tagname] = mass
    end

    ##
    # 加法。
    #
    # @param other [Nutrients] 右操作数
    def +(other)
      raise ArgumentError, '取样单位不兼容' unless @sampling_unit == other.sampling_unit

      rv = Nutrients.new(sampling_unit: @sampling_unit)
      (@contained_nutrients.keys + other.contained_nutrients.keys).uniq.each do |symbol|
        rv[symbol] = (@contained_nutrients[symbol] || 0) + (other.contained_nutrients[symbol] || 0)
      end
      rv
    end

    ##
    # 减法。
    #
    # @param other [Nutrients] 右操作数
    def -(other)
      raise ArgumentError, '取样单位不兼容' unless @sampling_unit == other.sampling_unit

      rv = Nutrients.new(sampling_unit: @sampling_unit)
      (@contained_nutrients.keys + other.contained_nutrients.keys).uniq.each do |symbol|
        rv[symbol] = (@contained_nutrients[symbol] || 0) - (other.contained_nutrients[symbol] || 0)
      end
      rv
    end

    ##
    # 乘法。
    #
    # @param other [#to_unit] 右操作数
    def *(other)
      other_unit = Unit.new(other)
      raise ArgumentError, '仅允许积的取样单位为标量 1 的乘法' unless @sampling_unit =~ other_unit.inverse

      factor = (@sampling_unit * other_unit).base_scalar
      rv = Nutrients.new
      @contained_nutrients.each do |symbol, unit|
        rv[symbol] = unit * factor
      end
      rv
    end

    ##
    # +to_s+
    def to_s
      <<~STRING
        #{super}
          contained nutrients: #{@contained_nutrients}
          sampling unit:       #{@sampling_unit}
      STRING
    end
  end
end
