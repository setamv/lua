---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by luowei.
--- DateTime: 2019/8/13 7:05
--- 函数
---

--------------------------------------- 函数的声明 ----------------------------------
-- 函数使用关键字 function 来声明，有两种声明的格式，如下所示（有些类似Javascript）：
function funName(arg)
    return arg
end
-- 其等价于
funcName = function(arg)
    return arg
end
-- Lua中函数是作为第一类值来看待的，这表示函数可以存储在变量中，可以作为参数传递，也可以作为返回值。
alias = funcName
-- 下面将函数作为table中一个变量的值
obj = {}
obj.add = function(a, b)
    return a + b
end


--------------------------------------- 函数的调用 ----------------------------------
print("函数的调用")
-- 函数调用的格式一般都是函数名称后跟一对圆括号，圆括号中指定调用函数的参数。
-- 但有一种特殊的情况下，不需要写圆括号：一个函数若只有一个参数，并且此参数是一个字面字符串或table构造式，如：
print "hello, world!"       -- 等价于print("hello, world!")

-- Lua程序可以调用C语言编写的函数
-- 调用函数时，实参数量可以和形参数量不一样，如果实参多余形参，多余的部分将丢弃；如果实参少于形参，多余的形参将被初始化为nil


------------------------------------ 多重返回值 ----------------------------------
print("多重返回值")
-- Lua的函数可以返回多个值，只需要在 return 关键字后面列出所有的返回值即可。
-- 例如，下面的函数用于找到一个数组中的最大元素和最大元素的索引位置：
function maximum(arr)
    local maxIndex = nil
    local maxVal = nil
    for i, v in ipairs(arr) do
        if maxVal == nil or maxVal < v then
            maxIndex = i
            maxVal = v
        end
    end
    return maxIndex, maxVal
end
i, v = maximum({1, 4, 3, 5, 2})
print("", "maximum(arr) = arr(" .. i .. ") = " .. v)

-- Lua会调整一个函数的返回值数量。
--      1、若将函数调用作为一条单独语句时，Lua会丢弃函数所有的返回值
--      2、若将函数作为一个表达式的一部分来调用时，Lua只保留函数的第一个返回值，除非函数调用是一系列表达式的最后一个元素，这种情况下表达式将可以获得函数返回的所有值
--          这里一系列表达式是指：1）多重赋值；2）函数调用时传入的实参列表；3）table的构造式；4）return语句
function returnMultiVal(arr)            -- 定义一个返回多个值的函数
    return arr[1], arr[2], arr[3]
end
numbers = {1, 2, 3, 4}
print("", "作为一个表达式的一部分来调用时，只保留第一个返回值")
print("", "", returnMultiVal(numbers), "end")                   -- 函数调用 returnMultiVal(numbers) 作为print表达式的一个中间元素
a, b, c = returnMultiVal(numbers), 10                           -- a, b, c多重赋值将只会取函数返回值的第1个，因为函数调用不是表达式的最后一部分
print("", "", "a = " .. tostring(a) .. ", b = " .. tostring(b) .. ", c = " .. tostring(c))

print("", "函数调用是一系列表达式的最后一个元素，获得返回的所有值", returnMultiVal(numbers))
a, b, c = returnMultiVal(numbers)                               -- a, b, c多重赋值将会取函数的所有返回值，因为函数调用是表达式的最后一部分
print("", "", "a = " .. tostring(a) .. ", b = " .. tostring(b) .. ", c = " .. tostring(c))

-- 当函数调用为table构造式的最后一部分时，table构造式可以完整的接收一个函数调用的所有结果；否则，只会接收函数返回的第一个值
print("", "table构造式接收函数调用的结果")
tbl1 = {returnMultiVal(numbers)}
for k, v in pairs(tbl1) do
    print("", "", "tbl1", "key = " .. tostring(k) .. ", value = " .. tostring(v))
end

tbl2 = {returnMultiVal(numbers), 4}
for k, v in pairs(tbl2) do
    print("", "", "tbl2", "key = " .. tostring(k) .. ", value = " .. tostring(v))
end

-- 将函数调用放入一对圆括号中，将强制函数调用只返回一个值
print("", "强制只返回一个值")
print("", "", (returnMultiVal(numbers)))

-- unpack函数：用于返回一个数组的所有元素，如：下面将数组 numbers 的元素作为多重结果返回
print("", "unpack")
print("", "", unpack(numbers))
a, b = unpack(numbers)
print("", "", "a = " .. a .. ", b = " .. b)


