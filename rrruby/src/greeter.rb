#!/usr/bin/env ruby -w
# coding: utf-8

# 有礼貌的人
class Greeter
  attr_accessor :names

  # 创建对象
  def initialize(names = 'ZooLoo')
    @names = names
  end

  # 对每个人打招呼
  def say_hi
    if @names.nil?
      puts '...'
    elsif @names.respond_to?('each')
      @names.each do |name|
        puts "Hello #{name}."
      end
    else
      puts "Hello #{names}."
    end
  end

  # 对每个人说再见
  def say_bye
    if @names.nil?
      puts '...'
    elsif @names.respond_to?('join')
      puts "Goodbye #{@names.join(', ')}. Come back soon."
    else
      puts "Goodbye #{@names}. Come back soon."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Greeter.new
  g.say_hi
  g.say_bye

  # Change name to be "Zeke"
  g.names = 'Zeke'
  g.say_hi
  g.say_bye

  # Change the name to an array of names
  g.names = %w(Albert Brenda Charles Dave Engelbert)
  g.say_hi
  g.say_bye

  # Change to nil
  g.names = nil
  g.say_hi
  g.say_bye
end
