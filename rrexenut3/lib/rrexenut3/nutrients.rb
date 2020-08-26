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
    # 单位份量所含营养成分，其中键必须包含在 Infoods::TAGNAMES.keys 中，值必须是质量、体积或能量。
    # @return [Hash<Symbol, Unit>]
    def contained_nutrients
      @contained_nutrients.dup.freeze
    end

    # 单位份量
    # @return [Unit]
    attr_reader :unit_quantity

    ##
    # 初始化方法。
    #
    # @param unit_quantity [Unit, #to_unit] 单位份量
    #
    # @example 每 100g 所含营养成分
    #   Nutrients.new('100g')
    # @example 每 1day 所需营养成分
    #   Nutrients.new('1day')
    def initialize(unit_quantity: 1)
      unit_quantity = unit_quantity.to_unit unless unit_quantity.is_a?(Unit)

      @contained_nutrients = {}
      @unit_quantity = unit_quantity
    end

    ##
    # 取某项营养成分。
    #
    # @param tagname [Symbol, #to_sym] INFOODS 标签
    # @return [Unit]
    def [](tagname)
      tagname = tagname.to_sym unless tagname.is_a?(Symbol)

      @contained_nutrients[tagname].clone
    end

    ##
    # 赋某项营养成分。
    #
    # @param tagname [Symbol, #to_sym] INFOODS 标签
    # @param value [Unit, #to_unit] 质量、体积或热量
    # @return [void]
    def []=(tagname, value)
      tagname = tagname.to_sym unless tagname.is_a?(Symbol)
      value = value.to_unit unless value.is_a?(Unit)

      raise ArgumentError, "未知的标签：#{tagname}" unless Infoods::TAGNAMES.keys.include?(tagname)
      raise ArgumentError, "营养成分值必须为质量、体积或热量：{#{tagname}=>#{value}}" unless %i[mass volume energy].include?(value.kind) # rubocop:disable Layout/LineLength

      @contained_nutrients[tagname] = value
    end

    ##
    # 加法。
    #
    # @param other [Nutrients] 右操作数
    def +(other)
      raise ArgumentError, '取样单位不兼容' unless @unit_quantity == other.unit_quantity

      rv = Nutrients.new(unit_quantity: @unit_quantity)
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
      raise ArgumentError, '取样单位不兼容' unless @unit_quantity == other.unit_quantity

      rv = Nutrients.new(unit_quantity: @unit_quantity)
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
      raise ArgumentError, '仅允许积的取样单位为标量 1 的乘法' unless @unit_quantity =~ other_unit.inverse

      factor = (@unit_quantity * other_unit).base_scalar
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
          unit quantity:       #{@unit_quantity}
      STRING
    end
  end
end