------------------------------------ 变长参数 ----------------------------------
print("变长参数")
-- Lua支持变长参数，变长参数使用 ... 表示，一个函数可以同时拥有固定参数和变长参数，变长参数只能有一个，并且必须在所有的固定参数后面。
-- 遍历变长参数的方式有：
--      1）通过 for i, v in ipairs({...}) do 的方式遍历，这种方式在遇到变长参数中有nil值的时候，将终止后续参数的遍历；
--      2）通过 select 函数 遍历。select('#', ...) 将返回变长参数的个数，select(i, ...) 将返回第i个变长参数。这种方式的优点是不会在遇到nil时终止遍历
-- 下面定义一个遍历变长参数的函数
function iterParams(a, ...)
    local p1, p2, p3 = a, ...                  --  变长参数 ... 类似于一个具有多重返回值的函数
    print("", "p1 = " .. tostring(p1) .. ", p2 = " .. tostring(p2) .. ", p3 = " .. tostring(p3))

    print("", "使用 ipairs({...}) 遍历：")
    for i, v in ipairs({...}) do            -- 使用 ipairs({...}) 遍历变长参数，这种方式在遇到变长参数中有nil值的时候，将终止后续参数的遍历
        print("", "", "index = " .. tostring(i) .. ", value = " .. tostring(v))
    end

    print("", "使用 select('#', ...) 遍历：")
    for i = 1, select('#', ...) do      -- 使用函数 select 遍历变长参数
        local v = select(i, ...)
        print("", "", "index = " .. tostring(i) .. ", value = " .. tostring(v))
    end
end

params = {"a", "b", nil, "c"}
iterParams(1, 2, "a", "b", nil, "c")   -- 遍历到nil后就不再


------------------------------------ 闭包 ----------------------------------
print("闭包")
-- 一个函数可以在另一个函数内部声明，这个位于内部的函数可以访问外部函数中的局部变量，这项特征称为“词法域”
-- 类似Javascript，Lua函数也支持闭包，如下所示：
function newCounter()
    local i = 0
    return function ()
        i = i + 1
        return i;
    end
end
c = newCounter();
print("", "newCounter", c(), c())


------------------------------------ 非全局的函数 ----------------------------------
print("非全局的函数")
-- 函数在Lua中作为第一类值，不仅可以存储在全局变量中，还可以存储在table和局部变量中，例如：
do
    local f = function(a)
        return a
    end
    print("", "f(1) = " .. tostring(f(1)))
end
-- print("", "f(1) = " .. tostring(f(1)))       -- 因为函数f存储在局部变量中，所以此处无法调用函数f

-- 递归定义局部函数时有个容易犯错的地方，如下所示：
local failedFact = function(n)
    return (n == 0 and 1) or (n * fact(n - 1))      -- 此处会报错，因为局部的fact还未定义完，因此，此处将调用全局的fact函数
end
-- print("", "failedFact(3) = " .. failedFact(3))       -- 调用fact将报错
-- 正确的写法有两种：1）将failedFact定义成全局变量（即去掉local关键字）；2）先定义局部变量fact，然后再定义函数本身，如下所示：
local fact
fact = function(n)
    return (n == 0 and 1) or (n * fact(n - 1))           -- (a and b) or c 等价于Javascript中的 a ? b : c
end
print("", "fact(3) = " .. fact(3))

-- 局部函数定义的语法糖（即 local function name() 这种定义方式）不会存在上述递归调用的问题，因为Lua在展开局部函数定义的“语法糖”时，就是先声明的局部函数，然后再定义的函数体，如：
local function sugarFact(n)
    return (n == 0 and 1) or (n * sugarFact(n - 1))
end
print("", "sugarFact(3) = " .. sugarFact(3))


------------------------------------ 正确的尾调用 ----------------------------------
-- Lua支持尾调消除，尾调消除是一种类似goto的函数调用，即直接跳转到函数调用处，不会保存调用源头的调用堆栈，与闭包的特征相反。
-- 尾调消除的一个优点是：如果是递归调用或嵌套调用，普通的函数调用将花费很大的空间去记录递归调用的堆栈信息，而尾调消除则可以免去这些堆栈的空间耗用
-- 判断正确的尾调消除的方法：一个函数在调用用另一个函数后，是否就无其他事情需要做了。如果再无其他事情可做，另一个函数的调用就可以称为尾调用
-- 尾调用的一些特征：
--      1）必须是return子句中的函数调用；
--      2）return中只能有函数调用，不能包含对函数返回值进行运算的表达式，如 return 1 + f(x)；
--      3）自调用本身的参数可以是非常复杂的，并且可以引用其他的局部变量，如：function f(x) return g(a * b, i + j)
function foo(n)
    if (n > 0) then return foo(n - 1) end       -- foo(n - 1) 是一个正确的尾调用
end
-- 下面是几个非正确的尾调用
function f(x) g(x) end                              -- g(x)不是一个正确的尾调用，因为函数f(x)在调用了g(x)后并不能立即返回，它还需要丢弃g(x)返回的临时结果
function f(x) return 1 + g(x) end                   -- g(x)也不是一个尾调用，因为在返回之前还必须做一次加法
function f(x) return x or g(x) end                  -- g(x)也不是一个尾调用，必须调整为一个返回值
function f(x) return (g(x)) end                     -- g(x)也不是一个尾调用，必须调整为一个返回值