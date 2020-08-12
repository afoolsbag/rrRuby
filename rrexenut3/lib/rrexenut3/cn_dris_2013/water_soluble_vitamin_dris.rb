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
    # 水溶性维生素的参考摄入量。
    #
    # 能在水中溶解的一类维生素，
    # 包括 B 族维生素（维生素 B-1、维生素 B-2、维生素 B-6、维生素 B-12、泛酸、叶酸、烟酸、胆碱、生物素）和维生素 C。
    module WaterSolubleVitaminDris
      include Aux

      protected

      ##
      # 硫胺素的参考摄入量。
      # DRI of Thiamine.
      #
      # 又名维生素 B-1。
      #
      # B 族维生素之一。在体内以焦磷酸硫胺素的形式构成丙酮酸脱氢酶、转酮醇酶、α-酮戊二酸脱氢酶等的辅酶参与能量代谢。
      # 维生素 B-1 缺乏可引起脚气病。
      #
      #   :THIA
      #
      # @return [Dri]
      def thia_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.1mg/d'))
          when 0.5...1
            Dri.new(ai: un('0.3mg/d'))
          when 1...4
            Dri.new(ear: un('0.5mg/d'), rni: un('0.6mg/d'))
          when 4...7
            Dri.new(ear: un('0.6mg/d'), rni: un('0.8mg/d'))
          when 7...11
            Dri.new(ear: un('0.8mg/d'), rni: un('1.0mg/d'))
          when 11...14
            male? ? Dri.new(ear: un('1.1mg/d'), rni: un('1.3mg/d')) : Dri.new(ear: un('1.0mg/d'), rni: un('1.1mg/d'))
          when 14...18
            male? ? Dri.new(ear: un('1.3mg/d'), rni: un('1.6mg/d')) : Dri.new(ear: un('1.1mg/d'), rni: un('1.3mg/d'))
          else
            male? ? Dri.new(ear: un('1.2mg/d'), rni: un('1.4mg/d')) : Dri.new(ear: un('1.0mg/d'), rni: un('1.2mg/d'))
          end

        if second_trimester?
          dri.ear += un('0.1mg/d')
          dri.rni += un('0.2mg/d')
        elsif third_trimester? || lactation?
          dri.ear += un('0.2mg/d')
          dri.rni += un('0.3mg/d')
        end

        dri
      end

      ##
      # 核黄素的参考摄入量。
      # DRI of Riboflavin.
      #
      # 又名维生素 B-2。
      #
      # B 族维生素之一。在体内以黄素腺嘌呤二核苷酸、黄素单核苷酸作为辅基与特定蛋白质结合，形成黄素蛋白，参与氧化还原反应和能量代谢。
      # 维生素 B-2 缺乏可引起口腔、皮肤和阴囊等部位的炎症。
      #
      #   :RIBF
      #
      # @return [Dri]
      def ribf_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.4mg/d'))
          when 0.5...1
            Dri.new(ai: un('0.5mg/d'))
          when 1...4
            Dri.new(ear: un('0.5mg/d'), rni: un('0.6mg/d'))
          when 4...7
            Dri.new(ear: un('0.6mg/d'), rni: un('0.7mg/d'))
          when 7...11
            Dri.new(ear: un('0.8mg/d'), rni: un('1.0mg/d'))
          when 11...14
            male? ? Dri.new(ear: un('1.1mg/d'), rni: un('1.3mg/d')) : Dri.new(ear: un('0.9mg/d'), rni: un('1.1mg/d'))
          when 14...18
            male? ? Dri.new(ear: un('1.3mg/d'), rni: un('1.5mg/d')) : Dri.new(ear: un('1.0mg/d'), rni: un('1.2mg/d'))
          else
            male? ? Dri.new(ear: un('1.2mg/d'), rni: un('1.4mg/d')) : Dri.new(ear: un('1.0mg/d'), rni: un('1.2mg/d'))
          end

        if second_trimester?
          dri.ear += un('0.1mg/d')
          dri.rni += un('0.2mg/d')
        elsif third_trimester? || lactation?
          dri.ear += un('0.2mg/d')
          dri.rni += un('0.3mg/d')
        end

        dri
      end

      ##
      # 烟酸的参考摄入量。
      # DRI of Niacin.
      #
      # 又名维生素 B-3。
      #
      # B 族维生素之一。包括烟酸、烟酰胺及其具有烟酸活性的衍生物。
      # 烟酸在体内构成烟酰胺腺嘌呤二核苷酸（辅酶 I）及烟酰胺腺嘌呤二核苷酸磷酸（辅酶 II），在生物氧化还原反应中作为辅酶起电子载体或递氢体作用。
      # 烟酸缺乏可引起癞皮病。
      # 烟酸过量可引起血管舒张、胃肠道反应和肝毒性等。
      #
      #   :NIA
      #
      # @return [Dri] 烟酸当量（Niacin Equivalents）
      def nia_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('2mg/d'))
          when 0.5...1
            Dri.new(ai: un('3mg/d'))
          when 1...4
            Dri.new(ear: un('5mg/d'), rni: un('6mg/d'), ul: un('10mg/d'))
          when 4...7
            male? ? Dri.new(ear: un('7mg/d'), rni: un('8mg/d'), ul: un('15mg/d')) : Dri.new(ear: un('6mg/d'), rni: un('8mg/d'), ul: un('15mg/d')) # rubocop:disable Layout/LineLength
          when 7...11
            male? ? Dri.new(ear: un('9mg/d'), rni: un('11mg/d'), ul: un('20mg/d')) : Dri.new(ear: un('8mg/d'), rni: un('10mg/d'), ul: un('20mg/d')) # rubocop:disable Layout/LineLength
          when 11...14
            male? ? Dri.new(ear: un('11mg/d'), rni: un('14mg/d'), ul: un('25mg/d')) : Dri.new(ear: un('10mg/d'), rni: un('12mg/d'), ul: un('25mg/d')) # rubocop:disable Layout/LineLength
          when 14...18
            male? ? Dri.new(ear: un('14mg/d'), rni: un('16mg/d'), ul: un('30mg/d')) : Dri.new(ear: un('11mg/d'), rni: un('13mg/d'), ul: un('30mg/d')) # rubocop:disable Layout/LineLength
          when 18...50
            male? ? Dri.new(ear: un('12mg/d'), rni: un('15mg/d'), ul: un('35mg/d')) : Dri.new(ear: un('10mg/d'), rni: un('12mg/d'), ul: un('35mg/d')) # rubocop:disable Layout/LineLength
          when 50...65
            male? ? Dri.new(ear: un('12mg/d'), rni: un('14mg/d'), ul: un('35mg/d')) : Dri.new(ear: un('10mg/d'), rni: un('12mg/d'), ul: un('35mg/d')) # rubocop:disable Layout/LineLength
          when 65...80
            male? ? Dri.new(ear: un('11mg/d'), rni: un('14mg/d'), ul: un('35mg/d')) : Dri.new(ear: un('9mg/d'), rni: un('11mg/d'), ul: un('35mg/d')) # rubocop:disable Layout/LineLength
          else
            male? ? Dri.new(ear: un('11mg/d'), rni: un('13mg/d'), ul: un('30mg/d')) : Dri.new(ear: un('8mg/d'), rni: un('10mg/d'), ul: un('30mg/d')) # rubocop:disable Layout/LineLength
          end

        if lactation?
          dri.ear += un('2mg/d')
          dri.rni += un('3mg/d')
        end

        dri
      end

      ##
      # 泛酸的参考摄入量。
      # DRI of Pantothenic Acid.
      #
      # 又名维生素 B-5。
      #
      # B 族维生素之一。辅酶 A 和酰基载体蛋白的组成部分。
      # 辅酶 A 参与糖、脂肪和蛋白质的代谢；酰基载体蛋白在脂肪酸合成时发挥作用。
      #
      #   :PANTAC
      #
      # @return [Dri]
      def pantac_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('1.7mg/d'))
          when 0.5...1
            Dri.new(ai: un('1.9mg/d'))
          when 1...4
            Dri.new(ai: un('2.1mg/d'))
          when 4...7
            Dri.new(ai: un('2.5mg/d'))
          when 7...11
            Dri.new(ai: un('3.5mg/d'))
          when 11...14
            Dri.new(ai: un('4.5mg/d'))
          else
            Dri.new(ai: un('5.0mg/d'))
          end
        dri.ai += un('1.0mg/d') if pregnancy?
        dri.ai += un('2.0mg/d') if lactation?
        dri
      end

      ##
      # 维生素 B-6 的参考摄入量。
      # DRI of Vitamin B-6.
      #
      # B 族维生素之一，包括吡哆醇、吡哆醛及吡哆胺。
      # 其磷酸化形式是氨基酸代谢过程中转氨酶等的辅酶。
      # 维生素 B-6 缺乏可引起末梢神经炎、唇炎、舌炎、皮脂溢出和小细胞性贫血等。
      # 维生素 B-6 过量可引起感觉神经疾患和光敏感反应等。
      #
      #   :'VITB6-'
      #
      # @return [Dri]
      def vitb6_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.2mg/d'))
          when 0.5...1
            Dri.new(ai: un('0.4mg/d'))
          when 1...4
            Dri.new(ear: un('0.5mg/d'), rni: un('0.6mg/d'), ul: un('20mg/d'))
          when 4...7
            Dri.new(ear: un('0.6mg/d'), rni: un('0.7mg/d'), ul: un('25mg/d'))
          when 7...11
            Dri.new(ear: un('0.8mg/d'), rni: un('1.0mg/d'), ul: un('35mg/d'))
          when 11...14
            Dri.new(ear: un('1.1mg/d'), rni: un('1.3mg/d'), ul: un('45mg/d'))
          when 14...18
            Dri.new(ear: un('1.2mg/d'), rni: un('1.4mg/d'), ul: un('55mg/d'))
          when 18...50
            Dri.new(ear: un('1.2mg/d'), rni: un('1.4mg/d'), ul: un('60mg/d'))
          else
            Dri.new(ear: un('1.3mg/d'), rni: un('1.6mg/d'), ul: un('60mg/d'))
          end

        if pregnancy?
          dri.ear += un('0.7mg/d')
          dri.rni += un('0.8mg/d')
        elsif lactation?
          dri.ear += un('0.2mg/d')
          dri.rni += un('0.3mg/d')
        end

        dri
      end

      ##
      # 生物素的参考摄入量。
      # DRI of Biotin.
      #
      # 又名维生素 B-7。
      #
      # B 族维生素之一。在脂肪和糖代谢中以辅酶形式参与体内羧基转运过程。膳食缺乏比较少见。
      #
      #   :BIOT
      #
      # @return [Dri]
      def biot_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('5ug/d'))
          when 0.5...1
            Dri.new(ai: un('9ug/d'))
          when 1...4
            Dri.new(ai: un('17ug/d'))
          when 4...7
            Dri.new(ai: un('20ug/d'))
          when 7...11
            Dri.new(ai: un('25ug/d'))
          when 11...14
            Dri.new(ai: un('35ug/d'))
          else
            Dri.new(ai: un('40ug/d'))
          end
        dri.ai += un('10ug/d') if lactation?
        dri
      end

      ##
      # 叶酸的参考摄入量。
      # DRI of Folate.
      #
      # 又名维生素 B-9。
      #
      # B 族维生素之一。其辅酶形式是四氢叶酸的一些衍生物，在一碳单位代谢中发挥作用。
      # 叶酸缺乏可引起巨幼红细胞贫血，在妇女围孕期可导致胎儿神经管畸形、唇腭裂等出生缺陷。
      # 叶酸过量可掩盖维生素 B-12 缺乏的早期表现，干扰锌吸收和抗惊厥药物的作用等。
      #
      #   :FOL
      #
      # @return [Dri]
      def fol_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('65ug/d'))
          when 0.5...1
            Dri.new(ai: un('100ug/d'))
          when 1...4
            Dri.new(ear: un('130ug/d'), rni: un('160ug/d'), ul: un('300ug/d'))
          when 4...7
            Dri.new(ear: un('150ug/d'), rni: un('190ug/d'), ul: un('400ug/d'))
          when 7...11
            Dri.new(ear: un('210ug/d'), rni: un('250ug/d'), ul: un('600ug/d'))
          when 11...14
            Dri.new(ear: un('290ug/d'), rni: un('350ug/d'), ul: un('800ug/d'))
          when 14...18
            Dri.new(ear: un('320ug/d'), rni: un('400ug/d'), ul: un('900ug/d'))
          else
            Dri.new(ear: un('320ug/d'), rni: un('400ug/d'), ul: un('1000ug/d'))
          end

        if pregnancy?
          dri.ear += un('200ug/d')
          dri.rni += un('200ug/d')
        elsif lactation?
          dri.ear += un('130ug/d')
          dri.rni += un('150ug/d')
        end

        dri
      end

      ##
      # 维生素 B-12 的参考摄入量。
      # DRI of Vitamin B-12.
      #
      # B 族维生素之一。其辅酶形式是甲基钴胺素和腺苷钴胺素，参与核酸与红细胞生成。
      # 维生素 B-12 缺乏可引起巨幼红细胞贫血等。
      #
      #   :VITB12
      #
      # @return [Dri]
      def vitb12_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.3ug/d'))
          when 0.5...1
            Dri.new(ai: un('0.6ug/d'))
          when 1...4
            Dri.new(ear: un('0.8ug/d'), rni: un('1.0ug/d'))
          when 4...7
            Dri.new(ear: un('1.0ug/d'), rni: un('1.2ug/d'))
          when 7...11
            Dri.new(ear: un('1.3ug/d'), rni: un('1.6ug/d'))
          when 11...14
            Dri.new(ear: un('1.8ug/d'), rni: un('2.1ug/d'))
          else
            Dri.new(ear: un('2.0ug/d'), rni: un('2.4ug/d'))
          end

        if pregnancy?
          dri.ear += un('0.4ug/d')
          dri.rni += un('0.5ug/d')
        elsif lactation?
          dri.ear += un('0.6ug/d')
          dri.rni += un('0.8ug/d')
        end

        dri
      end

      ##
      # 胆碱的参考摄入量。
      # DRI of Choline.
      #
      # B 族维生素之一。是一种有机碱，为磷脂酰胆碱和神经鞘磷脂的组成成分，参与甲基供体的合成与代谢，是神经递质乙酰胆碱的前体。
      # 胆碱缺乏可引起肝脏脂肪变性。
      # 胆碱过量可引起呕吐、流涎、出汗、鱼腥体臭以及胃肠道不适等。
      #
      #   :CHOLN
      #
      # @return [Dri]
      def choln_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('120mg/d'))
          when 0.5...1
            Dri.new(ai: un('150mg/d'))
          when 1...4
            Dri.new(ai: un('200mg/d'), ul: un('1000mg/d'))
          when 4...7
            Dri.new(ai: un('250mg/d'), ul: un('1000mg/d'))
          when 7...11
            Dri.new(ai: un('300mg/d'), ul: un('1500mg/d'))
          when 11...14
            Dri.new(ai: un('400mg/d'), ul: un('2000mg/d'))
          when 14...18
            male? ? Dri.new(ai: un('500mg/d'), ul: un('2500mg/d')) : Dri.new(ai: un('400mg/d'), ul: un('2500mg/d'))
          else
            male? ? Dri.new(ai: un('500mg/d'), ul: un('3000mg/d')) : Dri.new(ai: un('400mg/d'), ul: un('3000mg/d'))
          end
        dri.ai += un('20mg/d') if pregnancy?
        dri.ai += un('120mg/d') if lactation?
        dri
      end

      ##
      # 维生素 C 的参考摄入量。
      # DRI of Vitamin C.
      #
      # 在体内参与氧化还原反应和羟化反应。
      # 维生素 C 缺乏可引起坏血病。
      # 维生素 C 过量可引起尿草酸盐排泄量增加，增加泌尿系结石形成的危险。
      #
      #   :VITC
      #
      # @return [Dri]
      def vitc_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('40mg/d'))
          when 0.5...1
            Dri.new(ai: un('40mg/d'))
          when 1...4
            Dri.new(ear: un('35mg/d'), rni: un('40mg/d'), ul: un('400mg/d'))
          when 4...7
            Dri.new(ear: un('40mg/d'), rni: un('50mg/d'), ul: un('600mg/d'))
          when 7...11
            Dri.new(ear: un('55mg/d'), rni: un('65mg/d'), ul: un('1000mg/d'))
          when 11...14
            Dri.new(ear: un('75mg/d'), rni: un('90mg/d'), ul: un('1400mg/d'))
          when 14...18
            Dri.new(ear: un('85mg/d'), rni: un('100mg/d'), ul: un('1800mg/d'))
          else
            Dri.new(ear: un('85mg/d'), rni: un('100mg/d'), pi: un('200mg/d'), ul: un('2000mg/d'))
          end

        if second_trimester? || third_trimester?
          dri.ear += un('10mg/d')
          dri.rni += un('15mg/d')
        elsif lactation?
          dri.ear += un('40mg/d')
          dri.rni += un('50mg/d')
        end

        dri
      end
    end
  end
end
