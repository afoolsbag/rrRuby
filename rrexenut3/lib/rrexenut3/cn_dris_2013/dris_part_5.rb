#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-12 – 2020-08-28
# Unlicense

require 'rrexenut3/cn_dris_2013/dri'
require 'rrexenut3/cn_dris_2013/dris_aux'

module RrExeNut3
  module CnDris2013
    ##
    # 参考摄入量第五部分：宏量矿物质。
    # DRIs Part 5: Macro Minerals.
    #
    # 在人体内的含量大于 0.01% 体重的矿物质。
    # 包括钾、钠、钙、镁、硫、磷、氯等，都是人体必需的微量营养素。
    module DrisPart5
      include DrisAux

      ##
      # 钙的参考摄入量。
      # DRI of Calcium.
      #
      # 人体必需常量元素之一。骨骼和牙齿的主要构成成分。维持神经肌肉的正常兴奋性；参与调节和维持细胞功能、体液酸碱平衡；参与血液凝固、激素分泌。
      # 长期缺钙可致儿童佝偻病；中老年人骨质软化症。
      # 长期摄入过量可增加患肾结石的风险。
      #
      #   :CA
      #
      # @return [Dri]
      def ca_dri
        dri =
          case @age.scalar
          when 0...0.5
            Dri.new(ai: un('200mg/d'), ul: un('1000mg/d'))
          when 0.5...1
            Dri.new(ai: un('250mg/d'), ul: un('1500mg/d'))
          when 1...4
            Dri.new(ear: un('500mg/d'), rni: un('600mg/d'), ul: un('1500mg/d'))
          when 4...7
            Dri.new(ear: un('650mg/d'), rni: un('800mg/d'), ul: un('2000mg/d'))
          when 7...11
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          when 11...14
            Dri.new(ear: un('1000mg/d'), rni: un('1200mg/d'), ul: un('2000mg/d'))
          when 14...18
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          when 18...50
            Dri.new(ear: un('650mg/d'), rni: un('800mg/d'), ul: un('2000mg/d'))
          else
            Dri.new(ear: un('800mg/d'), rni: un('1000mg/d'), ul: un('2000mg/d'))
          end

        if second_trimester? || third_trimester? || lactation?
          dri.ear += un('160mg/d')
          dri.rni += un('200mg/d')
        end

        dri
      end

      ##
      # 磷的参考摄入量。
      # DRI of Phosphorus.
      #
      # 人体必需常量元素之一。与钙结合构成骨骼和牙齿；参与物质代谢，维持机体的酸碱平衡。
      # 正常饮食可获得足够的磷。
      #
      #   :P
      #
      # @return [Dri]
      def p_dri
        dri =
          case @age.scalar
          when 0...0.5
            Dri.new(ai: un('100mg/d'))
          when 0.5...1
            Dri.new(ai: un('180mg/d'))
          when 1...4
            Dri.new(ear: un('250mg/d'), rni: un('300mg/d'))
          when 4...7
            Dri.new(ear: un('290mg/d'), rni: un('350mg/d'))
          when 7...11
            Dri.new(ear: un('400mg/d'), rni: un('470mg/d'))
          when 11...14
            Dri.new(ear: un('540mg/d'), rni: un('640mg/d'))
          when 14...18
            Dri.new(ear: un('590mg/d'), rni: un('710mg/d'))
          when 18...65
            Dri.new(ear: un('600mg/d'), rni: un('720mg/d'), ul: un('3500mg/d'))
          when 65...80
            Dri.new(ear: un('590mg/d'), rni: un('700mg/d'), ul: un('3000mg/d'))
          else
            Dri.new(ear: un('560mg/d'), rni: un('670mg/d'), ul: un('3000mg/d'))
          end
        dri.ul = un('3500mg/d') if pregnancy_or_lactation?
        dri
      end

      ##
      # 镁的参考摄入量。
      # DRI of Magnesium.
      #
      # 人体必需常量元素之一。是多种酶的激活剂。具有调节细胞钾、钠分布，维持骨骼生长和神经肌肉兴奋性等功能。
      #
      #   :MG
      #
      # @return [Dri]
      def mg_dri
        dri =
          case @age.scalar
          when 0...0.5
            Dri.new(ai: un('20mg/d'))
          when 0.5...1
            Dri.new(ai: un('65mg/d'))
          when 1...4
            Dri.new(ear: un('110mg/d'), rni: un('140mg/d'))
          when 4...7
            Dri.new(ear: un('130mg/d'), rni: un('160mg/d'))
          when 7...11
            Dri.new(ear: un('180mg/d'), rni: un('220mg/d'))
          when 11...14
            Dri.new(ear: un('250mg/d'), rni: un('300mg/d'))
          when 14...18
            Dri.new(ear: un('270mg/d'), rni: un('320mg/d'))
          when 18...65
            Dri.new(ear: un('280mg/d'), rni: un('330mg/d'))
          when 65...80
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
      # 钾的参考摄入量。
      # DRI of Potassium.
      #
      # 人体必需常量元素之一。参与糖、蛋白质的代谢，维持正常渗透压和酸碱平衡、神经肌肉的兴奋性等。
      # 钾缺乏可引起神经肌肉、心血管、中枢神经发生功能性或病理性改变。
      #
      #   :K
      #
      # @return [Dri]
      def k_dri
        dri =
          case @age.scalar
          when 0...0.5
            Dri.new(ai: un('350mg/d'))
          when 0.5...1
            Dri.new(ai: un('550mg/d'))
          when 1...4
            Dri.new(ai: un('900mg/d'))
          when 4...7
            Dri.new(ai: un('1200mg/d'), pi: un('2100mg/d'))
          when 7...11
            Dri.new(ai: un('1500mg/d'), pi: un('2800mg/d'))
          when 11...14
            Dri.new(ai: un('1900mg/d'), pi: un('3400mg/d'))
          when 14...18
            Dri.new(ai: un('2200mg/d'), pi: un('3900mg/d'))
          else
            Dri.new(ai: un('2000mg/d'), pi: un('3600mg/d'))
          end
        dri.ai += un('400mg/d') if lactation?
        dri
      end

      ##
      # 钠的参考摄入量。
      # DRI of Sodium.
      #
      # 人体必需常量元素之一。调节细胞外液的容量与渗透压，维持酸碱平衡及维持神经肌肉兴奋性。
      # 摄钠过多是高血压原因之一。
      #
      #   :NA
      #
      # @return [Dri]
      def na_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('170mg/d'))
        when 0.5...1
          Dri.new(ai: un('350mg/d'))
        when 1...4
          Dri.new(ai: un('700mg/d'))
        when 4...7
          Dri.new(ai: un('900mg/d'), pi: un('1200mg/d'))
        when 7...11
          Dri.new(ai: un('1200mg/d'), pi: un('1500mg/d'))
        when 11...14
          Dri.new(ai: un('1400mg/d'), pi: un('1900mg/d'))
        when 14...18
          Dri.new(ai: un('1600mg/d'), pi: un('2200mg/d'))
        when 18...50
          Dri.new(ai: un('1500mg/d'), pi: un('2000mg/d'))
        when 50...65
          Dri.new(ai: un('1400mg/d'), pi: un('1900mg/d'))
        when 65...80
          Dri.new(ai: un('1400mg/d'), pi: un('1800mg/d'))
        else
          Dri.new(ai: un('1300mg/d'), pi: un('1700mg/d'))
        end
      end

      ##
      # 氯的参考摄入量。
      # DRI of Chloride.
      #
      # 人体必需常量元素之一。调节细胞外液的容量与渗透压，维持酸碱平衡，参与血液二氧化碳运输等。
      #
      #   :CLD
      #
      # @return [Dri]
      def cld_dri
        case @age.scalar
        when 0...0.5
          Dri.new(ai: un('260mg/d'))
        when 0.5...1
          Dri.new(ai: un('550mg/d'))
        when 1...4
          Dri.new(ai: un('1100mg/d'))
        when 4...7
          Dri.new(ai: un('1400mg/d'))
        when 7...11
          Dri.new(ai: un('1900mg/d'))
        when 11...14
          Dri.new(ai: un('2200mg/d'))
        when 14...18
          Dri.new(ai: un('2500mg/d'))
        when 18...50
          Dri.new(ai: un('2300mg/d'))
        when 50...80
          Dri.new(ai: un('2200mg/d'))
        else
          Dri.new(ai: un('2000mg/d'))
        end
      end

      ##
      # 硫的参考摄入量。
      # DRI of Sulfur.
      #
      #   :S
      #
      # @return [Dri]
      def s_dri; end
    end
  end
end
