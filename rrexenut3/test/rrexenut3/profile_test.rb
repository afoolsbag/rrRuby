#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-26 – 2020-08-27
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/profile'

class ProfileTest < Minitest::Test
  def test_birthday
    profile = RrExeNut3::Profile.new('test.ren3p')
    profile.birthday = Date.today
    _ = profile.birthday
  end

  def test_sex
    profile = RrExeNut3::Profile.new('test.ren3p')
    profile.sex = %i[male female].sample
    _ = profile.sex
  end

  def test_weight
    profile = RrExeNut3::Profile.new('test.ren3p')
    profile.weight = '50kg'
    _ = profile.weight
  end

  def test_activity
    profile = RrExeNut3::Profile.new('test.ren3p')
    profile.insert_activity('CN.CDC.FCT6.081101x', '100g')
    _ = profile.select_activities_by_day
  end
end
