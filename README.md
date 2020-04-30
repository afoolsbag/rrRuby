# zhengrr 所知的 Ruby

[*Ruby*](https://www.ruby-lang.org/ "Ruby, 1995")

松本行弘

```cmder
%USERPROFILE% λ ruby -w <script.rb>  :: 运行脚本
%USERPROFILE% λ irb                  :: 交互式 Ruby 壳层

%USERPROFILE% λ gem sources [--list]     :: 列出源
:: abbr.        gem sources [-l]
%USERPROFILE% λ gem sources --add        :: 增加源
:: abbr         gem sources -a
%USERPROFILE% λ gem sources --remove     :: 去除源
:: abbr.        gem sources -r
%USERPROFILE% λ gem sources --clear-all  :: 清空源和缓存
:: abbr.        gem sources -c
%USERPROFILE% λ gem sources --update     :: 更新缓存
:: abbr.        gem sources -u
%USERPROFILE% λ gem sources -a https://gems.ruby-china.com/ -r https://rubygems.org/

%USERPROFILE% λ gem update --system               :: 升级 RubyGems
%USERPROFILE% λ gem list --locale                 :: 列出已安装的 Gem
:: abbr.        gem liar -l
%USERPROFILE% λ gem query --remote --name <name>  :: 按名称查询 Gem
:: abbr.        gem query -rn <name>
%USERPROFILE% λ gem install <gem> --remote        :: 安装 Gem
:: abbr.        gem install <gem> -r
%USERPROFILE% λ gem update <gem> --remote         :: 升级 Gem
:: abbr.        gem update <gem> -r
%USERPROFILE% λ gem uninstall <gem>               :: 卸载 Gem
%USERPROFILE% λ gem server                        :: 运行本地 Gem RDoc 文档服务

%USERPROFILE% λ bundle install  :: 依 Gemfile 安装依赖的 Gem

%USERPROFILE% λ rdoc  :: 依代码注释生成文档
```

## 参考

*   [*Ruby-Doc.org*](https://ruby-doc.org/)
    *   [Core API](https://ruby-doc.org/core/)
        *   [Ruby 语法](https://ruby-doc.org/core/doc/syntax_rdoc.html)
            *   [字面量](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html)
                *   [布尔和 `nil`](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Booleans+and+nil)
                *   [数字](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html)
                *   [字符串](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Strings)
                *   [符号](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Symbols)
                *   [数组](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Arrays)
                *   [散列](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Hashes)
                *   [范围](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Ranges)
                *   [正则表达式](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Regular+Expressions)
                *   [过程](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Procs)
                *   [百分比字符串](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Percent+Strings)
            *   [赋值](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html)
                *   [局部变量名](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Local+Variable+Names)
                *   [局部变量作用域](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Local+Variable+Scope)
                *   [局部变量和方法](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Local+Variables+and+Methods)
                *   [局部变量和 `eval`](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Local+Variables+and+eval)
                *   [实例变量](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Instance+Variables)
                *   [类变量](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Class+Variables)
                *   [全局变量](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Global+Variables)
                *   [赋值方法](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Assignment+Methods)
                *   [缩写赋值](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Abbreviated+Assignment)
                *   [隐式数组赋值](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Implicit+Array+Assignment)
                *   [多重赋值](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Multiple+Assignment)
                *   [数组分解](https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html#label-Array+Decomposition)
            *   [控制表达式](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html)
                *   [`if` 表达式](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-if+Expression)
                *   [三元 `if`](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Ternary+if)
                *   [`unless` 表达式](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-unless+Expression)
                *   [修饰符 `if` 和 `unless`](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Modifier+if+and+unless)
                *   [`case` 表达式](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-case+Expression)
                *   [`while` 循环](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-while+Loop)
                *   [`until` 循环](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-until+Loop)
                *   [`for` 循环](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-for+Loop)
                *   [修饰符 `while` 和 `until`](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Modifier+while+and+until)
                *   [`break` 语句](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-break+Statement)
                *   [`next` 语句](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-next+Statement)
                *   [`redo` 语句](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-redo+Statement)
                *   [修饰符语句](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Modifier+Statements)
                *   [触发器](https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html#label-Flip-Flop)
            *   [方法](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html)
                *   [方法名](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Method+Names)
                *   [返回值](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Return+Values)
                *   [作用域](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Scope)
                *   [重写](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Overriding)
                *   [参数](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Arguments)
                *   [块参数](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Block+Argument)
                *   [异常处理](https://ruby-doc.org/core/doc/syntax/methods_rdoc.html#label-Exception+Handling)
            *   [调用方法](https://ruby-doc.org/core/doc/syntax/calling_methods_rdoc.html)
                *   [接收者](https://ruby-doc.org/core/doc/syntax/calling_methods_rdoc.html#label-Receiver)
                *   [参数](https://ruby-doc.org/core/doc/syntax/calling_methods_rdoc.html#label-Arguments)
                *   [方法查询](https://ruby-doc.org/core/doc/syntax/calling_methods_rdoc.html#label-Method+Lookup)
            *   [模块和类](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html)
                *   [模块定义](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Module+Definition)
                *   [嵌套](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Nesting)
                *   [作用域](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Scope)
                *   [定义类](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Defining+a+class)
                *   [继承](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Inheritance)
                *   [元类](https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html#label-Singleton+Classes)
            *   [异常](https://ruby-doc.org/core/doc/syntax/exceptions_rdoc.html)
            *   [优先级](https://ruby-doc.org/core/doc/syntax/precedence_rdoc.html)
            *   [改进](https://ruby-doc.org/core/doc/syntax/refinements_rdoc.html)
            *   [杂项](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html)
                *   [结束一个表达式](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-Ending+an+Expression)
                *   [缩进](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-Indentation)
                *   [`alias`](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-alias)
                *   [`undef`](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-undef)
                *   [`defined?`](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-defined-3F)
                *   [`BEGIN` 和 `END`](https://ruby-doc.org/core/doc/syntax/miscellaneous_rdoc.html#label-BEGIN+and+END)
            *   [注释](https://ruby-doc.org/core/doc/syntax/comments_rdoc.html)
        *   [正则表达式](https://ruby-doc.org/core/doc/regexp_rdoc.html)
        *   [关键字](https://ruby-doc.org/core/doc/keywords_rdoc.html)
        *   [全局变量](https://ruby-doc.org/core/doc/globals_rdoc.html)
    *   [Standard Library API](https://ruby-doc.org/stdlib/)

*   [“Ruby Quickref”](http://zenspider.com/ruby/quickref.html). *zenspider.com*.

## 风格

*   [*The Ruby Style Guide*](https://github.com/rubocop-hq/ruby-style-guide) <sub>
        [*cmn-Hans*](https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md) </sub>

## 指南

*   [“Ruby Documentation Bundle”](https://ruby-doc.org/docs/ruby-doc-bundle/). *Ruby-Doc.org*.
*   [“Ruby Programming”](https://wikibooks.org/wiki/Ruby_Programming). *Wikibooks*.
*   [*Programming Ruby 中文版：第 2 版*](http://zbgb.org/278/ZdocDetail3691109.htm "ISBN 978-7-121-03815-0")
*   *松本行弘的程序世界*

## Awesome

[*Awesome Ruby*](https://awesome-ruby.com/)

| [*Rake*](https://ruby.github.io/rake/) <sub>
      [*Rakefile*](https://ruby.github.io/rake/doc/rakefile_rdoc.html) </sub>
| [*RDoc*](https://ruby.github.io/rdoc/) <sub>
      [*writing-doc*](https://ruby.github.io/rdoc/README_rdoc.html#label-Writing+Documentation),
      [*markup-ref*](https://ruby.github.io/rdoc/RDoc/Markup.html#class-RDoc::Markup-label-RDoc+Markup+Reference) </sub>
| [*Shoes!*](http://shoesrb.com/)

环境管理
| [*rbenv*](https://github.com/rbenv/rbenv),
  [*Ruby Installer*](https://rubyinstaller.org/),
  [*Ruby Version Manager*](https://rvm.io/)

包管理器
| [*RubyGems*](https://rubygems.org/)
| [*Bundler*](https://bundler.io/) <sub>
      [*Gemfile*](https://bundler.io/man/gemfile.5.html) </sub>

测试
| [*test-unit*](https://test-unit.github.io/)
| [*RSpec*](https://rspec.info/) <sub>
      [*better*](http://betterspecs.org/),
      [*-cmn-Hans*](http://betterspecs.org/zh_cn/) </sub>

集成开发
| [*RubyMine*](https://jetbrains.com/ruby/) <sub>
      [*zh_CN*](https://github.com/pingfangx/jetbrains-in-chinese/tree/master/RubyMine) </sub>

## 许可

项目采用 Unlicense 许可，文档采用 CC0-1.0 许可：

<p xmlns:dct="https://purl.org/dc/terms/">
  <a rel="license"
     href="https://creativecommons.org/publicdomain/zero/1.0/">
    <img src="https://licensebuttons.net/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law,
  <span resource="[_:publisher]" rel="dct:publisher">
    <span property="dct:title">zhengrr</span></span>
  has waived all copyright and related or neighboring rights to this work.
</p>
