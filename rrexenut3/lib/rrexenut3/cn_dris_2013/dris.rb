#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-07 – 2020-08-28
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'ruby-units'
$VERBOSE = old

require 'rrexenut3/cn_dris_2013/dris_part_1'
require 'rrexenut3/cn_dris_2013/dris_part_2'
require 'rrexenut3/cn_dris_2013/dris_part_3'
require 'rrexenut3/cn_dris_2013/dris_part_4'
require 'rrexenut3/cn_dris_2013/dris_part_5'
require 'rrexenut3/cn_dris_2013/dris_part_6'
require 'rrexenut3/cn_dris_2013/dris_part_7'
require 'rrexenut3/cn_dris_2013/dris_part_8'
require 'rrexenut3/cn_dris_2013/dris_part_9'

module RrExeNut3
  module CnDris2013
    ##
    # 参考摄入量。
    class Dris
      SEX_VALID_VALUES = %i[male female first_trimester second_trimester third_trimester lactation].freeze
      LIFESTYLE_VALID_VALUES = %i[rest sedentary handicraft light_labor heavy_labor].freeze
      BOOLEAN_VALID_VALUES = [true, false].freeze

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
      # @param sex [Symbol, #to_sym] 生理性别、孕期或哺乳期
      # @param age [Unit, #to_unit] 年龄
      # @param weight [Unit, #to_unit] 体重
      # @param lifestyle [Symbol, #to_sym] 生活方式
      # @param extra_exercise [Boolean] 额外运动
      # @return [void]
      #--
      # rubocop:disable Layout/LineLength
      #++
      def initialize(sex:, age:, weight:,
                     lifestyle: :sedentary, extra_exercise: false)
        sex = sex.to_sym unless sex.is_a?(Symbol)
        age = age.to_unit unless age.is_a?(Unit)
        weight = weight.to_unit unless weight.is_a?(Unit)
        lifestyle = lifestyle.to_sym unless lifestyle.is_a?(Symbol)

        raise ArgumentError, "Unexpected sex argument: #{sex}" unless SEX_VALID_VALUES.include?(sex)
        raise ArgumentError, "Unexpected age argument: #{age}" unless age.kind == :time
        raise ArgumentError, "Unexpected weight argument: #{weight}" unless weight.kind == :mass
        raise ArgumentError, "Unexpected lifestyle argument: #{lifestyle}" unless LIFESTYLE_VALID_VALUES.include?(lifestyle)
        raise ArgumentError, "Unexpected extra_exercise argument: #{extra_exercise}" unless BOOLEAN_VALID_VALUES.include?(extra_exercise)

        @sex = sex
        @age = age.convert_to('yr')
        @weight = weight.convert_to('kg')
        @lifestyle = lifestyle
        @extra_exercise = extra_exercise
      end

      # rubocop:enable Layout/LineLength

      include DrisPart1
      include DrisPart2
      include DrisPart3
      include DrisPart4
      include DrisPart5
      include DrisPart6
      include DrisPart7
      include DrisPart8
      include DrisPart9

      # 以下注释未及时更新，仅作参考，以实际代码为准：
      #
      #   Energy
      #     ENER-:                <EER ?kcal/d>
      #   Proteins and Amino Acids
      #     PRO-:   <EAR ?g/d>    <RNI ?g/d>
      #   Lipids
      #     FAT:    <LAMDR ?%>                               <UAMDR ?%>
      #     SFA:                                             <UAMDR ?%>
      #     N6PUFA: <LAMDR ?%>                               <UAMDR ?%>
      #     LA:                   <AI ?%>
      #     N3PUFA: <LAMDR ?%>                               <UAMDR ?%>
      #     ALA:                  <AI ?%>
      #   Carbohydrates
      #     CHO-:   <LAMDR ?%>    <EAR ?g/d>                 <UAMDR ?%>
      #     SUGAR:                                           <UAMDR ?%>
      #   Macro Minerals
      #     CA:     <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     P:      <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     MG:     <EAR ?mg/d>   <RNI ?mg/d>
      #     K:                    <AI ?mg/d>    <PI ?mg/d>
      #     NA:                   <AI ?mg/d>    <PI ?mg/d>
      #     CLD:                  <AI ?mg/d>
      #   Trace Minerals
      #     FE:     <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     ID:     <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     ZN:     <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     SE:     <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     CU:     <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     MO:     <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     CR:                   <AI ?ug/d>
      #     MN:                   <AI ?mg/d>
      #     FD:                   <AI ?mg/d>
      #   Lipid-soluble Vitamins
      #     VITA-:  <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     VITD-:  <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     VITE-:                <AI ?mg/d>                 <UL ?mg/d>
      #     VITK:                 <AI ?ug/d>
      #   Water-soluble Vitamins
      #     THIA:   <EAR ?mg/d>   <RNI ?mg/d>
      #     RIBF:   <EAR ?mg/d>   <RNI ?mg/d>
      #     NIA:    <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     PANTAC:               <AI ?mg/d>
      #     VITB6-: <EAR ?mg/d>   <RNI ?mg/d>                <UL ?mg/d>
      #     BIOT:                 <AI ?ug/d>
      #     FOL:    <EAR ?ug/d>   <RNI ?ug/d>                <UL ?ug/d>
      #     VITB12: <EAR ?ug/d>   <RNI ?ug/d>
      #     CHOLN:                <AI ?mg/d>                 <UL ?mg/d>
      #     VITC:   <EAR ?mg/d>   <RNI ?mg/d>   <PI ?mg/d>   <UL ?mg/d>
      #   Non-nutrient Diet Components
      #     WATER:                <AI ?L/d>
      #     FIB-:                 <AI ?g/d>
      #     PA:                                              <UL ?mg/d>
      #     ANC:                  <SPL ?mg/d>
      #     CUR:                                             <UL ?mg/d>
      #     LYCPN:                <SPL ?mg/d>                <UL ?mg/d>
      #     LUTN:                 <SPL ?mg/d>                <UL ?mg/d>
      #     PHYSTR:               <SPL ?g/d>                 <UL ?g/d>
      #     GLCN:                 <SPL ?mg/d>
      #
      # @return [Array<String, Array<(Symbol, Symbol)>>]
      TAGNAME_DRINAME_MAPPING = [
        'Energy',
        %i[ENER- ener_dri],
        %i[ENERC ener_dri],
        'Proteins and Amino Acids',
        %i[PRO- prot_dri],
        %i[PROCNT prot_dri],
        'Lipids',
        %i[FAT fat_dri],
        %i[FASAT sfa_dri],
        %i[FAPUN6 n6pufa_dri],
        %i[F18D2CN6 la_dri],
        %i[F20D4 ara_dri],
        %i[FAPUN3 n3pufa_dri],
        %i[F18D3N3 alac_dri],
        %i[F20D5N3 epa_dri],
        %i[F22D6N3 dha_dri],
        'Carbohydrates',
        %i[CHO- cho_dri],
        %i[CHOCDF cho_dri],
        %i[SUGAR sugar_dri],
        'Macro Minerals',
        %i[CA ca_dri],
        %i[P p_dri],
        %i[MG mg_dri],
        %i[K k_dri],
        %i[NA na_dri],
        %i[CLD cld_dri],
        'Trace Minerals',
        %i[FE fe_dri],
        %i[ID id_dri],
        %i[ZN zn_dri],
        %i[SE se_dri],
        %i[CU cu_dri],
        %i[MO mo_dri],
        %i[CR cr_dri],
        %i[MN mn_dri],
        %i[FD fd_dri],
        'Lipid-soluble Vitamins',
        %i[VITA- vita_dri],
        %i[VITA vita_dri],
        %i[VITD- vitd_dri],
        %i[VITE- vite_dri],
        %i[VITE vite_dri],
        %i[VITK vitk_dri],
        'Water-soluble Vitamins',
        %i[THIA thia_dri],
        %i[RIBF ribf_dri],
        %i[NIA nia_dri],
        %i[PANTAC pantac_dri],
        %i[VITB6- vitb6_dri],
        %i[BIOT biot_dri],
        %i[FOL fol_dri],
        %i[VITB12 vitb12_dri],
        %i[CHOLN choln_dri],
        %i[VITC vitc_dri],
        'Non-nutrient Diet Components',
        %i[WATER water_dri],
        %i[FIB- fib_dri],
        %i[FIBTG fib_dri],
        %i[LYCPN lycpn_dri],
        %i[LUTN lutn_dri],
        %i[PHYSTR phystr_dri]
      ].freeze
    end
  end
end
