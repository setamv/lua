---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by luowei.
--- DateTime: 2019/8/18 15:12
--- 系统相关
---

------------------------------------ os.clock ----------------------------------
-- os.clock 返回当前当前代码距离程序启动那一刻的时间。单位为秒。可以精确到0.001秒
print("os.clock")
print("", "current time from application start: " .. os.clock())

------------------------------------ os.date ----------------------------------
-- os.date([format[, time])
--      该函数用于获取日期和时间信息
--      如果指定了参数format：1）如果format为"*t"，将返回一个table，里面包含属性 year、month(1-12)、day(1-31)、hour(0-23)、min(0-59)、sec(0-61)、wday(1-7, 周日是1)、yday(一年的中第几日，1-366)
--      如果format不是"*t"，将返回一个字符串类型的日期值，format的格式为：
--              年份相关        %C 年份的后两位数字         %g 年份的后两位数字，使用基于周的年     %G 年分，使用基于周的年       %y 不带世纪的十进制年份（值从0到99）
--                              %Y 带世纪部分的十进制年份
--              月份相关        %b 月分的简写            %B 月份的全称        %h 简写的月份名       %m 十进制表示的月份
--              日相关         %d 十进制表示的每月的第几天     %D 月/天/年        %e 在两字符域中，十进制表示的每月的第几天      %j 十进制表示的每年的第几天
--              星期相关        %a 星期几的简写           %A 星期几的全称       %u 每周的第几天，星期一为第一天 （值从0到6，星期一为0）
--                              %U 第年的第几周，把星期日做为第一天（值从0到53）           %V 每年的第几周，使用基于周的年
--                              %w 十进制表示的星期几（值从0到6，星期天为0）               %W 每年的第几周，把星期一做为第一天（值从0到53）
--              小时小关        %H 24小时制的小时         %I 12小时制的小时
--              分钟相关        %M 十时制表示的分钟数        %R 显示小时和分钟：hh:mm
--              秒相关         %S 十进制的秒数           %T 显示时分秒：hh:mm:ss
--              时间相关        %r 12小时的时间          %X 标准的时间串
--              日期相关        %c 标准的日期的时间串        %F 年-月-日            %x 标准的日期串
--              其他          %p 本地的AM或PM的等价显示
--      time参数用于格式化指定的时间
print("os.date")
print("", os.date("%Y-%m-%d %H:%M:%S"))
print("", os.date("*t")["year"])
print("", os.date("%Y-%m-%d %H:%M:%S", os.time()))

------------------------------------ os.time ----------------------------------
-- os.time([table])
--      如果未指定table参数，将返回系统当前的时间，是一个table值，里面包含 year、month(1-12)、day(1-31)，并且可能包含hour(0-23)、min(0-59)、sec(0-61)值，
--      没有通过 os.date("*t") 返回的table的其他属性，如wday。
--      如果指定了table参数，将使用table中的参数设置时间

------------------------------------ os.difftime ----------------------------------
-- os.difftime(t2, t1) 函数用于返回t1和t2两个time之间相差的时间，单位为秒，即 t2 - t1 的秒数

------------------------------------ os.execute ----------------------------------
-- os.execute([command]) 函数用于执行一个操作系统命令。如：shell脚本命令。
--      如果未指定参数command，如果操作系统支持shell脚本，该函数将返回true
print("os.execute")
print("", os.execute())
ret = os.execute("echo 'hello'")
print("", "ret = " .. tostring(ret))

------------------------------------ os.exit ----------------------------------
-- os.exit([code[, close]]) 函数用于退出宿主程序
--      如果指定了参数code，且code的值为true，将返回状态 EXIT_SUCCESS；如果code的值为false，将返回状态 EXIT_FAILURE；如果code的值为一个数字，返回的状态就是这个数字。默认的code为true
os.exit()