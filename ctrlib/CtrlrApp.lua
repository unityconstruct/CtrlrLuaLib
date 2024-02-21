#!/usr/bin/lua
local ctrlrEnv = require 'ctrlib.CtrlrEnv'
local sysexParser = require 'ctrlib.utils.SysexParser'
local dataUtils = require 'ctrlib.utils.DataUtils'

local function test1()
    print("CtrlrApp:test1{}")
end

print("CtrlrApp: HI! Ctrlr")

return {
    test1 = test1
}



-- local CtrlrEnv = require "CtrlrEnv"




-- CtrlrPanel = {}
-- function CtrlrPanel.Test()
-- end
-- return CtrlrPanel
