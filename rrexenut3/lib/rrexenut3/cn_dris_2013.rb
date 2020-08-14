#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-07 – 2020-08-14
# Unlicense

require 'ruby-units'

require 'rrexenut3/cn_dris_2013/dris'
require 'rrexenut3/infoods/tagname'

module RrExeNut3
  ##
  # 中国居民膳食营养素参考摄入量（2013版）。
  # Chinese Dietary Reference Intakes 2013.
  module CnDris2013
    ONE_DAY = Unit.new('1d').freeze

    ##
    # 依据参考摄入量，对某段时间内营养素的摄入、消耗进行总结，生成总结报告。
    #
    # @param intakes [Nutrients] 某段时间内的摄入量。
    # @param dris [Dris] 参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String] 报告。
    def self.summary(intakes, dris, duration: ONE_DAY)
      rv = ''
      Dris::TAGNAME_DRINAME_MAPPING.each do |elem|
        if elem.instance_of?(String)
          rv += "#{elem}\n"
        elsif elem.instance_of?(Array)
          tagname = elem[0]
          driname = elem[1]
          rv += summary_line(tagname.to_s, intakes[tagname], dris.send(driname), duration)
        else
          raise 'Logic error.'
        end
      end
      rv
    end

    ##
    # 生成报告的一行。
    #
    # @param name [String] 项名。
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line(name, intake, dri, duration)
      return '' if dri.empty?

      align = ' ' * (8 - name.length)

      if intake.nil?
        rv = ''
        label = ->(field) { dri[field] ? " <#{field.to_s.upcase} #{dri[field]}>" : nil }
        rv += "  #{name}:#{align}#{label.call(:eer)}\n" if dri.contains_eer?
        rv += "  #{name}:#{align}#{label.call(:lamdr)}#{label.call(:ai)}#{label.call(:uamdr)}\n" if dri.contains_lamdr_aipct_uamdr?
        if dri.contains_ear_rni_pi_ul?
          rv += "  #{name}:#{align}#{label.call(:ear)}#{label.call(:rni)}#{label.call(:pi)}#{label.call(:ul)}\n"
        elsif dri.contains_aiunit_pi_ul?
          rv += "  #{name}:#{align}#{label.call(:ai)}#{label.call(:pi)}#{label.call(:ul)}\n"
        elsif dri.contains_spl_pi_ul?
          rv += "  #{name}:#{align}#{label.call(:spl)}#{label.call(:pi)}#{label.call(:ul)}\n"
        end
        return rv
      end

      rv = ''
      if dri.contains_eer?
        # TODO
      end

      if dri.contains_lamdr_aipct_uamdr?
        # TODO
      end

      left = nil
      right = nil
      compare = lambda do |field|
        if intake < duration * dri[field]
          right = " <#{field.to_s.upcase} #{dri[field]}>"
        else
          left = " <#{field.to_s.upcase} #{dri[field]}>"
        end
      end
      if dri.contains_ear_rni_pi_ul?
        compare.call(:ear) if dri.ear
        compare.call(:rni) if right.nil? && dri.rni
        compare.call(:pi) if right.nil? && dri.pi
        compare.call(:ul) if right.nil? && dri.ul
        rv += "  #{name}:#{align}#{left} #{intake}#{right}\n"
      elsif dri.contains_aiunit_pi_ul?
        compare.call(:ai) if dri.ai
        compare.call(:pi) if right.nil? && dri.pi
        compare.call(:ul) if right.nil? && dri.ul
        rv += "  #{name}:#{align}#{left} #{intake}#{right}\n"
      elsif dri.contains_spl_pi_ul?
        compare.call(:spl) if dri.spl
        compare.call(:pi) if right.nil? && dri.pi
        compare.call(:ul) if right.nil? && dri.ul
        rv += "  #{name}:#{align}#{left} #{intake}#{right}\n"
      end
      rv
    end

    private_class_method :summary_line
  end
end
