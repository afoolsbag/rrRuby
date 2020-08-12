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
    # 痕量矿物质的参考摄入量。
    #
    # 在人体内的含量小于 0.01% 体重的矿物质。分为三类：
    # 第一类为人体必需的微量元素，有铁、碘、锌、硒、铜、钼、铬、钴 8 种；
    # 第二类为人体可能必需的微量元素，有锰、硅、镍、硼、钒 5 种；
    # 第三类为具有潜在毒性，但在低剂量时，对人体可能是有益的微量元素，包括氟、铅、镉、汞、砷、铝、锂、锡 8 种。
    module TraceMineralDris
      include Aux

      protected

      # 人体必须的微量元素

      ##
      # 铁的参考摄入量。
      # DRI of Iron.
      #
      # 人体必需微量元素之一。是体内血红素和铁硫基团的成分与原料，参与体内氧的运送和组织呼吸过程，维持正常的造血功能。
      # 缺乏时可影响血红蛋白的合成，发生缺铁性贫血。
      # 铁过量可导致腹泻等胃肠道不良反应。
      #
      #   :FE
      #
      # @return [Dri]
      def fe_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.3mg/d'))
          when 0.5...1
            Dri.new(ear: un('7mg/d'), rni: un('10mg/d'))
          when 1...4
            Dri.new(ear: un('6mg/d'), rni: un('9mg/d'), ul: un('25mg/d'))
          when 4...7
            Dri.new(ear: un('7mg/d'), rni: un('10mg/d'), ul: un('30mg/d'))
          when 7...11
            Dri.new(ear: un('10mg/d'), rni: un('13mg/d'), ul: un('35mg/d'))
          when 11...14
            male? ? Dri.new(ear: un('11mg/d'), rni: un('15mg/d'), ul: un('40mg/d')) : Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d')) # rubocop:disable Layout/LineLength
          when 14...18
            male? ? Dri.new(ear: un('12mg/d'), rni: un('16mg/d'), ul: un('40mg/d')) : Dri.new(ear: un('14mg/d'), rni: un('18mg/d'), ul: un('40mg/d')) # rubocop:disable Layout/LineLength
          when 18...50
            male? ? Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d')) : Dri.new(ear: un('15mg/d'), rni: un('20mg/d'), ul: un('42mg/d')) # rubocop:disable Layout/LineLength
          else
            Dri.new(ear: un('9mg/d'), rni: un('12mg/d'), ul: un('42mg/d'))
          end

        if second_trimester?
          dri.ear += un('4mg/d')
          dri.rni += un('4mg/d')
        elsif third_trimester?
          dri.ear += un('7mg/d')
          dri.rni += un('9mg/d')
        elsif lactation?
          dri.ear += un('3mg/d')
          dri.rni += un('4mg/d')
        end

        dri
      end

      ##
      # 碘的参考摄入量。
      # DRI of Iodine.
      #
      # 人体必需微量元素之一。合成甲状腺激素的成分。
      # 摄入不足可引起碘缺乏病。
      # 长期过量摄入可导致高碘性甲状腺肿等危害。
      #
      #   :ID
      #
      # @return [Dri]
      def id_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('85ug/d'))
          when 0.5...1
            Dri.new(ai: un('115ug/d'))
          when 1...4
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'))
          when 4...7
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('200ug/d'))
          when 7...11
            Dri.new(ear: un('65ug/d'), rni: un('90ug/d'), ul: un('300ug/d'))
          when 11...14
            Dri.new(ear: un('75ug/d'), rni: un('110ug/d'), ul: un('400ug/d'))
          when 14...18
            Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('500ug/d'))
          else
            Dri.new(ear: un('85ug/d'), rni: un('120ug/d'), ul: un('600ug/d'))
          end

        if pregnancy?
          dri.ear += un('75ug/d')
          dri.rni += un('110ug/d')
        elsif lactation?
          dri.ear += un('85ug/d')
          dri.rni += un('120ug/d')
        end

        dri
      end

      ##
      # 锌的参考摄入量。
      # DRI of Zinc.
      #
      # 人体必需微量元素之一。参与体内多种酶的组成，具有催化、结构和调节功能。
      # 锌缺乏可引起味觉障碍、生长发育不良、皮肤损害和免疫功能损伤等。
      #
      #   :ZN
      #
      # @return [Dri]
      def zn_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('2.0mg/d'))
          when 0.5...1
            Dri.new(ear: un('2.8mg/d'), rni: un('3.5mg/d'))
          when 1...4
            Dri.new(ear: un('3.2mg/d'), rni: un('4.0mg/d'), ul: un('8mg/d'))
          when 4...7
            Dri.new(ear: un('4.6mg/d'), rni: un('5.5mg/d'), ul: un('12mg/d'))
          when 7...11
            Dri.new(ear: un('5.9mg/d'), rni: un('7.0mg/d'), ul: un('19mg/d'))
          when 11...14
            male? ? Dri.new(ear: un('8.2mg/d'), rni: un('10.0mg/d'), ul: un('28mg/d')) : Dri.new(ear: un('7.6mg/d'), rni: un('9.0mg/d'), ul: un('28mg/d')) # rubocop:disable Layout/LineLength
          when 14...18
            male? ? Dri.new(ear: un('9.7mg/d'), rni: un('11.5mg/d'), ul: un('35mg/d')) : Dri.new(ear: un('6.9mg/d'), rni: un('8.5mg/d'), ul: un('35mg/d')) # rubocop:disable Layout/LineLength
          else
            male? ? Dri.new(ear: un('10.4mg/d'), rni: un('12.5mg/d'), ul: un('40mg/d')) : Dri.new(ear: un('6.1mg/d'), rni: un('7.5mg/d'), ul: un('40mg/d')) # rubocop:disable Layout/LineLength
          end

        if pregnancy?
          dri.ear += un('1.7mg/d')
          dri.rni += un('2.0mg/d')
        elsif lactation?
          dri.ear += un('3.8mg/d')
          dri.rni += un('4.5mg/d')
        end

        dri
      end

      ##
      # 硒的参考摄入量。
      # DRI of Selenium.
      #
      # 人体必需微量元素之一。以含硒氨基酸掺入谷胱甘肽过氧化物酶等蛋白肽链的一级结构，参与机体的抗氧化。
      # 硒缺乏是克山病发病的重要危险因素。
      #
      #   :SE
      #
      # @return [Dri]
      def se_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('15ug/d'), ul: un('55ug/d'))
          when 0.5...1
            Dri.new(ai: un('20ug/d'), ul: un('80ug/d'))
          when 1...4
            Dri.new(ear: un('20ug/d'), rni: un('25ug/d'), ul: un('100ug/d'))
          when 4...7
            Dri.new(ear: un('25ug/d'), rni: un('30ug/d'), ul: un('150ug/d'))
          when 7...11
            Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
          when 11...14
            Dri.new(ear: un('45ug/d'), rni: un('55ug/d'), ul: un('300ug/d'))
          when 14...18
            Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('350ug/d'))
          else
            Dri.new(ear: un('50ug/d'), rni: un('60ug/d'), ul: un('400ug/d'))
          end

        if pregnancy?
          dri.ear += un('4ug/d')
          dri.rni += un('5ug/d')
        elsif lactation?
          dri.ear += un('15ug/d')
          dri.rni += un('18ug/d')
        end

        dri
      end

      ##
      # 铜的参考摄入量。
      # DRI of Copper.
      #
      # 人体必需微量元素之一。参与铜蛋白和多种酶的构成。
      # 缺乏时可发生小细胞低色素性贫血。
      #
      #   :CU
      #
      # @return [Dri]
      def cu_dri
        dri =
          case @age
          when 0...1
            Dri.new(ai: un('0.3mg/d'))
          when 1...4
            Dri.new(ear: un('0.25mg/d'), rni: un('0.3mg/d'), ul: un('2.0mg/d'))
          when 4...7
            Dri.new(ear: un('0.30mg/d'), rni: un('0.4mg/d'), ul: un('3.0mg/d'))
          when 7...11
            Dri.new(ear: un('0.40mg/d'), rni: un('0.5mg/d'), ul: un('4.0mg/d'))
          when 11...14
            Dri.new(ear: un('0.55mg/d'), rni: un('0.7mg/d'), ul: un('6.0mg/d'))
          when 14...18
            Dri.new(ear: un('0.60mg/d'), rni: un('0.8mg/d'), ul: un('7.0mg/d'))
          else
            Dri.new(ear: un('0.60mg/d'), rni: un('0.8mg/d'), ul: un('8.0mg/d'))
          end

        if pregnancy?
          dri.ear += un('0.10mg/d')
          dri.rni += un('0.1mg/d')
        elsif lactation?
          dri.ear += un('0.50mg/d')
          dri.rni += un('0.6mg/d')
        end

        dri
      end

      ##
      # 钼的参考摄入量。
      # DRI of Molybdenum.
      #
      # 人体必需微量元素之一。是黄嘌呤氧化酶、黄嘌呤脱氢酶、醛氧化酶和亚硫酸盐氧化酶的组成成分。
      # 在正常膳食条件下人体不易发生钼缺乏。
      #
      #   :MO
      #
      # @return [Dri]
      def mo_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('2ug/d'))
          when 0.5...1
            Dri.new(ai: un('15ug/d'))
          when 1...4
            Dri.new(ear: un('35ug/d'), rni: un('40ug/d'), ul: un('200ug/d'))
          when 4...7
            Dri.new(ear: un('40ug/d'), rni: un('50ug/d'), ul: un('300ug/d'))
          when 7...11
            Dri.new(ear: un('55ug/d'), rni: un('65ug/d'), ul: un('450ug/d'))
          when 11...14
            Dri.new(ear: un('75ug/d'), rni: un('90ug/d'), ul: un('650ug/d'))
          when 14...18
            Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('800ug/d'))
          else
            Dri.new(ear: un('85ug/d'), rni: un('100ug/d'), ul: un('900ug/d'))
          end

        if pregnancy?
          dri.ear += un('7ug/d')
          dri.rni += un('10ug/d')
        elsif lactation?
          dri.ear += un('3ug/d')
          dri.rni += un('3ug/d')
        end

        dri
      end

      ##
      # 铬的参考摄入量。
      # DRI of Chromium.
      #
      # 人体必需微量元素之一。天然食品和生物体中的铬主要为三价铬，是葡萄糖耐量因子的重要构成成分、某些酶的激活剂。
      # 铬摄入不足可引起糖、脂代谢紊乱等。
      #
      #   :CR
      #
      # @return [Dri]
      def cr_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.2ug/d'))
          when 0.5...1
            Dri.new(ai: un('4.0ug/d'))
          when 1...4
            Dri.new(ai: un('15ug/d'))
          when 4...7
            Dri.new(ai: un('20ug/d'))
          when 7...11
            Dri.new(ai: un('25ug/d'))
          when 11...14
            Dri.new(ai: un('30ug/d'))
          when 14...18
            Dri.new(ai: un('35ug/d'))
          else
            Dri.new(ai: un('30ug/d'))
          end
        dri.ai += un('1.0ug/d') if first_trimester?
        dri.ai += un('4.0ug/d') if second_trimester?
        dri.ai += un('6.0ug/d') if third_trimester?
        dri.ai += un('7.0ug/d') if lactation?
        dri
      end

      ##
      # 钴的参考摄入量。
      # DRI of Cobalt.
      #
      #   :CO
      #
      # @return [Dri]
      def co_dri; end

      # 人体可能必须的微量元素

      ##
      # 锰的参考摄入量。
      # DRI of Manganese.
      #
      #   :MN
      #
      # @return [Dri]
      def mn_dri
        dri =
          case @age
          when 0...0.5
            Dri.new(ai: un('0.01mg/d'))
          when 0.5...1
            Dri.new(ai: un('0.7mg/d'))
          when 1...4
            Dri.new(ai: un('1.5mg/d'))
          when 4...7
            Dri.new(ai: un('2.0mg/d'), ul: un('3.5mg/d'))
          when 7...11
            Dri.new(ai: un('3.0mg/d'), ul: un('5.0mg/d'))
          when 11...14
            Dri.new(ai: un('4.0mg/d'), ul: un('8.0mg/d'))
          when 14...18
            Dri.new(ai: un('4.5mg/d'), ul: un('10mg/d'))
          else
            Dri.new(ai: un('4.5mg/d'), ul: un('11mg/d'))
          end
        dri.ai += un('0.4mg/d') if pregnancy?
        dri.ai += un('0.3mg/d') if lactation?
        dri
      end

      ##
      # 硅的参考摄入量。
      # DRI of Silicon.
      #
      #   :SI
      #
      # @return [Dri]
      def si_dri; end

      ##
      # 镍的参考摄入量。
      # DRI of Nickel.
      #
      #   :NI
      #
      # @return [Dri]
      def ni_dri; end

      ##
      # 硼的参考摄入量。
      # DRI of Boron.
      #
      #   :B
      #
      # @return [Dri]
      def b_dri; end

      ##
      # 钒的参考摄入量。
      # DRI of Vanadium.
      #
      #   :V
      #
      # @return [Dri]
      def v_dri; end

      # 具有潜在毒性，但在低剂量时，对人体可能是有益的微量元素

      ##
      # 氟的参考摄入量。
      # DRI of Fluorine.
      #
      #   :FD
      #
      # @return [Dri]
      def fd_dri
        case @age
        when 0...0.5
          Dri.new(ai: un('0.01mg/d'))
        when 0.5...1
          Dri.new(ai: un('0.23mg/d'))
        when 1...4
          Dri.new(ai: un('0.6mg/d'), ul: un('0.8mg/d'))
        when 4...7
          Dri.new(ai: un('0.7mg/d'), ul: un('1.1mg/d'))
        when 7...11
          Dri.new(ai: un('1.0mg/d'), ul: un('1.7mg/d'))
        when 11...14
          Dri.new(ai: un('1.3mg/d'), ul: un('2.5mg/d'))
        when 14...18
          Dri.new(ai: un('1.5mg/d'), ul: un('3.1mg/d'))
        else
          Dri.new(ai: un('1.5mg/d'), ul: un('3.5mg/d'))
        end
      end

      ##
      # 铅的参考摄入量。
      # DRI of Lead.
      #
      #   :PB
      #
      # @return [Dri]
      def pb_dri; end

      ##
      # 镉的参考摄入量。
      # DRI of Cadmium.
      #
      #   :CD
      #
      # @return [Dri]
      def cd_dri; end

      ##
      # 汞的参考摄入量。
      # DRI of Mercury.
      #
      #   :HG
      #
      # @return [Dri]
      def hg_dri; end

      ##
      # 砷的参考摄入量。
      # DRI of Arsenic.
      #
      #   :AS
      #
      # @return [Dri]
      def as_dri; end

      ##
      # 铝的参考摄入量。
      # DRI of Aluminum.
      #
      #   :AL
      #
      # @return [Dri]
      def al_dri; end

      ##
      # 锂的参考摄入量。
      # DRI of Lithium.
      #
      #   :LI
      #
      # @return [Dri]
      def li_dri; end

      ##
      # 锡的参考摄入量。
      # DRI of Tin.
      #
      #   :SN
      #
      # @return [Dri]
      def sn_dri; end

      # 其它微量元素

      ##
      # 锶的参考摄入量。
      # DRI of Strontium.
      #
      #   :SR
      #
      # @return [Dri]
      def sr_dri; end
    end
  end
end
