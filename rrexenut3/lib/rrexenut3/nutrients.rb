#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-27
# Unlicense

require 'ruby-units'

require 'rrexenut3/infoods'

module RrExeNut3
  ##
  # 营养成分。
  #
  class Nutrients
    ##
    # 单位份量所含营养成分，其中键必须包含在 Infoods::TAGNAMES.keys 中，值必须是质量或热量。
    # @return [Hash<Symbol, Unit>]
    attr_reader :contained_nutrients

    ##
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
    # @param value [Unit, #to_unit] 质量或热量
    # @return [void]
    def []=(tagname, value)
      tagname = tagname.to_sym unless tagname.is_a?(Symbol)
      value = value.to_unit unless value.is_a?(Unit)

      raise ArgumentError, "未知的标签：#{tagname}" unless Infoods::TAGNAMES.keys.include?(tagname)
      raise ArgumentError, "营养成分值必须为质量或热量：{#{tagname}=>#{value}}" unless %i[mass energy].include?(value.kind) # rubocop:disable Layout/LineLength

      @contained_nutrients[tagname] = value.convert_to(Infoods::TAGNAMES[tagname].unit)
    end

    # conversion factor for calculating energy from protein
    PRO_ENER = Unit.new('17kJ/g').freeze
    # conversion factor for calculating energy from fat
    FAT_ENER = Unit.new('37kJ/g').freeze
    # conversion factor for calculating energy from carbohydrate
    CHO_ENER = Unit.new('17kJ/g').freeze
    # conversion factor for calculating energy from alcohol
    ALC_ENER = Unit.new('29kJ/g').freeze
    # conversion factor for calculating energy from fiber
    FIB_ENER = Unit.new('8kJ/g').freeze

    ##
    # 从蛋白质计算热量。
    # @return [Unit]
    def enerxp
      raise ArgumentError, '仅允许份量单位为标量 1 的营养成分计算热量' unless @unit_quantity == 1

      rv = Unit.new('0kJ')
      (Infoods::PRO_SYMBOLS & @contained_nutrients.keys).each { |sym| rv += @contained_nutrients[sym] * PRO_ENER }
      rv
    end

    ##
    # 从脂质计算热量。
    # @return [Unit]
    def enerxf
      raise ArgumentError, '仅允许份量单位为标量 1 的营养成分计算热量' unless @unit_quantity == 1

      rv = Unit.new('0kJ')
      (Infoods::FAT_SYMBOLS & @contained_nutrients.keys).each { |sym| rv += @contained_nutrients[sym] * FAT_ENER }
      rv
    end

    ##
    # 从碳水化合物计算热量。
    # @return [Unit]
    def enerxc
      raise ArgumentError, '仅允许份量单位为标量 1 的营养成分计算热量' unless @unit_quantity == 1

      rv = Unit.new('0kJ')
      (Infoods::CHO_SYMBOLS & @contained_nutrients.keys).each { |sym| rv += @contained_nutrients[sym] * PRO_ENER }
      rv
    end

    ##
    # 从酒精计算热量。
    # @return [Unit]
    def enerxa
      raise ArgumentError, '仅允许份量单位为标量 1 的营养成分计算热量' unless @unit_quantity == 1

      rv = Unit.new('0kJ')
      (Infoods::ALC_SYMBOLS & @contained_nutrients.keys).each { |sym| rv += @contained_nutrients[sym] * ALC_ENER }
      rv
    end

    ##
    # 从纤维计算热量。
    # @return [Unit]
    def enerxb
      raise ArgumentError, '仅允许份量单位为标量 1 的营养成分计算热量' unless @unit_quantity == 1

      rv = Unit.new('0kJ')
      (Infoods::FIB_SYMBOLS & @contained_nutrients.keys).each { |sym| rv += @contained_nutrients[sym] * FIB_ENER }
      rv
    end

    ##
    # 从产能营养素计算热量。
    # @return [Unit]
    def enerc
      (enerxp + enerxf + enerxc + enerxa + enerxb).convert_to('kJ')
    end

    ##
    # 蛋白质的能量贡献百分比
    def enerpp
      (ererxp / enerc).convert_to('%')
    end

    ##
    # 脂质的能量贡献百分比
    def enerpf
      (ererxf / enerc).convert_to('%')
    end

    ##
    # 碳水化合物的能量贡献百分比
    def enerpc
      (ererxc / enerc).convert_to('%')
    end

    ##
    # 酒精的能量贡献百分比
    def enerpa
      (ererxa / enerc).convert_to('%')
    end

    ##
    # 纤维的能量贡献百分比
    def enerpb
      (ererxb / enerc).convert_to('%')
    end

    ##
    # 加法。
    #
    # @param other [Nutrients] 右操作数
    def +(other)
      raise ArgumentError, '份量单位不兼容' unless @unit_quantity == other.unit_quantity

      rv = Nutrients.new(unit_quantity: @unit_quantity)
      (@contained_nutrients.keys + other.contained_nutrients.keys).uniq.each do |symbol|
        rv[symbol] =
          if @contained_nutrients[symbol].nil?
            other.contained_nutrients[symbol]
          elsif other.contained_nutrients[symbol].nil?
            @contained_nutrients[symbol]
          else
            @contained_nutrients[symbol] + other.contained_nutrients[symbol]
          end
      end
      rv
    end

    ##
    # 减法。
    #
    # @param other [Nutrients] 右操作数
    def -(other)
      raise ArgumentError, '份量单位不兼容' unless @unit_quantity == other.unit_quantity

      rv = Nutrients.new(unit_quantity: @unit_quantity)
      (@contained_nutrients.keys + other.contained_nutrients.keys).uniq.each do |symbol|
        rv[symbol] =
          if @contained_nutrients[symbol].nil?
            -other.contained_nutrients[symbol]
          elsif other.contained_nutrients[symbol].nil?
            @contained_nutrients[symbol]
          else
            @contained_nutrients[symbol] - other.contained_nutrients[symbol]
          end
      end
      rv
    end

    ##
    # 乘法。
    #
    # @param other [Unit, #to_unit] 右操作数
    # @return [Nutrients]
    def *(other)
      other = other.to_unit unless other.is_a?(Unit)

      factor = other / @unit_quantity
      raise ArgumentError, '仅允许积的份量单位为标量 1 的乘法' unless factor.kind == :unitless

      rv = Nutrients.new
      @contained_nutrients.each { |symbol, unit| rv[symbol] = unit * factor }
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
