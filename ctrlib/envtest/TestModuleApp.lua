
require 'ctrlib.envtest.TestModuleLib'
require 'ctrlib.envtest.SysexP3K'
--local TestModuleLib = require 'ctrlib.TestModuleLib'
--local TestModuleLib = require 'TestModuleLib'
--require 'TestModuleLib.lua'
syx = sys


function TestModuleApp()
    --pause("debugging")
    print(tmLib.param)
    print(tmLib.lf)
    print(tmLib.lf2())
    print(tostring(sys.ROMS.XL7))
    
    print(string.format('%.2x',sys.DEVICE_ID))
    print(string.format('%.2x',sys.DEVICE_MEMBERS.HaloLSB))

    --sysp2k = SysexP2K.build()
    --print(tostring(sysp2k.DEVICE_ID))
    --print(tmLib2.param)
    --print(tmLib2.lf)
    --print(tmLib2.lf2())
end

TestModuleApp()

print("STOP")

--[[

    local TestModuleLib = require 'ctrlib.TestModuleLib'
    
    
    function useTestModuleLib()
        TestModuleLib.globalFunction()
        TestModuleLib.localFunction()
    end
    
    useTestModuleLib()
]]--