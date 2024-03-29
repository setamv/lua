---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by luowei.
--- DateTime: 2019/8/15 6:46
--- 迭代器与泛型for
---

------------------------------------ 迭代器与闭包 ----------------------------------
print("迭代器与闭包")
numbers = {"one", "two", "three"}
table = {a = "apple", b = "bird", c = "creative"}
-- 迭代器：是一种可以遍历一个集合中所有元素的机制，Lua中通常将迭代器表示为函数，每调用一次函数，即返回集合中的“下一个”元素
-- 每个迭代器需要在每次成功调用之间保持一些状态，这样才能知道它所在的位置以及如何步进到下一个位置，闭包对这种场景提供了极佳的支持。
-- 下面的代码创建了一个简单的迭代器，每次迭代返回集合的一个值：
function values(t)
    local i = 0
    return function()
        i = i + 1
        return t[i]
    end
end
-- 泛型for是专门为这种迭代器函数而设计的，它在每次迭代时都调用一次迭代器函数，直到迭代器函数返回nil
print("", "泛型for调用迭代函数")
for v in values(numbers) do
    print("", "", v)
end
-- 其实使用如下下面的while 循环效果也是一样的
print("", "while循环调用迭代函数")
iter = values(numbers)
while true do
    local v = iter()
    if v == nil then break end
    print("", "", v)
end

------------------------------------ 泛型for的语义 ----------------------------------
print("\n泛型for的语义")
-- 在“迭代器与闭包”中，迭代器函数是利用闭包的特性为每个循环都创建一个闭包，来保存迭代器的状态。
-- 泛型for本身可以保存迭代器的状态，因此可以在定义迭代器函数时避免使用闭包的方式
-- 泛型for在循环的过程中其内部保存了迭代器函数，实际上保存了3个值：一个迭代器函数、一个恒定状态、一个控制变量。泛型for的语法为：
--[[
for <var-list> in <exp-list> do
    <body>
end
--]]
-- 其中，1）<var-list>：是一个或多个变量名的列表；该变量列表的第一个元素称为“控制变量”。在循环过程中，该变量的值一旦为nil，就会退出循环，因此，在 <body> 中，第一个元素永远不会为nil
--      2）<exp-list>：是一个表达式列表，泛型for在初始化的时候，将执行该表达式列表，这些表达式应该返回3个值供for保存：迭代器函数、恒定状态（即在迭代过程中保持不变的值）、控制变量的初始值
--                  这类似多重赋值，只有最后一个表达式才会产生多个结果，并且最多只会保留前3个返回值，多余的值将被丢弃。不足的将以nil补足。
--                  在初始化步骤完成后，泛型for会以恒定状态和控制变量来调用迭代器函数，并将迭代器函数的返回值赋给变量列表<var-list>，如果返回值中的第一个为nil，将终止循环。
-- 假设迭代器函数为f，恒定状态为s，控制变量的初始值为a0，那么在循环过程中控制变量的值依次为：a1 = f(s, a0)、a2 = f(s, a1) ... 直到ai为nil结束循环
-- 泛型for本身可以保存迭代器的状态，这一点可以使得迭代器函数避免使用闭包，从而避免在多个循环中使用同一个迭代器函数时创建新的闭包的开销。可以称这种迭代器函数为“无状态的迭代器”
-- 下面使用无状态的迭代器模拟ipairs（系统的ipairs使用的next(table, key)函数对table进行遍历）：
local function iter(a, i)       -- 定义迭代器函数，接收两个参数：恒定状态、控制变量
    i = i + 1
    local v = a[i]
    if v then
        return i, v
    else
        return nil, nil
    end
end
function myIpairs(a)            -- 定义迭代器
    return iter, a, 0
end

print("", "模拟ipairs - myIpairs")
for i, v in myIpairs(numbers) do
    print("", "", "i = " .. i .. ", v = " .. v)
end

-- 恒定状态虽然在每次迭代的过程中都是同一个值，如一个table，但是恒定状态里面的值可以改变，利用这个特性，可以将控制变量的值保存到恒定状态table中
-- 如下面重写iter迭代器函数，这次，直接忽略控制变量
local function iter1(a)
    if a.ctl == nil then
        a.ctl = 0
    end
    a.ctl = a.ctl + 1
    local v = a[a.ctl]
    if v then
        return a.ctl, v
    else
        return nil, nil
    end
end
function myIpairs1(a)            -- 定义迭代器
    return iter, a, 0
end
print("", "忽略控制变量模拟ipairs")
for i, v in myIpairs1(numbers) do
    print("", "", "ctl = " .. i .. ", v = " .. v)
end