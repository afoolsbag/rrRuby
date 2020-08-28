#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-07 – 2020-08-28
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'colorize'
require 'ruby-units'
$VERBOSE = old

require 'rrexenut3/cn_dris_2013/dris'
require 'rrexenut3/infoods/tagname'

module RrExeNut3
  ##
  # 中国居民膳食营养素参考摄入量（2013版）。
  # Chinese Dietary Reference Intakes 2013.
  module CnDris2013
    ##
    # 依据参考摄入量，对某段时间内营养素的摄入、消耗进行总结，生成总结报告。
    #
    # @param intakes [Nutrients] 某段时间内的摄入量。
    # @param dris [Dris] 参考摄入量。
    # @param duration [Unit, #to_unit] 时间段。
    # @return [String] 报告。
    def self.summary(intakes, dris, duration: '1day')
      duration = duration.to_unit unless duration.is_a?(Unit)

      rv = ''
      Dris::TAGNAME_DRINAME_MAPPING.each do |elem|
        if elem.instance_of?(String)
          rv += "#{elem}\n"
        elsif elem.instance_of?(Array)
          tagname, driname = elem
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

      # prefix: __name:____
      align = ' ' * (8 - name.length)
      prefix = "  #{name}:#{align}"

      rv = ''
      rv += summary_line_eer(prefix, intake, dri, duration) if dri.contains_eer?
      rv += summary_line_lamdr_aipct_uamdr(prefix, intake, dri, duration) if dri.contains_lamdr_aipct_uamdr?
      if dri.contains_ear_rni_pi_ul?
        rv += summary_line_ear_rni_pi_ul(prefix, intake, dri, duration)
      elsif dri.contains_aiunit_pi_ul?
        rv += summary_line_aiunit_pi_ul(prefix, intake, dri, duration)
      elsif dri.contains_spl_pi_ul?
        rv += summary_line_spl_pi_ul(prefix, intake, dri, duration)
      end
      rv
    end

    private_class_method :summary_line

    # @param prefix [String] 前导文本。
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line_eer(prefix, intake, dri, duration)
      return "#{prefix} #{dri.label(:eer)&.colorize(:light_black)}\n" if intake.nil?

      left = nil
      right = nil
      compare = lambda do |field|
        if intake < duration * dri[field]
          right = " #{dri.label(field)&.colorize(:light_black)}"
        else
          left = " #{dri.label(field)&.colorize(:light_black)}"
        end
      end
      compare.call(:eer) if dri.eer
      "#{prefix}#{left} [#{intake}]#{right}\n"
    end

    private_class_method :summary_line_eer

    # @param prefix [String] 前导文本。
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line_lamdr_aipct_uamdr(prefix, intake, dri, duration)
      if intake.nil?
        lamdr = dri.label(:lamdr)&.colorize(:light_black)
        lamdr &&= " #{lamdr}"
        ai = dri.label(:ai)&.colorize(:light_black)
        ai &&= " #{ai}"
        uamdr = dri.label(:uamdr)&.colorize(:light_black)
        uamdr &&= " #{uamdr}"
        return "#{prefix}#{lamdr}#{ai}#{uamdr}\n"
      end

      # TODO
      ''
    end

    private_class_method :summary_line_lamdr_aipct_uamdr

    # @param prefix [String] 前导文本。
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line_ear_rni_pi_ul(prefix, intake, dri, duration)
      if intake.nil?
        ear = dri.label(:ear)&.colorize(:light_black)
        ear &&= " #{ear}"
        rni = dri.label(:rni)&.colorize(:light_black)
        rni &&= " #{rni}"
        pi = dri.label(:pi)&.colorize(:light_black)
        pi &&= " #{pi}"
        ul = dri.label(:ul)&.colorize(:light_black)
        ul &&= " #{ul}"
        return "#{prefix}#{ear}#{rni}#{pi}#{ul}\n"
      end

      left = nil
      right = nil
      compare = lambda do |field|
        if intake < duration * dri[field]
          right = " #{dri.label(field)&.colorize(:light_black)}"
        else
          left = " #{dri.label(field)&.colorize(:light_black)}"
        end
      end
      compare.call(:ear) if dri.ear
      compare.call(:rni) if right.nil? && dri.rni
      compare.call(:pi) if right.nil? && dri.pi
      compare.call(:ul) if right.nil? && dri.ul
      "#{prefix}#{left} [#{intake}]#{right}\n"
    end

    private_class_method :summary_line_ear_rni_pi_ul

    # @param prefix [String] 前导文本。
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line_aiunit_pi_ul(prefix, intake, dri, duration)
      if intake.nil?
        ai = dri.label(:ai)&.colorize(:light_black)
        ai &&= " #{ai}"
        pi = dri.label(:pi)&.colorize(:light_black)
        pi &&= " #{pi}"
        ul = dri.label(:ul)&.colorize(:light_black)
        ul &&= " #{ul}"
        return "#{prefix}#{ai}#{pi}#{ul}\n"
      end

      left = nil
      right = nil
      compare = lambda do |field|
        if intake < duration * dri[field]
          right = " #{dri.label(field)&.colorize(:light_black)}"
        else
          left = " #{dri.label(field)&.colorize(:light_black)}"
        end
      end
      compare.call(:ai) if dri.ai
      compare.call(:pi) if right.nil? && dri.pi
      compare.call(:ul) if right.nil? && dri.ul
      "#{prefix}#{left} [#{intake}]#{right}\n"
    end

    private_class_method :summary_line_aiunit_pi_ul

    # @param prefix [String] 前导文本
    # @param intake [Unit] 某段时间内，某营养素的摄入量。
    # @param dri [Dri] 某营养素的参考摄入量。
    # @param duration [Unit] 时间段。
    # @return [String]
    def self.summary_line_spl_pi_ul(prefix, intake, dri, duration)
      if intake.nil?
        spl = dri.label(:ai)&.colorize(:light_black)
        spl &&= " #{spl}"
        pi = dri.label(:pi)&.colorize(:light_black)
        pi &&= " #{pi}"
        ul = dri.label(:ul)&.colorize(:light_black)
        ul &&= " #{ul}"
        return "#{prefix}#{spl}#{pi}#{ul}\n"
      end

      left = nil
      right = nil
      compare = lambda do |field|
        if intake < duration * dri[field]
          right = " #{dri.label(field)&.colorize(:light_black)}"
        else
          left = " #{dri.label(field)&.colorize(:light_black)}"
        end
      end
      compare.call(:spl) if dri.spl
      compare.call(:pi) if right.nil? && dri.pi
      compare.call(:ul) if right.nil? && dri.ul
      "#{prefix}#{left} [#{intake}]#{right}\n"
    end

    private_class_method :summary_line_spl_pi_ul
  end
end
