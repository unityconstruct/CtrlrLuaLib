#!/usr/bin/lua
CtrlrEnv = {}

function test1()
    print("CtrlrEnv: Test1")
end

print("CtrlrEnv: HI! Ctrlr")

return CtrlrEnv

-- if false then -- For LuaDoc
--     ---
--     --- utilty classes for mocking Ctrlr
--         module "CtrlrModulator"
-- end

-- require "ctrlrmocks.CtrlrPanel.lua"
-- local CtrlrModulator = require"CtrlrPanel"