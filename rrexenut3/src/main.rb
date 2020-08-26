#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-03
# Unlicense

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'abbrev'
require 'colorized_string'
require 'date'
require 'readline'

require 'rrexenut3/cli_session'

##
# 命令模块。
#
# 收集命令，提供命令名到方法的映射。
module Commands
  ##
  # 映射 command => symbol
  # @return [Hash<String=>Symbol>]
  @command_symbol_mapping = {}

  ##
  # 映射 symbol => parameters
  # @return [Hash<Symbol=>Array<String>>]
  @symbol_parameters_mapping = {}

  ##
  # 映射 symbol => description
  # @return [Hash<Symbol=>String>]
  @symbol_description_mapping = {}

  ##
  # 建立映射。
  #
  # @param symbol [Symbol] 符号
  # @param commands [Array<String>] 命令名列表
  # @param parameters [Array<String>] 参数列表
  # @param description [String] 描述
  # @return [void]
  def self.map(symbol, commands, parameters, description)
    commands.each { |command| @command_symbol_mapping[command] = symbol }
    @symbol_parameters_mapping[symbol] = parameters
    @symbol_description_mapping[symbol] = description
    nil
  end

  ##
  # 调用命令。
  #
  # @param command [String] 命令名
  # @param arguments [Array<String>] 命令行参数
  # @param session [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [:break, Object] 终止循环标志
  def self.call(command, arguments, session)
    raise NameError, %(无法理解 #{command} 命令。) unless @command_symbol_mapping.include?(command)

    symbol = @command_symbol_mapping[command]
    raise %(命令 #{command} 被接受，但其对应方法 #{symbol} 未定义。) unless singleton_methods(false).include?(symbol)

    singleton_method(symbol).call(arguments, session)
  end

  map(:change, %w[change], ['date'], '切换到某一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.change(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    sess.change_focus_date(Date.parse(args[1]))
    puts sess.succ("切换到#{sess.focus_date.year}年#{sess.focus_date.month}月#{sess.focus_date.day}日。")
    puts
  end

  map(:clear, %w[clear cls], [], '清空屏幕')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.clear(_, _)
    # Console Virtual Terminal Sequences
    # ESC 2 J 清屏
    # ESC [ F 将光标移至首行开头
    print "\e[2J\e[F"
  end

  map(:exercise, %w[do exercise], %w[exercise_id amount], '运动，录入当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.exercise; end

  map(:help, %w[? help], [], '帮助')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.help(_args, _sess)
    usage_width = 0
    @command_symbol_mapping.each do |cmd, sym|
      usage_len = cmd.length + (@symbol_parameters_mapping[sym].map { |str| 3 + str.length }.reduce(:+) || 0)
      usage_width = usage_len if usage_width < usage_len
    end

    puts '当前可以理解的命令有：'
    @command_symbol_mapping.sort_by(&:first).to_h.each do |cmd, sym|
      params = @symbol_parameters_mapping[sym]
      desc = @symbol_description_mapping[sym]

      usage_len = cmd.length + (params.map { |str| 3 + str.length }.reduce(:+) || 0)
      usage_padding = ' ' * (usage_width - usage_len)

      colorized_usage = ColorizedString[cmd].colorize(:default)
      params.each do |param|
        colorized_usage = "#{colorized_usage} <#{ColorizedString[param].colorize(:light_black)}>"
      end
      colorized_desc = ColorizedString[desc].colorize(:light_black)
      puts "  #{colorized_usage}#{usage_padding} #{colorized_desc}"
    end
    puts
  end

  map(:ingest, %w[drink eat ingest], %w[food_id intake], '摄入，录入当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.ingest; end

  map(:list, %w[list ll ls], [], '列出当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.list; end

  map(:load_profile, %w[load_profile], ['profile_name'], '加载档案')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.load_profile(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    profile_name = args[1]

    sess.load_profile(profile_name)
    puts sess.succ("档案 #{profile_name} 加载完毕。")
    puts
  end

  map(:new_profile, %w[new_profile], ['profile_name'], '新建档案')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.new_profile(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    profile_name = args[1]

    sess.new_profile(profile_name)
    puts sess.succ("档案 #{profile_name} 新建完毕。")
    puts
  end

  map(:next, %w[> next], [], '切换到后一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.next(args, sess)
    args[1] = (sess.focus_date + 1).iso8601
    change(args, sess)
  end

  map(:previous, %w[< previous], [], '切换到前一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.previous(args, sess)
    args[1] = (sess.focus_date - 1).iso8601
    change(args, sess)
  end

  map(:quit, %w[close exit quit], [], '退出程序')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [Symbol] 循环终止标志
  def self.quit(_args, _sess)
    :break
  end

  map(:remove, %w[delete remove rm], ['activity'], '从当日移除一项活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.remove; end

  map(:summary, %w[summary], [], '显示当日摘要')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.summary; end

  map(:today, %w[= today], [], '切换到今天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
  # @return [void]
  def self.today(args, sess)
    args[1] = Date.today.iso8601
    change(args, sess)
  end

  COMMANDS = @command_symbol_mapping.keys
  COMMAND_ABBREV_MAPPING = COMMANDS.abbrev
end

if __FILE__ == $PROGRAM_NAME
  # Readline 相关
  Readline.completer_word_break_characters = "\n"
  Readline.completion_proc = proc { |text| Commands::COMMANDS.grep(/^#{Regexp.escape(text)}/) }
  Readline.completion_append_character = ''

  # 档案相关
  sess = RrExeNut3::CliSession.new

  # 自动加载工作目录下，找到的首个档案
  Dir.new('.').each do |filename|
    if filename =~ /(.*)\.rrexenut3\.profile$/
      sess.load_profile(Regexp.last_match(1))
      break
    end
  end

  # 命令行循环
  loop do
    line = Readline.readline("#{sess.prompt_text} #{sess.prompt_sign} ", true)
    args = line.gsub(/\s+/m, ' ').strip.split(' ')
    next if args[0].nil?

    cmd = Commands::COMMAND_ABBREV_MAPPING[args[0]] || args[0]

    begin
      break if Commands.call(cmd, args, sess) == :break
    rescue StandardError => e
      puts sess.fai1(e.message)
      # puts e.backtrace.inspect
      puts
    end
  end
end
