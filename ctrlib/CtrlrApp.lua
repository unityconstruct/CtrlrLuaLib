#!/usr/bin/lua
local ctrlrEnv = require 'ctrlib.CtrlrEnv'
local dataUtils = require 'ctrlib.utils.DataUtils'
local SysexP2K = require 'ctrlib.data.SysexP2K'
local SysexParser = require 'ctrlib.utils.SysexParser' -- instantiate via function call - LOCAL
-- local sysexUtils = require 'ctrlib.utils.SysexParser' -- instantiate via function call - LOCAL

print("CtrlrApp: HI! Ctrlr")


-- syx = SysexParser {}
-- . syntax
-- sysexUtils.globalFunction()
-- sysexUtils.localFunction()
-- SysexParser.globalFunction()
-- SysexParser.localFunction()
-- : syntax
-- sysexUtils:globalFunction()
-- sysexUtils:localFunction()
-- SysexParser:globalFunction()
-- SysexParser:localFunction()


local function test1()
    print("CtrlrApp:test1{}")
    SysexParser.globalFunction()
end

test1()



--[[ SetupDump_1C tests ]]--
-- instantiate the utility object that: holds sysex Specs and incoming message dumps
-- local sysexUtils = sysexParser:new()
-- local sysexUtils = SysexParser.SysexDumps:new()
local sysexP2KDumps = SysexP2K.SysexDumps
--[[
    ]]--
-- update the util with a SetupDump message
sysexP2KDumps.SysexSetupDump_1C = SysexParser.parseSyxToTable(SysexParser.sysexMessageSetupDump)
-- now search the same SetupDumpSpec_1C in the utility
local result = SysexParser.fetchSysexParam2Byte(sysexP2KDumps.SysexSetupDump_1C,sysexP2KDumps.SysexSetupDumpSpec_1C.MIDI_A_CONTROL)
-- local sortedTable = tableSort(sysexUtils.SetupDumpSpec_1C)


-- fetchDumpToValueTable test that scans sysexdump using DumpSpec, then create valueTable for each Parameter Field
-- local valueTable = fetchDumpToValueTable(sysexUtils.SysexSetupDump_1C, SysexSetupDumpSpec_1C)
local valueTable = SysexParser.fetchDumpToValueTable(sysexP2KDumps.SysexSetupDump_1C, sysexP2KDumps.SysexSetupDumpSpec_1C)
SysexParser.printValueTable(valueTable)



--[[ DEBUG HALT ]]--

local stop = "STOP!"









return {
    test1 = test1
}



-- local CtrlrEnv = require "CtrlrEnv"




-- CtrlrPanel = {}
-- function CtrlrPanel.Test()
-- end
-- return CtrlrPanel
