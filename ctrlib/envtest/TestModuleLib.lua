#!/usr/bin/lua
TestModuleLib = {}

local function localFunction()
    print("TestModuleLib - localFunction")
    return ("A VALUE")
end


function TestModuleLib:tableFunc()
    print("TestModuleLib:tableFunc()")
end

function TestModuleLib:new()
    setmetatable({},TestModuleLib)

    print("TestModuleLib:new()")
    self.param = "PARAM1"
    self.lf = localFunction()
    self.lf2 = function() localFunction() end
    return self
end


tmLib = TestModuleLib:new()



--[[

    TestModuleLib = {}
    
    function globalFunction()
        print("TestModuleLib:GlobalFunction")
    end
    
    local function localFunction()
        print("TestModuleLib:LocalFunction")
    end
    
    
    
    
    return {
        globalFunction = globalFunction,
        localFunction = localFunction
    }
]]--