local unicode = require("unicode")
local os =require("os")

function testIsWide(times)
    local oldClock = os.clock()

    local test1 = 0
    for i = 1,times do
        test1 = unicode.isWide("中")
        test1 = unicode.isWide("1")
    end
    print("os.clock() delta: " .. (os.clock() - oldClock))
end

function testWlen(times)
    local oldClock = os.clock()

    local test1 = 0
    for i = 1,times do
        test1 = unicode.wlen("中")
        test1 = unicode.wlen("1")
    end
    print("os.clock() delta: " .. (os.clock() - oldClock))
end

function testTable1(times)
    local oldClock = os.clock()

    local charTable = {}
    charTable["中"] = 2
    charTable["文"] = 2
    charTable["是"] = 2
    charTable["否"] = 2
    charTable["1"] = 1
    local test1 = 0
    for i = 1,times /2 do
        test1 = charTable["中"]
        test1 = charTable["1"]
    end
    for i = 1,times /2 do
        test1 = charTable["否"]
        test1 = charTable["是"]
    end
    print("os.clock() delta: " .. (os.clock() - oldClock))
end
function testTable2(times)
    local oldClock = os.clock()

    local charTable = {}
    charTable["中"] = unicode.wlen("中")
    charTable["文"] = unicode.wlen("文")
    charTable["是"] = unicode.wlen("是")
    charTable["否"] = unicode.wlen("否")
    charTable["1"] = unicode.wlen("1")
    local test1 = 0
    for i = 1,times /2 do
        test1 = charTable["中"]
        test1 = charTable["1"]
    end
    for i = 1,times /2 do
        test1 = charTable["否"]
        test1 = charTable["是"]
    end
    print("os.clock() delta: " .. (os.clock() - oldClock))
end

function testTable3(times)
    local oldClock = os.clock()

    local charTable = {}
    charTable["中"] = unicode.wlen("中")
    charTable["文"] = unicode.wlen("文")
    charTable["是"] = unicode.wlen("是")
    charTable["否"] = unicode.wlen("否")
    local test1 = 0
    for i = 1,times /2 do
        if charTable["中"] then
        end
        if charTable["1"] then
        end

    end
    for i = 1,times /2 do
        if charTable["是"] then
        end
        if charTable["否"] then
        end
    end
    print("os.clock() delta: " .. (os.clock() - oldClock))
end

function test(times)
    print("test "..times.." times")
    testIsWide(times)
    os.sleep(1)
    testWlen(times)
    os.sleep(1)
    testTable1(times)
    os.sleep(1)
    testTable2(times)
    os.sleep(1)
    testTable3(times)
    os.sleep(1)
end

test(10000)
test(50000)
test(100000)



