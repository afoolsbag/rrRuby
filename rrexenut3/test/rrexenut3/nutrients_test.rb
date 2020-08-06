#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-06 – 2020-08-06
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/nutrients'

module RrExeNut3
  class NutrientsTest < Minitest::Test
    def test_that_1
      nuts = RrExeNut3::Nutrients.new
      nuts[:WATER] = Unit.new('10g')
      nuts *= 10
      puts nuts
    end
  end
end
