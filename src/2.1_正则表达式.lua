---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by luowei.
--- DateTime: 2019/8/18 7:51
--- 正则表达式
---

------------------------------------ Lua正则表达式 ----------------------------------

-- 普通字符
--      除去 % . [ ] ( ) ^ $ * + - ? 的字符，匹配字符本身
--      如：模式"abcd" 匹配完成的字符串 "abcd"

-- .
--[[
元字符         描述                                                            表达式实例          完整匹配

普通字符    除去 % . [ ] ( ) ^ $ * + - ? 的字符，匹配字符本身                    abcd                abcd

.           匹配任意字符                                                        ab.d                abcd

%           转义字符，改变后一个字符的原有意思。当后面的接的是特殊字符时，          a%wcd%.            abcd.
            将还原特殊字符的原意。
            %和一些特定的字母组合构成了lua的预定义字符集。
            %和数字1~9组合表示之前捕获的分组

[...]       字符集。匹配一个包含于集合内的字符。[...]中的特殊字符将还原其原意，     [a%]na             %na
            但有下面几种特殊情况：
            1. %]，%-，%^作为整体表示字符']'，'-'，'^'                           [abcd]e           ae 或 be
            2. 预定义字符集作为一个整体表示对应字符集
            3. 当]位于序列的第一个字符时只表示字符']'
            4. 形如[^...],[...-...]有特定的其他含义

[...-...]   -表示ascii码在它前一个字符到它后一个字符之间的所有字符                  [a-z]a           ca

[^...]      不在...中的字符集合。                                                 [^0-9]na         ana

*           表示前一个字符出现0次或多次
+           表示前一个字符出现1次或1次以上
?           表示前一个字符出现0次或1次

%s          空白符[ \r\n\t\v\f]
%p          标点符号
%c          控制字符
%w          字母数字[a-zA-Z0-9]
%a          字母[a-zA-Z]
%l          小写字母[a-z]
%u          大写字母[A-Z]
%d          数字[0-9]
%x          16进制数[0-9a-fA-F]
%z          ascii码是0的字符

(...)       表达式中用小括号包围的子字符串为一个分组。                              ab(%d+)          ab233
            分组从左到右（以左括号的位置），组序号从1开始递增。                     (%d+)%1          123123 （注意，第一个123为匹配(%d+)，第二个123为补货的第一个分组值123

^           匹配字符串开头                                                        ^(%a)%w*        abc123
$           匹配字符串结尾                                                        %w*(%d)$       abc123

%bxy        平衡匹配（匹配xy对）。这里的x，y可以是任何字符，
            即使是特殊字符也是原来的含义，匹配到的子串以x开始，以y结束，              %b()            (3+4(x*2))
            并且如果从x开始，每遇到x，计算+1，遇到y计数-1，                          %d+%b()         2(3+4(x*2))
            则结束的y是第一个使得计数等于0的y。
            就是匹配成对的符号，常见的如%b()匹配成对的括号

捕获组(captures)    一个模式中可以包含子模式（即包含在一对圆括号中的部分），
                    匹配的子串中，和子模式匹配的子串被称为捕获组。
                    多个捕获组按左圆括号的顺序从1开始排序，
                  如：(a*(.)%w(%s*))中，匹配"a*(.)%w(%s*)"部分的子串被称为第一个捕获组
                  匹配"."部分的子串被称为第2个捕获组，依次推算。。
                  第0个捕获组为整个匹配的子串
--]]

-- 注意事项：
-- 1）Lua的正则表达式不支持捕获组嵌套，如 "((%w+)%s)+" 将不能匹配 "hello world from Lua"，在Java中是可以匹配的。

-- %bxy
print("%bxy")
pattern = "[a-zA-Z]+%b()"
str = "abcd(e(fgh)ijk"
is, ie, g = string.find(str, pattern)
matched = string.sub(str, is, ie)
print("", "is = " .. tostring(is), "ie = " .. tostring(ie), "g = " .. tostring(g), "matched = " .. tostring(matched))

-- 捕获组
print("捕获组")
pattern = "%d+([a-zA-Z]+)%1"
str = "11234ababCD..."
is, ie, g = string.find(str, pattern)
matched = string.sub(str, is, ie)
print("", "is = " .. tostring(is), "ie = " .. tostring(ie), "g = " .. tostring(g), "matched = " .. tostring(matched))