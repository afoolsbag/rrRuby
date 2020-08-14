#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-06 – 2020-08-14
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/nutrients'

class NutrientsTest < Minitest::Test
  def test_nutrients
    nuts = RrExeNut3::Nutrients.new
    nuts[:WATER] = Unit.new('10g')
  end
end
