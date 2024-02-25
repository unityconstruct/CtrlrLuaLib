#!/usr/bin/lua
local ctrlrEnv = require 'ctrlib.CtrlrEnv'
local dataUtils = require 'ctrlib.Utils.DataUtils'
local SysexP2K = require 'ctrlib.Data.SysexP2K'
local SysexParser = require 'ctrlib.Utils.SysexParser' 

function MockComponents()
    
end

MockComponents = {}
---build a table of mock components
---@return table
function MockComponents:buildMockComponents()
    setmetatable({},MockComponents)

    mockComponents = {}
    mockComponent = {
        id = "",
        name = "",
        value = 0,
        loc = 0
    }

    -- build component data store
    -- for i=0,476-1,1 do
    --     mockComponents[i] = mockComponent{
    --         id = i,
    --         name = string.format("component_%d",i),
    --         value = i*2,
    --     }
    -- end

    -- now add component values to data store


    for name,loc in pairs(SysexP2K.SysexDumps.SysexSetupDumpSpec_1C) do
        local comp = mockComponent

        comp.name = name
        local result = getStringMatchToEnd(name,"_")
        if #result > 0 and result ~= nil then 
            comp.id = result 
        else 
            comp.id = "" 
        end
        comp.loc = loc
        comp.value = math.random(0,127)
        string.format('%-40s : %-5s : %-5s : %-5d',comp.name, comp.id, comp.loc, comp.value)
        mockComponents[#mockComponents+1] = comp
    end

    return mockComponents
end

mocks = MockComponents:buildMockComponents()