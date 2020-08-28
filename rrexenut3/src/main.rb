#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-28
# Unlicense

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

old, $VERBOSE = $VERBOSE, nil
require 'abbrev'
require 'colorize'
require 'date'
require 'readline'
$VERBOSE = old

require 'rrexenut3/cli_session'
require 'rrexenut3/ifrs'

##
# 命令模块。
#
# 收集命令，提供命令名到方法的映射。
module Commands
  ##
  # 映射 command => symbol
  # @return [Hash<String=>Symbol>]
  @cmd2sym = {}

  ##
  # 映射 symbol => parameters
  # @return [Hash<Symbol=>Array<String>>]
  @sym2params = {}

  ##
  # 映射 symbol => options
  # @return [Hash<Symbol=>Array<String>>]
  @sym2opts = {}

  ##
  # 映射 symbol => description
  # @return [Hash<Symbol=>String>]
  @sym2desc = {}

  ##
  # 建立映射。
  #
  # @param commands [Array<String>] 命令名列表
  # @param symbol [Symbol] 符号
  # @param parameters [Array<String>] 参数列表
  # @param option [Array<String>] 选项列表
  # @param description [String] 描述
  # @return [void]
  def self.map(commands, symbol, parameters, options, description)
    commands.each { |command| @cmd2sym[command] = symbol }
    @sym2params[symbol] = parameters
    @sym2opts[symbol] = options
    @sym2desc[symbol] = description
    nil
  end

  ##
  # 调用命令。
  #
  # @param command [String] 命令名
  # @param arguments [Array<String>] 命令行参数
  # @param session [RrExeNut3::CliSession] 命令行界面会话
  # @return [:break, Object] 终止循环标志
  def self.call(command, arguments, session)
    raise NameError, %(无法理解 #{command} 命令。) unless @cmd2sym.include?(command)

    symbol = @cmd2sym[command]
    raise %(命令 #{command} 被接受，但其对应方法 #{symbol} 未定义。) unless singleton_methods(false).include?(symbol)

    singleton_method(symbol).call(arguments, session)
  end

  map(%w[birthday], :birthday, ['date'], [], '设定生日')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.birthday(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    sess.birthday = args[1]
    puts
  end

  map(%w[change], :change, ['date'], [], '切换到某一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.change(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    sess.change_focus_date(args[1])
    puts
  end

  map(%w[clear cls], :clear, [], [], '清空屏幕')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.clear(_args, _sess)
    # Console Virtual Terminal Sequences
    # ESC 2 J 清屏
    # ESC [ F 将光标移至首行开头
    print "\e[2J\e[F"
  end

  map(%w[do exercise], :exercise, %w[exercise_id amount], ['description'], '运动，录入当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.exercise(args, sess)
    raise ArgumentError, '该命令需要至少 2 个参数。' if args.length < 3

    sess.record_activity(args[1], args[2], args[3])
  end

  map(%w[? help], :help, [], [], '帮助')
  ##
  #   cmd <param1> <param2> [opt1] [opt2] desc
  #      |<  params len  >||< opts len >|
  #   |<          usage_width          >|
  #
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.help(_args, _sess)
    usage_width = 0
    @cmd2sym.each do |cmd, sym|
      params_len = @sym2params[sym].map { |str| 3 + str.length }.reduce(:+) || 0
      opts_len = @sym2opts[sym].map { |str| 3 + str.length }.reduce(:+) || 0
      usage_len = cmd.length + params_len + opts_len
      usage_width = usage_len if usage_width < usage_len
    end

    puts '当前可以理解的命令有：'
    @cmd2sym.sort_by(&:first).to_h.each do |cmd, sym|
      params = @sym2params[sym]
      opts = @sym2opts[sym]
      desc = @sym2desc[sym]

      params_len = params.map { |str| 3 + str.length }.reduce(:+) || 0
      opts_len = opts.map { |str| 3 + str.length }.reduce(:+) || 0
      usage_len = cmd.length + params_len + opts_len
      usage_padding = ' ' * (usage_width - usage_len)

      usage = cmd.colorize(:default)
      params.each { |param| usage += " <#{param.colorize(:light_black)}>" }
      opts.each { |opt| usage += " [#{opt.colorize(:light_black)}]" }
      puts "  #{usage}#{usage_padding} #{desc.colorize(:light_black)}"
    end
    puts
  end

  map(%w[drink eat ingest], :ingest, %w[food_id intake], ['description'], '摄入，录入当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.ingest(args, sess)
    raise ArgumentError, '该命令需要至少 2 个参数。' if args.length < 3

    sess.record_activity(args[1], args[2], args[3])
  end

  map(%w[list ll ls], :list, [], [], '列出当日活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.list(_args, sess)
    puts sess.list_activities_in_the_day
    puts
  end

  map(%w[load_profile], :load_profile, ['profile_name'], [], '加载档案')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.load_profile(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    profile_name = args[1]

    sess.load_profile(args[1])
    puts sess.succ("档案 #{profile_name} 加载完毕。")
    puts
  end

  map(%w[new_profile], :new_profile, ['profile_name'], [], '新建档案')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.new_profile(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    profile_name = args[1]

    sess.new_profile(profile_name)
    puts sess.succ("档案 #{profile_name} 新建并加载完毕。")
    puts
  end

  map(%w[> next], :next, [], [], '切换到后一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.next(_args, sess)
    sess.change_focus_date_next
    puts
  end

  map(%w[< previous], :previous, [], [], '切换到前一天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.previous(_args, sess)
    sess.change_focus_date_previous
    puts
  end

  map(%w[close exit quit], :quit, [], [], '退出程序')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [Symbol] 循环终止标志
  def self.quit(_args, _sess)
    :break
  end

  map(%w[delete remove rm], :remove, ['activity'], [], '从当日移除一项活动')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.remove(args, sess)
    raise NotImplementedError
  end

  map(%w[sex], :sex, ['sex'], [], '记录性别、孕期或哺乳期')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.sex(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    sess.sex = args[1]
    puts
  end

  map(%w[summary], :summary, [], [], '显示当日摘要')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.summary(_args, sess)
    puts sess.summary_the_day
    puts
  end

  map(%w[= today], :today, [], [], '切换到今天')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.today(_args, sess)
    sess.change_focus_date(Date.today)
    puts
  end

  map(%w[weight], :weight, ['weight'], [], '记录体重')
  ##
  # @param args [Array<String>] 命令行参数
  # @param sess [RrExeNut3::CliSession] 命令行界面会话
  # @return [void]
  def self.weight(args, sess)
    raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

    sess.weight = args[1]
    puts
  end

  # 命令
  COMMANDS = @cmd2sym.keys
  # 命令缩写映射
  COMMAND_ABBREV_MAPPING = COMMANDS.abbrev
end

if __FILE__ == $PROGRAM_NAME
  # Readline 相关
  Readline.completer_word_break_characters = "\n"
  Readline.completion_proc = proc { |text| Commands::COMMANDS.grep(/^#{Regexp.escape(text)}/) }
  Readline.completion_append_character = ''

  # 会话相关
  sess = RrExeNut3::CliSession.new

  # 自动加载工作目录下，找到的首个档案
  sess.load_first_profile_in_dir

  # 命令行循环
  loop do
    line = Readline.readline("#{sess.prompt_text} #{sess.prompt_sign} ", true)
    args = line.gsub(/\s+/m, ' ').strip.split(' ')
    next if args[0].nil?

    # 命令缩写
    cmd = Commands::COMMAND_ABBREV_MAPPING[args[0]] || args[0]

    begin
      break if Commands.call(cmd, args, sess) == :break
    rescue Exception => e
      puts sess.fai1(e.message)
      # puts e.backtrace.inspect
      puts
    end
  end
end
