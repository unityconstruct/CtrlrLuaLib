-- assign global vars
function initGlobals()

    -- || F0 || 18 0F | 00 55 || 01 02 || F7 ||
    EMU_HEADER = "F0 18 0F"  -- E-MU Header
    local MIDI_ID = "00"     -- Midi Device ID
    local SpecialDesignator = "55"
    SYSEX_PRE = string.format('%s %s %s', EMU_HEADER, MIDI_ID, SpecialDesignator)
    SYSEX_EOX = "7F"
    SYSEX_PARAMSET = "01 02"
  
    print(tostring(SYSEX_PRE))
  
  
  
    -- buttons for channels
    -- table of channel buttons so their ToggleState can be managed
    channels = {}
    channels[1]  = "btn-ch01"
    channels[2]  = "btn-ch02"
    channels[3]  = "btn-ch03"
    channels[4]  = "btn-ch04"
    channels[5]  = "btn-ch05"
    channels[6]  = "btn-ch06"
    channels[7]  = "btn-ch07"
    channels[8]  = "btn-ch08"
    channels[9]  = "btn-ch09"
    channels[10] = "btn-ch10"
    channels[11] = "btn-ch11"
    channels[12] = "btn-ch12"
    channels[13] = "btn-ch13"
    channels[14] = "btn-ch14"
    channels[15] = "btn-ch15"
    channels[16] = "btn-ch16"
    -- diags
    -- p(tostring(#channels))
    -- p(tostring(channels[1]))
  
    -- buttons for mix busses
    mixes = {}
    mixes[1] = "btnMix-1"
    mixes[2] = "btnMix-2"
    mixes[3] = "btnMix-3"
    mixes[4] = "btnMix-4"
    mixes[5] = "btnMix-P"
  
    -- sliders for 16 controllers
    controllers = {}
    controllers[1] = "controller-1"
    controllers[2] = "controller-2"
    controllers[3] = "controller-3"
    controllers[4] = "controller-4"
    controllers[5] = "controller-5"
    controllers[6] = "controller-6"
    controllers[7] = "controller-7"
    controllers[8] = "controller-8"
    controllers[9] = "controller-9"
    controllers[10] = "controller-10"
    controllers[11] = "controller-11"
    controllers[12] = "controller-12"
    controllers[13] = "controller-13"
    controllers[14] = "controller-14"
    controllers[15] = "controller-15"
    controllers[16] = "controller-16"
  end
  
  -- sysex messaging data helper object
  SysEx = { id = "SysEx" }
  
  -- transforms SysEx table in to a psuedo class
  function SysEx:new ()
    setmetatable({},SysEx) -- this is what does the transform
  
    self.SYSEX_SOX = "F0"
    self.SYSEX_EOX = "F7"
    self.EMUHeader = "F0 18 0F"
    self.MidiID = "00"
    self.SpecialDesignator = "55"
    self.SYSEX_PRE = "F0 18 0F 00 55"
    self.SYSEX_COMMAND_PARAM_SET = "01 02"
    self.SYSEX_COMMAND = "00 00 00"
    self.SYSEX_897 = "01 07" 
    self.SYSEX_897_PresetSelect = "01 07"
    self.SYSEX_898 = "02 07"
    self.SYSEX_898_LayerSelect = "02 07"
  
    return self
  end
  
  
  
  
  function SysEx:addCommand(hexstring)
      setmetatable({},SysEx)
      self.SYSEX_COMMAND = tostring(hexstring)
  end
  
  syx = SysEx:new()
  --print(syx.SYSEX_EOX)
  --syx:addCommand("00 11 FF")
  --print(syx.SYSEX_COMMAND)
  
  
  --[[
  function buildSysexTable()
      local t = {
          EMUHeader = "F0 18 0F",
          MidiID = "00",
          SpecialDesignator = "55",
          SYSEX_PRE = "F0 18 0F 00 55",
          SYSEX_EOX = "F7",
          SYSEX_PARAM_SET = "01 02",
          SYSEX_897 = "01 07" ,
          SYSEX_897_PresetSelect = "01 07",
          SYSEX_898 = "02 07",
          SYSEX_898_LayerSelect = "02 07"
      }
      return t
  end
  ]]--
  
  --local tbl = buildSysexTable()
  --print(tbl.SYSEX_PRE)
  
  
  function p(valueString)
    console(tostring(valueString))
  end
  
  -- print contents of a table
  -- console call: initGlobals() ; printGlobals(channels)
  function printGlobals(valueTable)
    p(#valueTable)
    for i=1,#valueTable,1 do
      p(i .. ": " .. valueTable[i])
      p(panel:getComponent(valueTable[i]):getToggleState())
    end
  end
  
  
  function printGlobalsChannels()
    p(#channels)
    for i=1,#channels,1 do
      p(i .. ": " .. channels[i])
      p(panel:getComponent(channels[i]):getToggleState())
    end
  end
  