#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-07 – 2020-08-07
# Unlicense

require 'ruby-units'

require 'rrexenut3/nutrients'

module RrExeNut3
  ##
  # 中国居民膳食营养素参考摄入量（2013版）。
  # Chinese Dietary Reference Intakes 2013.
  class CnDris2013 # rubocop:disable Metrics/ClassLength
    ##
    # 初始化。
    #
    # +sex+ 的可选值有：
    #   :male             # 男性
    #   :female           # 女性
    #   :first_trimester  # 孕早期
    #   :second_trimester # 孕中期
    #   :third_trimester  # 孕晚期
    #   :lactation        # 哺乳期
    #
    # +lifestyle+ 的可选值有：
    #   :rest             # 静养，如不能自理的老年人或残疾人
    #   :sedentary        # 久坐，如办公室职员或精密仪器机械师
    #   :handicraft       # 手工，有时需要站立或走动，如实验室助理，司机，学生或装配线工人
    #   :light_labor      # 轻劳作，主要是站立或走动工作，如家庭主妇，销售员，侍应生，机械师或交易员
    #   :heavy_labor      # 重劳作，如建筑工人，农民，林业人员，矿工或运动员
    #
    # +extra_exercise+ 的评判标准：
    # 额外有明显的体育运动量或重体力休闲活动，每周 4 ~ 5 次，每次 30 ~ 60 分钟。
    #
    # @param sex [Symbol] 生理性别、孕期或哺乳期
    # @param age [Float] 实际年龄
    # @param weight [Unit] 体重
    # @param lifestyle [Symbol] 生活方式
    # @param extra_exercise [Boolean] 额外运动
    # @return [void]
    def initialize(sex:, age:, weight:, # rubocop:disable Metrics/ParameterLists
                   lifestyle: :sedentary, extra_exercise: false)
      @sex = sex
      @age = age
      @weight = weight
      @lifestyle = lifestyle
      @extra_exercise = extra_exercise
    end

    ##
    # 对今日营养素的摄入、消耗进行总结，生成总结报告。
    #
    # @param nutrients [Nutrients] 摄入营养素，忽略其取样单位。
    # @return [String] 报告。
    def summary(_nutrients) end

    private

    ##
    # Unit.new(*args) 的缩写方法。
    #
    # @return [Unit]
    def un(*args)
      Unit.new(*args)
    end

    ##
    # 男性？
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
    # 某营养素的参考摄入量。
    #
    # @!attribute [rw] ear
    #   @return [Unit, nil] 平均需要量（estimated average requirement）
    #                       特定群体中 50% 个体满足需要的量
    #
    # @!attribute [rw] rni
    #   @return [Unit, nil] 推荐摄入量（recommended nutrient intake）
    #                       特定群体中 97% 个体满足需要的量，自 EAR 推算
    #
    # @!attribute [rw] eer
    #   @return [Unit, nil] 能量需要量（estimated energy requirement）
    #                       特定群体中 97% 个体满足需要的量，专用于能量
    #
    # @!attribute [rw] ai
    #   @return [Unit, nil] 适宜摄入量（adequate intake）
    #                       当研究资料不足而无法统计出 EAR 时，谨慎替代 RNI
    #
    # @!attribute [rw] ul
    #   @return [Unit, nil] 可耐受最高摄入量（tolerable upper intake level）
    #
    # @!attribute [rw] amdr
    #   @return [Unit, nil] 宏量营养素可接受范围（acceptable macronutrient distribution range）
    #                       专用于脂肪、蛋白质和碳水化合物
    #
    # @!attribute [rw] pi
    #   @return [Unit, nil] 预防非传染性慢性病的建议摄入量
    #                       proposed intakes for preventing non-communicable chronic diseases
    #
    # @!attribute [rw] spl
    #   @return [Unit, nil] 特定建议值（specific proposed level）
    #
    # HACK: 为了令 IDE Hinting 识别，多余地继承自结构体。
    class Dri < Struct.new(# rubocop:disable Style/StructInheritance
      :ear, :rni, :eer, :ai, :ul, :amdr, :pi, :spl,
      keyword_init: true
    ); end

    #---------------------------------------------------------------------------
    # 能量

    # 碳水化合物的食物热效应（thermic effect of food），5% ~ 10%
    CHO_TEF = 0.075
    # 脂肪的食物热效应，0% ~ 5%
    FAT_TEF = 0.025
    # 蛋白质的食物热效应，20% ~ 30%
    PRO_TEF = 0.250
    # 每日因食物热效应而增加的能量消耗，约为基础代谢的 10%
    BMR_TEF = 0.100

    ##
    # 基础代谢率（basal metabolic rate）。
    #
    # @return [Unit]
    def bmr
      rv =
        if male?
          un('22.3kcal/kg*d')
        elsif female?
          un('21.2kcal/kg*d')
        end
      rv *= 0.95 if @age >= 50
      rv
    end

    ##
    # 身体活动水平（physical activity level）。
    #
    # @return [Float]
    def pal # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      if @age < 3 # rubocop:disable Style/GuardClause
        return 1.35
      elsif @age < 6
        return 1.45
      elsif @age < 8
        return 1.57
      elsif @age < 10
        return 1.59
      elsif @age < 12
        return 1.63
      elsif @age < 15
        return 1.66
      elsif @age < 18
        return 1.76
      end

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

    ##
    # 能量的参考摄入量。
    #
    # @return [Dri]
    def energy_dri
      dri = Dri.new(eer: @weight * bmr * pal)

      case @sex
      when :first_trimester
        dri.eer += un('50kcal/d')
      when :second_trimester
        dri.eer += un('300kcal/d')
      when :third_trimester
        dri.eer += un('450kcal/d')
      end

      dri
    end

    #---------------------------------------------------------------------------
    # 蛋白质和氨基酸

    ##
    # 蛋白质的参考摄入量。
    #
    # @return [Dri]
    #
    # TODO: 未完成正在做，同步代码
    def protein_dri
      dri =
      if @age < 1
      elsif @age < 3
        Dri.new(ear: un('20g/d'), rni: un('25g/d'))
      elsif @age < 6
        Dri.new(ear: un('25g/d'), rni: un('30g/d'))
      elsif @age < 7
        Dri.new(ear: un('25g/d'), rni: un('35g/d'))
      elsif @age < 9
        Dri.new(ear: un('30g/d'), rni: un('40g/d'))
      elsif @age < 10
        Dri.new(ear: un('40g/d'), rni: un('45g/d'))
      elsif @age < 11
        Dri.new(ear: un('40g/d'), rni: un('50g/d'))
      elsif @age < 12 && male?
        Dri.new(ear: un('45g/d'), rni: un('55g/d'))
      elsif @age < 12 && female?
        Dri.new(ear: un('40g/d'), rni: un('50g/d'))
      elsif @age < 13 && male?
        Dri.new(ear: un('50g/d'), rni: un('60g/d'))
      elsif @age < 13 && female?
        Dri.new(ear: un('45g/d'), rni: un('55g/d'))
      elsif @age < 14 && male?
        Dri.new(ear: un('55g/d'), rni: un('65g/d'))
      elsif @age < 14 && female?
        Dri.new(ear: un('50g/d'), rni: un('60g/d'))
      else
        Dri.new(ear: @weight * un('0.9g/kg*d'), rni: @weight * un('0.98g/kg*d'))
      end

      case @sex
      when :second_trimester
        dri.rni += un('15g/d')
      when :third_trimester
        dri.rni += un('30g/d')
      end

      dri.ul = 2 * dir.rni

      dri
    end

    ##
    # 碳水化合物的参考摄入量。
    #
    # @return [Dri]
    #
    # FIXME: 需要重新审查
    def carbohydrate_dri
      if @age < 0.5
        Dri.new(ai: un('60g/d'))
      elsif @age < 1
        Dri.new(ai: un('85g/d'))
      elsif @age < 11
        Dri.new(ear: un('120g/d'))
      elsif @age < 18
        Dri.new(ear: un('150g/d'))
      elsif @age < 65
        Dri.new(ear: un('120g/d'))
      else
        Dri.new
      end
    end

    #---------------------------------------------------------------------------
    # 常量元素

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

    #---------------------------------------------------------------------------
    # 微量元素

    ##
    # 铁的参考摄入量。
    #
    # @return [Dri]
    def iron_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('0.3mg/d'))
        elsif @age < 1
          Dri.new(ear: un('7mg/d'), rni: un('10mg/d'))
        elsif @age < 4
          Dri.new(ear: un('6mg/d'), rni: un('9mg/d'), ul: un('25mg/d'))
        elsif @age < 7
          Dri.new(ear: un('7mg/d'), rni: un('10mg/d'), ul: un('30mg/d'))
        elsif @age < 11
          Dri.new(ear: un('10mg/d'), rni: un('13mg/d'), ul: un('35mg/d'))
        elsif @age < 14 && male?
          Dri.new(ear: un('11mg/d'), rni: un('15mg/d'), ul: un('40mg/d'))
        elsif @age < 14 && female?
          Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d'))
        elsif @age < 18 && male?
          Dri.new(ear: un('12mg/d'), rni: un('16mg/d'), ul: un('40mg/d'))
        elsif @age < 18 && female?
          Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d'))
        elsif @age < 50 && male?
          Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d'))
        elsif @age < 50 && female?
          Dri.new(ear: un('15mg/d'), rni: un('20mg/d'), ul: un('42mg/d'))
        else
          Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d'))
        end

      case @sex
      when :second_trimester
        dri.ear += un('4mg/d')
        dri.rni += un('4mg/d')
      when :third_trimester
        dri.ear += un('7mg/d')
        dri.rni += un('9mg/d')
      when :lactation
        dri.ear += un('3mg/d')
        dri.rni += un('4mg/d')
      end

      dri
    end

    ##
    # 碘的参考摄入量。
    #
    # @return [Dri]
    def iodine_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('85ug/d'))
        elsif @age < 1
          Dri.new(ai: un('115ug/d'))
        elsif @age < 4
          Dri.new(ear: un('65ug/d'), rni: un('90ug/d'))
        elsif @age < 7
          Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('200ug/d'))
        elsif @age < 11
          Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('300ug/d'))
        elsif @age < 14
          Dri.new(ear: un('75ug/d'), rni: un('110ug/d'), ul: un('400ug/d'))
        elsif @age < 18
          Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('500ug/d'))
        else
          Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('600ug/d'))
        end

      if pregnancy?
        dri.ear += un('75ug/d')
        dri.rni += un('110ug/d')
      end

      if lactation?
        dri.ear += un('85ug/d')
        dri.rni += un('120ug/d')
      end

      dri
    end

    ##
    # 锌的参考摄入量。
    #
    # @return [Dri]
    def zinc_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('2mg/d'))
        elsif @age < 1
          Dri.new(ear: un('2.8mg/d'), rni: un('3.5mg/d'))
        elsif @age < 4
          Dri.new(ear: un('3.2mg/d'), rni: un('4mg/d'), ul: un('8mg/d'))
        elsif @age < 7
          Dri.new(ear: un('4.6mg/d'), rni: un('5.5mg/d'), ul: un('12mg/d'))
        elsif @age < 11
          Dri.new(ear: un('5.9mg/d'), rni: un('7mg/d'), ul: un('19mg/d'))
        elsif @age < 14 && male?
          Dri.new(ear: un('8.2mg/d'), rni: un('10mg/d'), ul: un('28mg/d'))
        elsif @age < 14 && female?
          Dri.new(ear: un('7.6mg/d'), rni: un('9mg/d'), ul: un('28mg/d'))
        elsif @age < 18 && male?
          Dri.new(ear: un('9.7mg/d'), rni: un('11.5mg/d'), ul: un('35mg/d'))
        elsif @age < 18 && female?
          Dri.new(ear: un('6.9mg/d'), rni: un('8.5mg/d'), ul: un('35mg/d'))
        elsif male?
          Dri.new(ear: un('10.4mg/d'), rni: un('12.5mg/d'), ul: un('40mg/d'))
        elsif female?
          Dri.new(ear: un('6.1mg/d'), rni: un('7.5mg/d'), ul: un('40mg/d'))
        end

      if pregnancy?
        dri.ear += un('1.7mg/d')
        dri.rni += un('2mg/d')
      end

      if lactation?
        dri.ear += un('3.8mg/d')
        dri.rni += un('4.5mg/d')
      end

      dri
    end

    ##
    # 硒的参考摄入量。
    #
    # @return [Dri]
    def selenium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('15ug/d'), ul: un('55ug/d'))
        elsif @age < 1
          Dri.new(ai: un('20ug/d'), ul: un('80ug/d'))
        elsif @age < 4
          Dri.new(ear: un('20ug/d'), rni: un('25ug/d'), ul: un('100ug/d'))
        elsif @age < 7
          Dri.new(ear: un('25ug/d'), rni: un('30ug/d'), ul: un('150ug/d'))
        elsif @age < 11
          Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
        elsif @age < 14
          Dri.new(ear: un('45ug/d'), rni: un('55ug/d'), ul: un('300ug/d'))
        elsif @age < 18
          Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('350ug/d'))
        else
          Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('400ug/d'))
        end

      if pregnancy?
        dri.ear += un('4ug/d')
        dri.rni += un('5ug/d')
      end

      if lactation?
        dri.ear += un('15ug/d')
        dri.rni += un('18ug/d')
      end

      dri
    end

    ##
    # 铜的参考摄入量。
    #
    # @return [Dri]
    def copper_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 1
          Dri.new(ai: un('20mg/d'))
        elsif @age < 4
          Dri.new(ear: un('0.25mg/d'), rni: un('0.3mg/d'), ul: un('2mg/d'))
        elsif @age < 7
          Dri.new(ear: un('0.3mg/d'), rni: un('0.4mg/d'), ul: un('3mg/d'))
        elsif @age < 11
          Dri.new(ear: un('0.4mg/d'), rni: un('0.5mg/d'), ul: un('4mg/d'))
        elsif @age < 14
          Dri.new(ear: un('0.55mg/d'), rni: un('0.7mg/d'), ul: un('6mg/d'))
        elsif @age < 18
          Dri.new(ear: un('0.6mg/d'), rni: un('0.8mg/d'), ul: un('7mg/d'))
        else
          Dri.new(ear: un('0.6mg/d'), rni: un('0.8mg/d'), ul: un('8mg/d'))
        end

      if pregnancy?
        dri.ear += un('0.1mg/d')
        dri.rni += un('0.1mg/d')
      end

      if lactation?
        dri.ear += un('0.5mg/d')
        dri.rni += un('0.6mg/d')
      end

      dri
    end

    ##
    # 氟的参考摄入量。
    #
    # @return [Dri]
    def fluorine_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      if @age < 0.5
        Dri.new(ai: un('0.01mg/d'))
      elsif @age < 1
        Dri.new(ai: un('0.23mg/d'))
      elsif @age < 4
        Dri.new(ai: un('0.6mg/d'), ul: un('0.8mg/d'))
      elsif @age < 7
        Dri.new(ai: un('0.7mg/d'), ul: un('1.1mg/d'))
      elsif @age < 11
        Dri.new(ai: un('1mg/d'), ul: un('1.7mg/d'))
      elsif @age < 14
        Dri.new(ai: un('1.3mg/d'), ul: un('2.5mg/d'))
      elsif @age < 18
        Dri.new(ai: un('1.5mg/d'), ul: un('3.1mg/d'))
      else
        Dri.new(ai: un('1.5mg/d'), ul: un('3.5mg/d'))
      end
    end

    ##
    # 铬的参考摄入量。
    #
    # @return [Dri]
    def chromium_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('0.2ug/d'))
        elsif @age < 1
          Dri.new(ai: un('4ug/d'))
        elsif @age < 4
          Dri.new(ai: un('15ug/d'))
        elsif @age < 7
          Dri.new(ai: un('20ug/d'))
        elsif @age < 11
          Dri.new(ai: un('25ug/d'))
        elsif @age < 14
          Dri.new(ai: un('30ug/d'))
        elsif @age < 18
          Dri.new(ai: un('35ug/d'))
        else
          Dri.new(ai: un('30ug/d'))
        end

      case @sex
      when :first_trimester
        dri.ai += un('1ug/d')
      when :second_trimester
        dri.ai += un('4ug/d')
      when :third_trimester
        dri.ai += un('6ug/d')
      when :lactation
        dri.ai += un('7ug/d')
      end

      dri
    end

    ##
    # 锰的参考摄入量。
    #
    # @return [Dri]
    def manganese_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('0.01mg/d'))
        elsif @age < 1
          Dri.new(ai: un('0.7mg/d'))
        elsif @age < 4
          Dri.new(ai: un('1.5mg/d'))
        elsif @age < 7
          Dri.new(ai: un('2mg/d'), ul: un('3.5mg/d'))
        elsif @age < 11
          Dri.new(ai: un('3mg/d'), ul: un('5mg/d'))
        elsif @age < 14
          Dri.new(ai: un('4mg/d'), ul: un('8mg/d'))
        elsif @age < 18
          Dri.new(ai: un('4.5mg/d'), ul: un('10mg/d'))
        else
          Dri.new(ai: un('4.5mg/d'), ul: un('11mg/d'))
        end
      dri.ai += un('0.4mg/d') if pregnancy?
      dri.ai += un('0.3mg/d') if lactation?
      dri
    end

    ##
    # 钼的参考摄入量。
    #
    # @return [Dri]
    def molybdenum_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('2ug/d'))
        elsif @age < 1
          Dri.new(ai: un('15ug/d'))
        elsif @age < 4
          Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
        elsif @age < 7
          Dri.new(ear: un('40ug/d'), rni: un('50ug/d'), ul: un('300ug/d'))
        elsif @age < 11
          Dri.new(ear: un('55ug/d'), rni: un('65ug/d'), ul: un('450ug/d'))
        elsif @age < 14
          Dri.new(ear: un('75ug/d'), rni: un('90ug/d'), ul: un('650ug/d'))
        elsif @age < 18
          Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('800ug/d'))
        else
          Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('900ug/d'))
        end

      if pregnancy?
        dri.ear += un('7ug/d')
        dri.rni += un('10ug/d')
      end

      if lactation?
        dri.ear += un('3ug/d')
        dri.rni += un('3ug/d')
      end

      dri
    end

    #---------------------------------------------------------------------------
    # 脂溶性维生素

    ##
    # 维生素 A 的参考摄入量。
    #
    # @return [Dri]
    def vitamin_a_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('300ug/d'), ul: un('600ug/d'))
        elsif @age < 1
          Dri.new(ai: un('350ug/d'), ul: un('600ug/d'))
        elsif @age < 4
          Dri.new(ear: un('220ug/d'), rni: un('310ug/d'), ul: un('700ug/d'))
        elsif @age < 7
          Dri.new(ear: un('260ug/d'), rni: un('360ug/d'), ul: un('900ug/d'))
        elsif @age < 11
          Dri.new(ear: un('360ug/d'), rni: un('500ug/d'), ul: un('1500ug/d'))
        elsif @age < 14 && male?
          Dri.new(ear: un('480ug/d'), rni: un('670ug/d'), ul: un('2100ug/d'))
        elsif @age < 14 && female?
          Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2100ug/d'))
        elsif @age < 18 && male?
          Dri.new(ear: un('590ug/d'), rni: un('820ug/d'), ul: un('2700ug/d'))
        elsif @age < 18 && female?
          Dri.new(ear: un('450ug/d'), rni: un('630ug/d'), ul: un('2700ug/d'))
        elsif male?
          Dri.new(ear: un('560ug/d'), rni: un('800ug/d'), ul: un('3000ug/d'))
        elsif female?
          Dri.new(ear: un('480ug/d'), rni: un('700ug/d'), ul: un('3000ug/d'))
        end

      case @sex
      when :second_trimester
        dri.ear += un('50ug/d')
        dri.rni += un('70ug/d')
      when :third_trimester
        dri.ear += un('50ug/d')
        dri.rni += un('70ug/d')
      when :lactation
        dri.ear += un('400ug/d')
        dri.rni += un('600ug/d')
      end

      dri
    end

    ##
    # 维生素 D 的参考摄入量。
    #
    # @return [Dri]
    def vitamin_d_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      if @age < 1
        Dri.new(ai: un('10ug/d'), ul: un('20ug/d'))
      elsif @age < 4
        Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('20ug/d'))
      elsif @age < 7
        Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('30ug/d'))
      elsif @age < 11
        Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('45ug/d'))
      elsif @age < 65
        Dri.new(ear: un('8ug/d'), rni: un('10ug/d'), ul: un('50ug/d'))
      else
        Dri.new(ear: un('8ug/d'), rni: un('15ug/d'), ul: un('50ug/d'))
      end
    end

    ##
    # 维生素 E 的参考摄入量。
    #
    # @return [Dri]
    def vitamin_e_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('3mg/d'))
        elsif @age < 1
          Dri.new(ai: un('4mg/d'))
        elsif @age < 4
          Dri.new(ai: un('6mg/d'), ul: un('150mg/d'))
        elsif @age < 7
          Dri.new(ai: un('7mg/d'), ul: un('200mg/d'))
        elsif @age < 11
          Dri.new(ai: un('9mg/d'), ul: un('350mg/d'))
        elsif @age < 14
          Dri.new(ai: un('13mg/d'), ul: un('500mg/d'))
        elsif @age < 18
          Dri.new(ai: un('14mg/d'), ul: un('600mg/d'))
        else
          Dri.new(ai: un('14mg/d'), ul: un('700mg/d'))
        end
      dri.ai += un('3ug/d') if lactation?
      dri
    end

    ##
    # 维生素 K 的参考摄入量。
    #
    # @return [Dri]
    def vitamin_k_dri # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      dri =
        if @age < 0.5
          Dri.new(ai: un('2ug/d'))
        elsif @age < 1
          Dri.new(ai: un('10ug/d'))
        elsif @age < 4
          Dri.new(ai: un('30ug/d'))
        elsif @age < 7
          Dri.new(ai: un('40ug/d'))
        elsif @age < 11
          Dri.new(ai: un('50ug/d'))
        elsif @age < 14
          Dri.new(ai: un('70ug/d'))
        elsif @age < 18
          Dri.new(ai: un('75ug/d'))
        else
          Dri.new(ai: un('80ug/d'))
        end
      dri.ai += un('5ug/d') if lactation?
      dri
    end

    #---------------------------------------------------------------------------
    # 水溶性维生素
  end
end
