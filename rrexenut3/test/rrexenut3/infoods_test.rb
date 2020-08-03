#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-03 – 2020-08-03
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/infoods'

module RrExeNut3
  class InfoodsTest < Minitest::Test
    def test_that_kitty_can_eat
      tagnames = RrExeNut3::Infoods::TAGNAMES
      p tagnames[:'WATER']
    end
  end
end
