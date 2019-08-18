---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by luowei.
--- DateTime: 2019/8/17 9:56
--- 文件操作
---

parentFileName = "parents.data"
kidsFileName = "kids.data"
outputFileName = "output.data"

------------------------------------ Lua I/O库概述  ----------------------------------

-- Lua的I/O库用于文件操作，I/O库的实现为io表，所有的文件操作函数都位于该io表中。
-- Lua的I/O库提供了两种操作文件的方式：
--      1）隐式的文件句柄；这种方式需要设置默认的输入输出文件（由io.input和io.output设置），后续所有的操作都是基于该输入输出文件。文件操作的函数都位于io库中。
--      2）显示文件句柄：该方式使用io.open方法打开一个文件并返回文件句柄，显示文件句柄本身支持很多方法对文件执行操作，这点和隐式文件句柄需要依赖io函数表不一样。
--          下面内容中，都以 openedFile 指代显示文件句柄
-- Lua文件操作的返回值：所有的I/O操作在失败的时候，第一个返回值都是nil，第二个参数为错误描述信息，第三个参数是系统相关的错误码

------------------------------------ io.open 打开一个文件 ----------------------------------
-- io.open(filename, [mode]
--      用于打开一个文件，并指定打开文件的模式。如果成功，将返回一个文件句柄。
--      mode，指定文件打开的模式，包括："r"-以只读模式打开；    "w"-以写的模式打开；    "a"-以追加的模式打开
--      "r+"-以更新的模式打开，打开前存在的数据将保留；  "w+"-以更新的模式打开，打开前存在的数据将被擦除； "a+"-追加更新的模式打开，打开前存在的数据将保留，只允许在文件末尾写入数据
--      "w"和"w+"的区别：以"w"模式打开，将无法使用file:read读取文件内容，只能写入；而"w+"可以一边写一边读取文件的内容
print("io.open")
openedFile = io.open(parentFileName, "r")
openedFile:close()


------------------------------------ io.input 打开并设置一个隐式文件句柄 ----------------------------------
-- io.input([file])
--      当指定的参数file为一个文件路径时，将打开file指定的文件，并将该文件句柄作为默认的文件句柄（即隐式的文件句柄）；
--      当指定的参数file为一个文件句柄时，将设置该文件句柄为当前默认的文件句柄
--      当不指定参数file时，将返回当前默认的文件句柄
io.input(kidsFileName)
io.close()

------------------------------------ io.lines 遍历文件内容 ----------------------------------
-- io.lines([filename, ...])
--      当指定了filename（文件路径）参数时，将以"r"的模式打开该文件，并返回一个迭代器，用于迭代文件中的每一行内容。当迭代完最后一行内容后，将返回nil，并关闭文件句柄
--      当不指定filename参数时，也会返回一个迭代器，用于迭代当前默认的文件句柄中的内容，但是在迭代结束后不会关闭默认的文件句柄
--      openFile:lines() 为使用显示文件句柄的方式迭代文件内容。
print("io.lines")
print("", "使用io.lines遍历文件")
for line in io.lines(parentFileName) do
    print("", "", line)
end

print("", "使用显示文件句柄迭代文件内容")
openedFile = io.open(parentFileName, "r")
for line in openedFile:lines() do
    print("", "", line)
end
openedFile:close()

print("", "使用隐式文件句柄迭代文件内容")
io.input(kidsFileName)
for line in io.lines() do
    print("", "", line)
end
io.close()

------------------------------------ io.read 从文件中读取数据 ----------------------------------
-- io.read(...)     file:read(...)
--      该函数用于按指定的格式读取文件的内容，支持的格式如下：
--          "*n": 从文件的当前位置读取一个数值（一个浮点数或整数），这种格式下，read函数将读取最长的可以转化为一个数值的串，如果没有可以转化为数值的串，返回nil
--          "*a": 从文件的当前位置读取整个文件剩余的内容，如果当前位置为文件末尾，将返回一个空字符串
--          "*l": 读取文件当前位置的下一行内容，如果当前位置为文件末尾，将返回nil
--          number: 读取一个长度不超过number的字符串
io.input(parentFileName)
print("io.read")
repeat line = io.read("*l")
    if (line ~= nil) then print("", line) end
until line == nil
io.close()

print("file:read(*a)")
openedFile = io.open(parentFileName, "r")
content = openedFile:read("*a")
print("", content)
openedFile:close()

print("file:read(number)")
openedFile = io.open(parentFileName, "r")
word = openedFile:read(2)
print("", word)
openedFile:close()

------------------------------------ file:seek 获取或设置文件的位置 ----------------------------------
-- file:seek([whence[, offset]])
--      file:seek将首先按指定的参数设置文件的位置，然后将位置的返回。设置文件的位置基于两个维度：base和offset，base是指offset将基于什么文件的位置进行偏移。 offset默认的值为0.
--      base由参数whence决定，whence可以为以下三个值（whence默认值为"cur"，offset默认值为0）：
--          "set": 这种情况下base为0，即文件的开始位置。如果参数为file:seek("set", 1)，表示设置文件的位置到 0 + 1 = 1 的位置
--          "cur": 这种情况下base为文件的当前位置，当不指定whence时，默认值为"cur"
--          "end": 这种情况下base为文件的结束位置
print("file:seek")
outputFile = io.open(outputFileName, "w+")
outputFile:write("abcdefghijklmn");     outputFile:flush()
pos = outputFile:seek("set")
word = outputFile:read(2)
print("", "pos = " .. tostring(pos) .. ", word = " .. tostring(word))
pos = outputFile:seek("cur", 2)
word = outputFile:read(2)
print("", "pos = " .. tostring(pos) .. ", word = " .. tostring(word))
outputFile:close()

------------------------------------ io.close 关闭文件句柄 ----------------------------------
-- io.close([file])
--      当指定参数file（为一个已经打开的文件句柄）时，用于关闭file指定的文件句柄。
--      当未指定参数file，将关闭默认的output文件句柄（注意，这里只会close output类型的文件句柄，不会关闭input类型的文件句柄）
--      当一个文件句柄被关闭后，io.type的返回值将是“closed file”
    print("io.close")
outputFile = io.open(outputFileName)
io.close(outputFile);
print("", "io.close关闭隐式文件句柄，io.type() = " .. tostring(io.type(outputFile)))
io.output(outputFileName)
io.close();                     -- io.close() 关闭默认的output文件句柄
outputFile = io.output();
print("", "io.close(openedFile)关闭显示文件句柄，io.type(openedFile) = " .. tostring(io.type(openedFile)))

------------------------------------ io.flush 保存写入数据到文件中 ----------------------------------
-- io.flush()
--      保存写入的数据到当前隐式的output文件文件中，即写入：io.output()
--      使用显示的文件句柄 openedFile:flush() 也可以写入，效果是一样的
io.output(outputFileName)
io.write("abcd")
io.flush()

--

------------------------------------ io.type 判断一个值是否为文件句柄 ----------------------------------
-- io.type(obj) 判断一个值是否为文件句柄。如果是，返回值为“file”；如果是一个已经closed的文件句柄，返回值为“closed file”；否则，返回nil
print("io.type 判断值是否为文件句柄")
-- io.close(openedFile)
print("", "io.type(openedFile) = " .. tostring(io.type(openedFile)))

