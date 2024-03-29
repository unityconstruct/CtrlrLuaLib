
local dump = "F0180F00550A010100F7"

local RequestsTable = {}
function RequestsTable:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self
  -- identity request
  self.IdentityRequest = "F07E000601F7"
  self.IdentityResponse = "F07E0006021804040D00322E3030F7"
  self.HardwareConfigurationRequest = "F0180F00550AF7"
  self.HardwareConfigurationResponse = "F0180F00550902000401060E0000043B09F7"
  self.SetupDumpResponse = {}
  self.SetupDumpAck = {}
  self.SetupDumpResponse[0] = "F0180F0055 10 0164005E0B0000380013001000140004001F0003000A002A0048000000F7"
  self.SetupDumpAck[0]     = "F0180F0055 7F 0000 F7"
  self.SetupDumpResponse[1] = "F0180F0055 10 0201006869743A44616E6365203231202020207F000000000000000000500000003C0000001E00000000003C0004000E0000002E00620064002F00630064000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F000000070021000A00000001000100070000000000000000000000000000007F007F7F0E00000001002800600000000A000000000001000000030000000A0000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E00650400005EF7"
  self.SetupDumpAck[1]     = "F0180F0055 7F 0100 F7"
  self.SetupDumpResponse[2] = "F0180F0055 10 02020000000000000000007F000000000000007F000000000000007F000000000000002600000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C003800000029001DF7"
  self.SetupDumpAck[2]     = "F0180F0055 7F 0200 F7"
  self.SetupDumpResponse[3] = "F0180F0055 10 020300330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000006F7"
  self.SetupDumpAck[3]     = "F0180F0055 7F 0300 F7"
  self.SetupDumpResponse[4] = "F0180F0055 10 02040014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F01000000000001000100000064000000640059F7"
  self.SetupDumpAck[4]     = "F0180F0055 7F 0400 F7"  
  self.SetupDumpResponse[5] = "F0180F0055 10 020500140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F00000052F7"
  self.SetupDumpAck[5]     = "F0180F0055 7F 0500 F7"
  self.SetupDumpResponse[6] = "F0180F0055 10 020600000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068003DF7"
  self.SetupDumpAck[7]     = "F0180F0055 7F 0600 F7"
  self.SetupDumpResponse[7] = "F0180F0055 10 0207000C006000300000002C00380106002D00300026002D002F00060016000800640000000000000000000000000000000000000011F7"
  self.SetupDumpAck[8]     = "F0180F0055 7F 0700 F7"
  self.SetupDumpResponse[8] = "F0180F0055 7B F7"


  return self
end


function removeSpaces(string)
  local result = string.gub(string," ","")
  return result
end




--[[ DataUtils Object as a Table: START ]]--
local DataUtils = {}
function DataUtils:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self

  --- runc a function in protected mode: essentially try/catch
  ---@param func function - function to invoke using pcall(FUNCITON,ARGS)
  ---@return boolean, string - . true/false result + status message Success/Fail
  self.tryCatchFunc = function(func,...)
    local msg
    local isSuccess = false
    if((#... == 0) == true) then     -- NO arguments
      if pcall(func) then
          msg = "Success"
          isSuccess = true
      else
        msg = "Fail"
      end
    else                   -- WITH arguments
      if pcall(func,arg) then
        msg = "Success"
        isSuccess = true
      else
        msg = "Fail"
      end
    end
    return isSuccess, msg
  end


--[[ output utils ]]--

  --- output to console support for BOTH native Lua print() & Ctrlr console()
  --- attempts output to console using proected function call[pcall(fname,args..)] with print(), if error, then try console()
  --- using this func for ALL console out allows for switching based on env(Ctlr vs IDE)
  --- Ctrlr uses console() Lua lang uses print()
  --- Attempts print(), if error then try console()
  ---@param value any - string to output to call
  self.p = function (value)
    if (pcall(print,tostring(value))) then
    else pcall(console,tostring(value))
    end
  end


--[[ string ]]--

  --- converts anything to a string
  --- @param value string
  --- @return string 
  self.ToString = function(value)
    return tostring(value)
  end

  --- coverts table to delimited string
  --- @param valueTable table table to convert to string
  --- @param separator string separator character
  --- @return string
  self.TableToStringWithDelimiter = function(valueTable,separator)
    return table.concat(valueTable,separator)
  end

  --- coverts table to delimited string using separator ","
  --- @param valueTable table
  --- @return string
  self.TableToString = function(valueTable)
    return self.TableToStringWithDelimiter(valueTable,",")
    end


--[[ string searching ]]--

  ---search a string for string value
  ---@param haystack any - value to search in
  ---@param needle any - value to search for
  ---@param startAt any - start index in the haystack
  ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
  ---@return boolean - . return true if needle is found in haystack
  self.isContains = function(haystack,needle,startAt,boolPlain)
    startAt = startAt or 1
    boolPlain = boolPlain or true
    local found = string.find(haystack,needle,startAt,boolPlain)
    if (found == nil) then
        return false
    else
        return true
    end
  end

  ---search a string for string value
  ---@param haystack any - value to search in
  ---@param needle any - value to search for
  ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
  ---@return boolean - . return true if needle is found in haystack
  self.isStartsWith = function(haystack,needle,boolPlain)
    boolPlain = boolPlain or true
    local starts = string.find(haystack,needle,1,boolPlain)
    if (starts == nil) then
        return false
    else
        if starts == 1 then
          return true
        else return false end
    end
  end

  ---check that haystack ends with needle
  ---@param haystack any - value to search in
  ---@param needle any - value to search for
  ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
  ---@return boolean - . return true if haystack ends with needle
  self.isEndsWith = function(haystack,needle,boolPlain)
    local haystackSize = #haystack
    local needleSize = #needle
    local start = haystackSize - needleSize +1 -- +1 = offset
    boolPlain = boolPlain or true

    local starts = string.find(haystack,needle,start,boolPlain)
    if (starts == nil) then
        return false
    else
        if (starts == start) then
          return true
        else return false end
    end
  end

  --[[ hex formatting ]]--

  ---convert single hex byte to integer ( does it handle multiple bytes?)
  ---@param hex string - hexString value
  ---@param base integer - base value for converting the hexString
  ---@return integer - integer value for provided hex value
  self.hex2int = function(hex,base)
    base = base or 16
    return tonumber(hex,base)
  end

  ---convert single hex byte to integer ( does it handle multiple bytes?)
  ---@param hex string - hexString value
  ---@return integer - integer value for provided hex value
  self.hex2IntBase16 = function(hex)
    return self.hex2int(hex,16)
  end

  self.formatValueToHex128 = function(value,length)
    length = length or -2
    local hexString
    if (value < 0) then
      hexString = string.format("%.2x",value):sub(length)
    else 
      hexString = string.format("%.2x",value)
    end
    --local hexString = string.format("%.2x",value):sub(length)
    local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ",value, hexString)
    return hexString, msg
  end

  self.formatValueToHex256 = function(value,length)
    length = length or -2
    local hexString
    if (value < 0) then
      hexString = string.format("%.2x",value):sub(length)
    else 
      hexString = string.format("%.2x",value)
    end
    --local hexString = string.format("%.2x",value):sub(length)
    local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ",value, hexString)
    return hexString, msg
  end

  self.formatValueToHex1024 = function(value,length)
    length = length or -8
    local hexString
    if (value < 0) then
      hexString = string.format("%.4x",value):sub(length)
    else 
      hexString = string.format("%.4x",value)
    end
    --local hexString = string.format("%.2x",value):sub(length)
    local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ",value, hexString)
    return hexString, msg
  end

  self.Int2Hex128 = function(valueInt128)
    return string.format("%2.x",valueInt128)
  end

  self.Int2Hex2Byte = function(valueInt256)
    return string.format("%04x",valueInt256)
  end


  self.Int2Char = function(value)
    return string.char(value)
  end


  --[[ Nibblize ]]--

  self.nibblize14bit = function(nibbleInt)
    local nibbleTable = {}
    local msg = "Nibblize: value: " .. nibbleInt
    -- negative values need [2's complement]
    if (nibbleInt < 0) then
        nibbleInt = nibbleInt + 16384
    end
    msg = msg .. "\n" .. "Nibblize: value after negative check/adjust: " .. nibbleInt
    --- @type integer - value stored in first byte. modulus removes the msb from the value
    local lsb = nibbleInt % 128
    --- @type integer - value stored in second byte. divide revmoes the lsb from the value
    local msb = math.floor(nibbleInt / 128)
    nibbleTable.msb = msb
    nibbleTable.lsb = lsb
    return nibbleTable, msg
  end

  self.nibblize14bitToHexString = function(nibbleInt)
    local nibbleTable = self.nibblize14bit(nibbleInt)
    local hexstring = string.format("%s %s", self.formatValueToHex256(nibbleTable.lsb), self.formatValueToHex256(nibbleTable.msb) )
    local msg = string.format("Nibblized to Hexstring: Value:[%d] MSB:[%d] LSB:[%d] HexString:[%s]",
      nibbleInt, nibbleTable.lsb, nibbleTable.msb, hexstring)
    return hexstring, msg
  end

  --- nibblize a value into msb and lsb
  --- @param value integer to process
  --- @return table return table with msb,lsb
  self.Nibblize = function(value)
    local nibble = {}
    
    -- negative values need [2's complement]
    if (value < 0) then
        value = value + 16384
    end

    local lsb = math.floor(value % 128)
    local msb = math.floor(value / 128)
    -- nibble.lsb = lsb
    -- nibble.msb = msb
    nibble[1] = lsb
    nibble[2] = msb
    return nibble

  end

  --- convert a nibble(lsb/msb) to integer value
  --- @param lsb integer 
  --- @param msb integer 
  --- @return integer value
  self.DeNibblizeLSBMSB = function(lsb,msb)
    local value
    local rawValue = (msb * 128) + lsb

    -- if number is greate than 8192, its a negative value
    if (rawValue >= 8192 ) then
        value = 8192-16257
    else
        value = rawValue
    end
    
    return value
  end

  --- convert a nibble(msb/lsb) to integer value
  --- @param nibble table
  --- @return integer value
  self.DeNibblizeTable = function(nibble)
    if ( #nibble == 2 ) then
        return self.DeNibblizeLSBMSB(nibble[1], nibble[2])
    else
        return 0
    end
  end


  --[[ bin/dec ]]--

  ---convert a binary represented as string to decimal using specified base
  --- base would normally be '2' for binary string
  ---@param binaryString string binary number represented as a string
  ---@param base integer base used for conversion
  ---@return integer .return converted decimal number
  self.bin2decString = function(binaryString, base)
    return tonumber(binaryString, base)
  end

  ---convert a binary represented as string to decimal using base 2
  ---@param binNum string binary number represented as a string
  ---@return integer .return converted decimal number
  self.bin2decInt = function(binNum)
    return bin2dec(binNum, 2)
  end


  --[[ bool/string ]]--

  --- convert boolean to string
  ---@param valueBoolean boolean boolean to parse
  ---@return string . returns 0 if false, 1 if true
  self.boolToStr = function(valueBoolean)
    if valueBoolean == true then
      return "1"
    else
      return "0"
    end
  end

  ---convert string to boolean
  ---@param valueString string string to parse
  ---@return boolean . returns true if 1/"true", false if 0/"false"
  self.strToBool = function(valueString)
    if valueString == "1" or valueString == "true" then
      return true
    else
      return false
    end
  end

  self.dec2bin = function(decNum)
    local t = {}
    local i
      for i = 7, 0, -1 do
        t[#t + 1] = math.floor(decNum / 2^i)
        decNum = decNum % 2^i
      end
    return table.concat(t)
  end


  return self
end
--[[ DataUtils Object as a Table: END ]]--



local DeviceModel = {}
---NOT USED PoC block
---@param o any
---@return table
function DeviceModel:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self

  self.du = DataUtils:new()
  self.returnHex2Integer = function(hexString) return self.du.hex2IntBase16(hexString) end
  self.returnInteger2Hex255 = function(intNum) return self.du.Int2Hex2Byte(intNum) end

  self.myFunction = function() 
    return string.format("My Property is Hella %s!",self.myProperty) end
  return self
end

--[[ PoC model for creating a request tables that can be used to creat messages or parse responses ]]--
--[[ RequestModel holding ALL requests & builder/util functions: START ]]--

---@table
local RequestModel = {}
---instantiate a new RequestModel Table
---@param o any
function RequestModel:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self
  self.du = DataUtils:new()
  -- values for midi message type
  ---@type table<string,string>
  self.requestTypeEnum = {
      SysexNonRealtime = "F07E",
      Sysex = "F0aa0Fbbcc",
      SysexProteus = "F0180F0055",
      CC = "b0 00 aa",
      CC_0 = "b0 00 00",
      CC_32 = "b0 20 00",
      Bank = "c0 20 aa",
      Bank_0 = "c0 20 00",
      Bank_1 = "c0 20 01"
  }

  do -- handshaking
    self.ACK = {}
    self.ACK[0] = {"7F","Mask"}
    self.ACK[1] = {"7F","Command"}
    self.ACKClosedLoopwithPacketCounter = {}
    self.ACKClosedLoopwithPacketCounter[0] = {"7Faaaa","Mask"}
    self.ACKClosedLoopwithPacketCounter[1] = {"7F","Command"}
    self.ACKClosedLoopwithPacketCounter[2] = {"aaaa",""}
    self.NAK = {}
    self.NAK[0] = {"7Eaaaa","Mask"}
    self.NAK[1] = {"7E","Command"}
    self.NAK[2] = {"aaaa",""}
    self.CANCEL = {}
    self.CANCEL[0] = {"7D","Mask"}
    self.CANCEL[1] = {"7D","Command"}
    self.WAIT = {}
    self.WAIT[0] = {"7C","Mask"}
    self.WAIT[1] = {"7C","Command"}
    self.EOF = {}
    self.EOF[0] = {"7B","Mask"}
    self.EOF[1] = {"7B","Command"}
  end

  do -- sysex non-realtime
    self.MasterVolume = {}
    self.MasterVolume[0] = {"7Eid0401aaaa","Mask"}
    self.MasterVolume[1] = {"04","Command"}
    self.MasterVolume[2] = {"01","SubCommand"}
    self.MasterVolume[3] = {"aaaa","volumelevel"}
    self.DeviceInquiry = {}
    self.DeviceInquiry[0] = {"7Eid0601","Mask"}
    self.DeviceInquiry[1] = {"06","Command"}
    self.DeviceInquiry[2] = {"01","SubCommand"}

    self.DeviceInquiryResponse = {}
    self.DeviceInquiryResponse[0] = {"7Eid060218aaaabbbbcccccccc","Mask"}
    self.DeviceInquiryResponse[1] = {"06","Command"}
    self.DeviceInquiryResponse[2] = {"02","SubCommand"}
    self.DeviceInquiryResponse[3] = {"18","Manufacturers System Exclusive Id code"}
    self.DeviceInquiryResponse[4] = {"aaaa","Device Family code"}
    self.DeviceInquiryResponse[5] = {"bbbb","Device Family Member Code"}
    self.DeviceInquiryResponse[6] = {"cccccccc","Software Revision Level (4 ASCII char)"}
    self.DeviceInquiryResponseData = {}
  end

  do -- Program Change
    self.ProgramChangePresetMapDumpResponse = {}
    self.ProgramChangePresetMapDumpResponse[0] = {"16aa[256]bb[256]","Mask"}
    self.ProgramChangePresetMapDumpResponse[1] = {"16","Command"}
    self.ProgramChangePresetMapDumpResponse[2] = {"aa",""}
    self.ProgramChangePresetMapDumpResponse[3] = {"[256]","<256 Data Bytes Preset Numbers>"}
    self.ProgramChangePresetMapDumpResponse[4] = {"bb",""}
    self.ProgramChangePresetMapDumpResponse[5] = {"[256]","<256 Data Bytes Preset ROM ID Numbers>"}
    self.ProgramChangePresetMapDumpRequest = {}
    self.ProgramChangePresetMapDumpRequest[0] = {"17","Mask"}
    self.ProgramChangePresetMapDumpRequest[1] = {"17","Command"}
  end

  do -- parameter request/response 
    self.ParameterEditRequest = {}
    self.ParameterEditRequest[0] = {"0102aaaabbbb","Mask"}
    self.ParameterEditRequest[1] = {"01","Command"}
    self.ParameterEditRequest[2] = {"02","SubCommand"}
    self.ParameterEditRequest[3] = {"aaaa","Parameter ID (LSB first)"}
    self.ParameterEditRequest[4] = {"bbbb","Parameter Data"}
    --[[
        -- self.ParameterEditRequestCommands = {}
        -- self.ParameterEditRequestCommands[0] = {"0102aaaabbbb","Mask"}
        -- self.ParameterEditRequestCommands[1] = {"01","Command"}
        -- self.ParameterEditRequestCommands[2] = {"02","SubCommand"}
        -- self.ParameterEditRequestCommands[3] = {"aaaa","ParamId"}
        -- self.ParameterEditRequestCommands[4] = {"bbbb","ParamValue"}
    ]]--

    self.ParameterValueRequest = {}
    self.ParameterValueRequest[0] = {"0201aaaa","Mask"}
    self.ParameterValueRequest[1] = {"02","Command"}
    self.ParameterValueRequest[2] = {"01","SubCommand"}
    self.ParameterValueRequest[3] = {"aaaa","Parameter ID (LSB first)"}

    self.ParamMinMaxDefaultValueRequest = {}
    self.ParamMinMaxDefaultValueRequest[0] = {"04aaaa","Mask"}
    self.ParamMinMaxDefaultValueRequest[1] = {"04","Command"}
    self.ParamMinMaxDefaultValueRequest[2] = {"aaaa","Parameter ID"}

    self.ParamMinMaxDefaultValueResponse = {}
    self.ParamMinMaxDefaultValueResponse[0] = {"03aaaabbbbccccddddee","Mask"}
    self.ParamMinMaxDefaultValueResponse[1] = {"03","Command"}
    self.ParamMinMaxDefaultValueResponse[2] = {"aaaa","Parameter ID"}
    self.ParamMinMaxDefaultValueResponse[3] = {"bbbb","Parameter minimum value"}
    self.ParamMinMaxDefaultValueResponse[4] = {"cccc","Parameter maximum value"}
    self.ParamMinMaxDefaultValueResponse[5] = {"dddd","Parameter default value"}
    self.ParamMinMaxDefaultValueResponse[6] = {"ee","Read Only (0 = Read/Write, 1 = Read Only, values above 1 reserved)"}

  end

  do -- Hardware Configuration
    ---@type table<string,string>
    self.HardwareConfigurationRequest = {}
    self.HardwareConfigurationRequest[0] = {"0A","Mask"}
    self.HardwareConfigurationRequest[1] = {"0A","Command"}
    
    ---@type table <table<string,string>>
    self.HardwareConfigurationResponse = {}
    self.HardwareConfigurationResponse[0] = {"09aabbbbccddeeeeffffgggg","Mask"}
    self.HardwareConfigurationResponse[1] = {"09","Command"}
    -- 02 0004 01 06 0E00 0004 3B09
    self.HardwareConfigurationResponse[2] = {"aa","Number of General Information Bytes"}
    self.HardwareConfigurationResponse[3] = {"bbbb","Number of User Presets"}
    --- simm data iterator
    self.HardwareConfigurationResponse[4] = {"cc","Number of Simms Installed"}
    self.HardwareConfigurationResponse[5] = {"dd","Number of Information Bytes per Sim"}
    -- set
    self.HardwareConfigurationResponse[6] = {"eeee","Simm ID"}
    self.HardwareConfigurationResponse[7] = {"ffff","Number of Sim Presets"}
    self.HardwareConfigurationResponse[8] = {"gggg","Number of Sim Instruments"}

    ---Contract that stores first/last indices for each field in a response
    ---@type table
    self.HardwareConfigurationDataContract = {
      ---@type string 
      MaskMessage = "09aabbbbccddeeeeffffgggg",
      ---@type string 
      MaskSimmObjects = "eeeeffffgggg",
      ---@type string 
      Command = "09",
      ---@type table<integer,integer>
      GeneralInfoBytes = {},
      ---@type table<integer,integer>
      UserPresetCount = {},
      ---@type table<integer,integer>
      SimmCount = {},
      ---@type table<integer,integer>
      SimmBytePer = {},
      ---@type integer
      SimmsTableStartPointer = 0,
      ---@type table<table<integer,integer>>
      SimmsTableList = {},
      ---@type table<table<integer,integer>>
      SimmsTableModel = {
        ---@type table<integer,integer>
        SimmID = {},
        ---@type table<integer,integer>
        SimmPresetCount = {},
        ---@type table<integer,integer>
        SimmInstrumentCount = {}
      }
    }

    ---Default Structure for a contract that holds first/last positions for each field in the response
    ---@param response string resonse message
    ---@return table returns a Contract Table
    -- self.HardwareConfigurationDataContract.new = function(response)
    function self.HardwareConfigurationDataContract:new(response)
      setmetatable({},self)
      self.__index = self

      -- local contract = self.HardwareConfigurationDataContract.new()
      local mask = RequestModel.HardwareConfigurationResponse[0][1]
      self.MaskMessage = mask
      self.MaskSimmObjects = "eeeeffffgggg"
      self.Command = RequestModel.fetchDataPositionFirstLastFormats(mask,RequestModel.HardwareConfigurationResponse[1][1])[2]
      self.GeneralInfoBytes = RequestModel.fetchDataPositionFirstLastFormats(mask,RequestModel.HardwareConfigurationResponse[2][1])[2]
      self.UserPresetCount = RequestModel.fetchDataPositionFirstLastFormats(mask,RequestModel.HardwareConfigurationResponse[3][1])[2]
      self.SimmCount = RequestModel.fetchDataPositionFirstLastFormats(mask,RequestModel.HardwareConfigurationResponse[4][1])[2]
      self.SimmBytePer = RequestModel.fetchDataPositionFirstLastFormats(mask,RequestModel.HardwareConfigurationResponse[5][1])[2]
      self.SimmsTableStartPointer = self.SimmBytePer[2]
      self.SimmsTableList = {}
      ---@type integer
      local pointer = self.SimmsTableStartPointer
      local countHex, _ = RequestModel.fetchDataUsingPositionStartEnd(response,self.SimmCount[1], self.SimmCount[2])
      ---@type integer
      local count = RequestModel.du.hex2IntBase16(countHex)
      for i=1,count do
        local t = {}
        ---@type integer
        local first,last,len
        first,last,len = RequestModel.fetchDataPositionFirstLast(self.MaskSimmObjects,RequestModel.HardwareConfigurationResponse[6][1])
        t.SimmID = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
        first,last,len = RequestModel.fetchDataPositionFirstLast(self.MaskSimmObjects,RequestModel.HardwareConfigurationResponse[7][1])
        t.SimmPresetCount = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
        first,last,len = RequestModel.fetchDataPositionFirstLast(self.MaskSimmObjects,RequestModel.HardwareConfigurationResponse[8][1])
        t.SimmInstrumentCount = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
        pointer = pointer + len -- update pointer by len
        table.insert(self.SimmsTableList,t)
      end
      return self
    end

    self.HardwareConfigurationResponseData = {
        mask = RequestModel.HardwareConfigurationResponse[0][1],    -- [0]
        command = RequestModel.HardwareConfigurationResponse[1][1], -- [1]
        ---@type string
        userPresetCount = "", -- [3]
        ---@type string
        simCount = "",        -- [4]
        ---@type string
        simBytesPer = "",     -- [5]
        ---@type table<string,string,string>
        simDataTable = {                   -- [6,7,8]
            ---@type string
            simID = "",                -- [6]
            ---@type string            
            simPresetCount = "",       -- [7]
            ---@type string
            simInstrumentCount = ""    -- [8]
        },
        --- table of simData objects
        ---@type table
        simDataTableList = {},             -- [6,7,8]
        -- getter functions
        getUserPresetCount = function(msg)
            return RequestModel.fetchDataUsingMask(msg,
            RequestModel.HardwareConfigurationResponseData.mask,
            RequestModel.HardwareConfigurationResponseData[3]
            )
        end,
        getSimCount = function(msg)
            return self.fetchDataUsingMask(msg,
                self.HardwareConfigurationResponseData.mask,
                self.HardwareConfigurationResponseData[4]
            )
        end,
        ---iterator for collecting data for multiple simms
        ---@param msg string - response message
        ---@param simcount integer - number of simms to iterate
        simDataIterator = function(msg,simcount)
            -- used provided simcount, or try the *Data simCount field
            local count = simcount or self.du.hex2IntBase16(self.HardwareConfigurationResponseData.simCount)
            -- get pointer for the last position before iterator
            local _, endIndex = string.find(
                self.HardwareConfigurationResponse[0][1],
                self.HardwareConfigurationResponse[5][1],
                1,true
            )
            -- setup for starting iterator
            local startIndex = endIndex+1
            local nextLen
            local simdataList = {}
            for i=1,count do
                -- open new simData object table
                local simdata = self.HardwareConfigurationResponseData.simDataTable
                -- get length of next field
                nextLen = #self.HardwareConfigurationResponse[6][1]
                -- fetch data from startIndex to nextLen, function return data and new position for next find
                simdata.simID, startIndex = self.fetchDataUsingPositionAndLength(msg,startIndex,nextLen)
                -- repeat
                nextLen = #self.HardwareConfigurationResponse[7][1]
                simdata.simPresetCount, startIndex = self.fetchDataUsingPositionAndLength(msg,startIndex,nextLen)
                -- repeat
                nextLen = #self.HardwareConfigurationResponse[8][1]
                simdata.simInstrumentCount, startIndex = self.fetchDataUsingPositionAndLength(msg,startIndex,#self.HardwareConfigurationResponse[8][1])
                -- add simdata to teh simDataTable
                simdataList[i] = simdata
            end
            return simdataList
        end,
        getHardwareConfigResponseData = function(msg)
            local mask = self.HardwareConfigurationResponseData.mask
            local status
              -- HWConfigDump
            -- fetch HWConfigDump & clean it of sysex control bytes
            -- msg,status = RequestModel.cleanSysexUniversalMessage(RequestsTable:new().HardwareConfigurationResponse)
            msg,status = RequestModel.cleanSysexUniversalMessage(msg)
            print(string.format("current msg:[%s] status:[%s]",msg, status))

            mask = self.HardwareConfigurationResponse[0][1]
            self.HardwareConfigurationResponseData.userPresetCount = self.fetchDataUsingMask(msg, mask,
                self.HardwareConfigurationResponse[3][1]
            )
            self.HardwareConfigurationResponseData.simCount = self.fetchDataUsingMask(msg, mask,
                self.HardwareConfigurationResponse[4][1]
            )
            self.HardwareConfigurationResponseData.simBytesPer = self.fetchDataUsingMask(msg, mask,
                self.HardwareConfigurationResponse[5][1]
            )
            self.HardwareConfigurationResponseData.simDataTableList = self.HardwareConfigurationResponseData.simDataIterator(msg,
                    self.du.hex2IntBase16(self.HardwareConfigurationResponseData.simCount)
            )
        end
    }

    self.HardwareConfigurationResponseObject = {
        ---@type string
        mask = RequestModel.HardwareConfigurationResponse[0][1],
        ---@type string
        command = RequestModel.HardwareConfigurationResponse[1][1],
        ---@type string
        generalInfoBytes = "",
        ---@type string
        userPresetCount = "",
        ---@type string
        simmCount = "",
        ---@type string
        simmInfoBytesPer = "",
        ---@type table
        simmDataList = {},
        ---@type table
        simmDataModel = {
            ---@type string
            simmID = "",
            ---@type string
            simmPresets = "",
            ---@type string
            simmInstruments = ""
        },
        ---@type function
        hex2int = function(hexString)
            return RequestModel.du.hex2IntBase16(hexString)
        end,
        ---@type function
        int2hex_2byte = function(int)
            return RequestModel.du.Int2Hex2Byte(int)
        end,
        ---@type function
        int2hex_1byte = function(int)
          return RequestModel.du.hex2IntBase16(int)
        end,
    }

    ---return a new simmDataModel
    ----@param o string
    ---@return table
    function self.HardwareConfigurationResponseObject.simmDataModel:new()
      -- o=o or o
      setmetatable({},self)
      self.__index = self
      return self
    end

    -- self.HardwareConfigurationResponseObject.new = function(response)
    function self.HardwareConfigurationResponseObject:new (response)
      -- o = o or o
      setmetatable({},self)
      self.__index = self

      -- local obj = self.HardwareConfigurationResponseObject.new()
      local contract = RequestModel.HardwareConfigurationDataContract:new(response)
      self.generalInfoBytes = RequestModel.fetchDataUsingPositionStartEnd(response,contract.GeneralInfoBytes[1],contract.GeneralInfoBytes[2])
      self.userPresetCount = RequestModel.fetchDataUsingPositionStartEnd(response,contract.UserPresetCount[1],contract.UserPresetCount[2])
      self.simmCount = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmCount[1], contract.SimmCount[2])
      self.simmInfoBytesPer = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmBytePer[1],contract.SimmBytePer[2])

      for i=1,RequestModel.du.hex2IntBase16(self.simmCount) do
        local simm = RequestModel.HardwareConfigurationResponseObject.simmDataModel:new()
        simm.simmID = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].SimmID[1],contract.SimmsTableList[i].SimmID[2])
        simm.simmPresets = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].SimmPresetCount[1],contract.SimmsTableList[i].SimmPresetCount[2])
        simm.simmInstruments = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].SimmInstrumentCount[1],contract.SimmsTableList[i].SimmInstrumentCount[2])
        table.insert(self.simmDataList,simm)
        -- table.insert(RequestModel.HardwareConfigurationResponseObject.simmDataList,simm)
      end

      return self
    end

  end


  do -- Setup Dump By Position
    self.SetupDump = {}
    self.SetupDump[0] = {1,1}
    self.SetupDump[2] = {2,3}
    self.SetupDump[4] = {4,5}
    self.SetupDump[6] = {6,7}
    self.SetupDump[8] = {8,9}
    self.SetupDump[10] = {10,11}
    self.SetupDump[12] = {12,13}
    self.SetupDump[14] = {14,15}
    self.SetupDump[142] = {16,16}
    self.SetupDump[143] = {17,17}
    self.SetupDump[144] = {18,18}
    self.SetupDump[145] = {19,19}
    self.SetupDump[146] = {20,20}
    self.SetupDump[147] = {21,21}
    self.SetupDump[148] = {22,22}
    self.SetupDump[149] = {23,23}
    self.SetupDump[150] = {24,24}
    self.SetupDump[151] = {25,25}
    self.SetupDump[152] = {26,26}
    self.SetupDump[153] = {27,27}
    self.SetupDump[154] = {28,28}
    self.SetupDump[155] = {29,29}
    self.SetupDump[156] = {30,30}
    self.SetupDump[157] = {31,31}
    self.SetupDump[257] = {32,33}
    self.SetupDump[258] = {34,35}
    self.SetupDump[259] = {36,37}
    self.SetupDump[260] = {38,39}
    self.SetupDump[264] = {40,41}
    self.SetupDump[264] = {42,43}
    self.SetupDump[265] = {44,45}
    self.SetupDump[266] = {46,47}
    self.SetupDump[267] = {48,49}
    self.SetupDump[268] = {50,51}
    self.SetupDump[269] = {52,53}
    -- self.SetupDump[] = {54,55}
    -- self.SetupDump[] = {56,57}
    -- self.SetupDump[] = {58,59}
    -- self.SetupDump[] = {60,61}
    -- self.SetupDump[] = {62,63}
    -- self.SetupDump[] = {64,65}
    -- self.SetupDump[] = {66,67}
    -- self.SetupDump[] = {68,69}
    -- self.SetupDump[] = {70,71}
    -- self.SetupDump[] = {72,73}
    -- self.SetupDump[] = {74,75}
    -- self.SetupDump[] = {76,77}
    -- self.SetupDump[] = {78,79}
    -- self.SetupDump[] = {80,81}
    -- self.SetupDump[] = {82,83}
    -- self.SetupDump[] = {84,85}
    -- self.SetupDump[] = {86,87}
    -- self.SetupDump[] = {88,89}
    -- self.SetupDump[] = {90,91}
    self.SetupDump[385] = {92,93}
    self.SetupDump[386] = {94,95}
    self.SetupDump[388] = {96,97}
    self.SetupDump[391] = {98,99}
    self.SetupDump[392] = {100,101}
    self.SetupDump[393] = {102,103}
    self.SetupDump[394] = {104,105}
    self.SetupDump[395] = {106,107}
    self.SetupDump[396] = {108,109}
    self.SetupDump[397] = {110,111}
    self.SetupDump[398] = {112,113}
    self.SetupDump[399] = {114,115}
    self.SetupDump[400] = {116,117}
    self.SetupDump[401] = {118,119}
    self.SetupDump[402] = {120,121}
    self.SetupDump[403] = {122,123}
    self.SetupDump[404] = {124,125}
    self.SetupDump[405] = {126,127}
    self.SetupDump[406] = {128,129}
    self.SetupDump[407] = {130,131}
    self.SetupDump[408] = {132,133}
    self.SetupDump[409] = {134,135}
    self.SetupDump[411] = {136,137}
    self.SetupDump[412] = {138,139}
    self.SetupDump[413] = {140,141}
    self.SetupDump[414] = {142,143}
    self.SetupDump[415] = {144,145}
    self.SetupDump[416] = {146,147}
    self.SetupDump[417] = {148,149}
    self.SetupDump[418] = {150,151}
    self.SetupDump[419] = {152,153}
    self.SetupDump[420] = {154,155}
    self.SetupDump[421] = {156,157}
    self.SetupDump[422] = {158,159}
    -- self.SetupDump[OWN] = {160,161}
    self.SetupDump[513] = {162,163}
    self.SetupDump[514] = {164,165}
    self.SetupDump[515] = {166,167}
    self.SetupDump[516] = {168,169}
    self.SetupDump[517] = {170,171}
    self.SetupDump[518] = {172,173}
    self.SetupDump[519] = {174,175}
    self.SetupDump[520] = {176,177}
    self.SetupDump[521] = {178,179}
    self.SetupDump[522] = {180,181}
    self.SetupDump[523] = {182,183}
    self.SetupDump[524] = {184,185}
    self.SetupDump[525] = {186,187}
    self.SetupDump[526] = {188,189}
    self.SetupDump[527] = {190,191}
    self.SetupDump[528] = {192,193}
    self.SetupDump[641] = {194,195}
    self.SetupDump[642] = {196,197}
    self.SetupDump[643] = {198,199}
    self.SetupDump[644] = {200,201}
    self.SetupDump[645] = {202,203}
    self.SetupDump[646] = {204,205}
    self.SetupDump[647] = {206,207}
    self.SetupDump[648] = {208,209}
    self.SetupDump[649] = {210,211}
    self.SetupDump[650] = {212,213}
    self.SetupDump[651] = {214,215}
    self.SetupDump[652] = {216,217}
    self.SetupDump[653] = {218,219}
    self.SetupDump[654] = {220,221}
    self.SetupDump[655] = {222,223}
    self.SetupDump[656] = {224,225}
    self.SetupDump[657] = {226,227}
    self.SetupDump[658] = {228,229}
    self.SetupDump[659] = {230,231}
    self.SetupDump[661] = {232,233}
    self.SetupDump[768] = {234,235}
    self.SetupDump[139] = {236,237}
    self.SetupDump[140] = {238,239}
    self.SetupDump[141] = {240,241}
    self.SetupDump[130] = {242,243}
    self.SetupDump[131] = {244,245}
    self.SetupDump[132] = {246,247}
    self.SetupDump[133] = {248,249}
    self.SetupDump[134] = {250,251}
    self.SetupDump[135] = {252,253}
    self.SetupDump[136] = {254,255}
    self.SetupDump[137] = {256,257}
    self.SetupDump[138] = {258,259}
    self.SetupDump[130] = {260,261}
    self.SetupDump[131] = {262,263}
    self.SetupDump[132] = {264,265}
    self.SetupDump[133] = {266,267}
    self.SetupDump[134] = {268,269}
    self.SetupDump[135] = {270,271}
    self.SetupDump[136] = {272,273}
    self.SetupDump[137] = {274,275}
    self.SetupDump[138] = {276,277}
    self.SetupDump[130] = {278,279}
    self.SetupDump[131] = {280,281}
    self.SetupDump[132] = {282,283}
    self.SetupDump[133] = {284,285}
    self.SetupDump[134] = {286,287}
    self.SetupDump[135] = {288,289}
    self.SetupDump[136] = {290,291}
    self.SetupDump[137] = {292,293}
    self.SetupDump[138] = {294,295}
    self.SetupDump[130] = {296,297}
    self.SetupDump[131] = {298,299}
    self.SetupDump[132] = {300,301}
    self.SetupDump[133] = {302,303}
    self.SetupDump[134] = {304,305}
    self.SetupDump[135] = {306,307}
    self.SetupDump[136] = {308,309}
    self.SetupDump[137] = {310,311}
    self.SetupDump[138] = {312,313}
    self.SetupDump[130] = {314,315}
    self.SetupDump[131] = {316,317}
    self.SetupDump[132] = {318,319}
    self.SetupDump[133] = {320,321}
    self.SetupDump[134] = {322,323}
    self.SetupDump[135] = {324,325}
    self.SetupDump[136] = {326,327}
    self.SetupDump[137] = {328,329}
    self.SetupDump[138] = {330,331}
    self.SetupDump[130] = {332,333}
    self.SetupDump[131] = {334,335}
    self.SetupDump[132] = {336,337}
    self.SetupDump[133] = {338,339}
    self.SetupDump[134] = {340,341}
    self.SetupDump[135] = {342,343}
    self.SetupDump[136] = {344,345}
    self.SetupDump[137] = {346,347}
    self.SetupDump[138] = {348,349}
    self.SetupDump[130] = {350,351}
    self.SetupDump[131] = {352,353}
    self.SetupDump[132] = {354,355}
    self.SetupDump[133] = {356,357}
    self.SetupDump[134] = {358,359}
    self.SetupDump[135] = {360,361}
    self.SetupDump[136] = {362,363}
    self.SetupDump[137] = {364,365}
    self.SetupDump[138] = {366,367}
    self.SetupDump[130] = {368,369}
    self.SetupDump[131] = {370,371}
    self.SetupDump[132] = {372,373}
    self.SetupDump[133] = {374,375}
    self.SetupDump[134] = {376,377}
    self.SetupDump[135] = {378,379}
    self.SetupDump[136] = {380,381}
    self.SetupDump[137] = {382,383}
    self.SetupDump[138] = {384,385}
    self.SetupDump[130] = {386,387}
    self.SetupDump[131] = {388,389}
    self.SetupDump[132] = {390,391}
    self.SetupDump[133] = {392,393}
    self.SetupDump[134] = {394,395}
    self.SetupDump[135] = {396,397}
    self.SetupDump[136] = {398,399}
    self.SetupDump[137] = {400,401}
    self.SetupDump[138] = {402,403}
    self.SetupDump[130] = {404,405}
    self.SetupDump[131] = {406,407}
    self.SetupDump[132] = {408,409}
    self.SetupDump[133] = {410,411}
    self.SetupDump[134] = {412,413}
    self.SetupDump[135] = {414,415}
    self.SetupDump[136] = {416,417}
    self.SetupDump[137] = {418,419}
    self.SetupDump[138] = {420,421}
    self.SetupDump[130] = {422,423}
    self.SetupDump[131] = {424,425}
    self.SetupDump[132] = {426,427}
    self.SetupDump[133] = {428,429}
    self.SetupDump[134] = {430,431}
    self.SetupDump[135] = {432,433}
    self.SetupDump[136] = {434,435}
    self.SetupDump[137] = {436,437}
    self.SetupDump[138] = {438,439}
    self.SetupDump[130] = {440,441}
    self.SetupDump[131] = {442,443}
    self.SetupDump[132] = {444,445}
    self.SetupDump[133] = {446,447}
    self.SetupDump[134] = {448,449}
    self.SetupDump[135] = {450,451}
    self.SetupDump[136] = {452,453}
    self.SetupDump[137] = {454,455}
    self.SetupDump[138] = {456,457}
    self.SetupDump[130] = {458,459}
    self.SetupDump[131] = {460,461}
    self.SetupDump[132] = {462,463}
    self.SetupDump[133] = {464,465}
    self.SetupDump[134] = {466,467}
    self.SetupDump[135] = {468,469}
    self.SetupDump[136] = {470,471}
    self.SetupDump[137] = {472,473}
    self.SetupDump[138] = {474,475}
    self.SetupDump[130] = {476,477}
    self.SetupDump[131] = {478,479}
    self.SetupDump[132] = {480,481}
    self.SetupDump[133] = {482,483}
    self.SetupDump[134] = {484,485}
    self.SetupDump[135] = {486,487}
    self.SetupDump[136] = {488,489}
    self.SetupDump[137] = {490,491}
    self.SetupDump[138] = {492,493}
    self.SetupDump[130] = {494,495}
    self.SetupDump[131] = {496,497}
    self.SetupDump[132] = {498,499}
    self.SetupDump[133] = {500,501}
    self.SetupDump[134] = {502,503}
    self.SetupDump[135] = {504,505}
    self.SetupDump[136] = {506,507}
    self.SetupDump[137] = {508,509}
    self.SetupDump[138] = {510,511}
    self.SetupDump[130] = {512,513}
    self.SetupDump[131] = {514,515}
    self.SetupDump[132] = {516,517}
    self.SetupDump[133] = {518,519}
    self.SetupDump[134] = {520,521}
    self.SetupDump[135] = {522,523}
    self.SetupDump[136] = {524,525}
    self.SetupDump[137] = {526,527}
    self.SetupDump[138] = {528,529}
    self.SetupDump[130] = {530,531}
    self.SetupDump[131] = {532,533}
    self.SetupDump[132] = {534,535}
    self.SetupDump[133] = {536,537}
    self.SetupDump[134] = {538,539}
    self.SetupDump[135] = {540,541}
    self.SetupDump[136] = {542,543}
    self.SetupDump[137] = {544,545}
    self.SetupDump[138] = {546,547}
    self.SetupDump[130] = {548,549}
    self.SetupDump[131] = {550,551}
    self.SetupDump[132] = {552,553}
    self.SetupDump[133] = {554,555}
    self.SetupDump[134] = {556,557}
    self.SetupDump[135] = {558,559}
    self.SetupDump[136] = {560,561}
    self.SetupDump[137] = {562,563}
    self.SetupDump[138] = {564,565}
    self.SetupDump[130] = {566,567}
    self.SetupDump[131] = {568,569}
    self.SetupDump[132] = {570,571}
    self.SetupDump[133] = {572,573}
    self.SetupDump[134] = {574,575}
    self.SetupDump[135] = {576,577}
    self.SetupDump[136] = {578,579}
    self.SetupDump[137] = {580,581}
    self.SetupDump[138] = {582,583}
    self.SetupDump[130] = {584,585}
    self.SetupDump[131] = {586,587}
    self.SetupDump[132] = {588,589}
    self.SetupDump[133] = {590,591}
    self.SetupDump[134] = {592,593}
    self.SetupDump[135] = {594,595}
    self.SetupDump[136] = {596,597}
    self.SetupDump[137] = {598,599}
    self.SetupDump[138] = {600,601}
    self.SetupDump[130] = {602,603}
    self.SetupDump[131] = {604,605}
    self.SetupDump[132] = {606,607}
    self.SetupDump[133] = {608,609}
    self.SetupDump[134] = {610,611}
    self.SetupDump[135] = {612,613}
    self.SetupDump[136] = {614,615}
    self.SetupDump[137] = {616,617}
    self.SetupDump[138] = {618,619}
    self.SetupDump[130] = {620,621}
    self.SetupDump[131] = {622,623}
    self.SetupDump[132] = {624,625}
    self.SetupDump[133] = {626,627}
    self.SetupDump[134] = {628,629}
    self.SetupDump[135] = {630,631}
    self.SetupDump[136] = {632,633}
    self.SetupDump[137] = {634,635}
    self.SetupDump[138] = {636,637}
    self.SetupDump[130] = {638,639}
    self.SetupDump[131] = {640,641}
    self.SetupDump[132] = {642,643}
    self.SetupDump[133] = {644,645}
    self.SetupDump[134] = {646,647}
    self.SetupDump[135] = {648,649}
    self.SetupDump[136] = {650,651}
    self.SetupDump[137] = {652,653}
    self.SetupDump[138] = {654,655}
    self.SetupDump[130] = {656,657}
    self.SetupDump[131] = {658,659}
    self.SetupDump[132] = {660,661}
    self.SetupDump[133] = {662,663}
    self.SetupDump[134] = {664,665}
    self.SetupDump[135] = {666,667}
    self.SetupDump[136] = {668,669}
    self.SetupDump[137] = {670,671}
    self.SetupDump[138] = {672,673}
    self.SetupDump[130] = {674,675}
    self.SetupDump[131] = {676,677}
    self.SetupDump[132] = {678,679}
    self.SetupDump[133] = {680,681}
    self.SetupDump[134] = {682,683}
    self.SetupDump[135] = {684,685}
    self.SetupDump[136] = {686,687}
    self.SetupDump[137] = {688,689}
    self.SetupDump[138] = {690,691}
    self.SetupDump[130] = {692,693}
    self.SetupDump[131] = {694,695}
    self.SetupDump[132] = {696,697}
    self.SetupDump[133] = {698,699}
    self.SetupDump[134] = {700,701}
    self.SetupDump[135] = {702,703}
    self.SetupDump[136] = {704,705}
    self.SetupDump[137] = {706,707}
    self.SetupDump[138] = {708,709}
    self.SetupDump[130] = {710,711}
    self.SetupDump[131] = {712,713}
    self.SetupDump[132] = {714,715}
    self.SetupDump[133] = {716,717}
    self.SetupDump[134] = {718,719}
    self.SetupDump[135] = {720,721}
    self.SetupDump[136] = {722,723}
    self.SetupDump[137] = {724,725}
    self.SetupDump[138] = {726,727}
    self.SetupDump[130] = {728,729}
    self.SetupDump[131] = {730,731}
    self.SetupDump[132] = {732,733}
    self.SetupDump[133] = {734,735}
    self.SetupDump[134] = {736,737}
    self.SetupDump[135] = {738,739}
    self.SetupDump[136] = {740,741}
    self.SetupDump[137] = {742,743}
    self.SetupDump[138] = {744,745}
    self.SetupDump[130] = {746,747}
    self.SetupDump[131] = {748,749}
    self.SetupDump[132] = {750,751}
    self.SetupDump[133] = {752,753}
    self.SetupDump[134] = {754,755}
    self.SetupDump[135] = {756,757}
    self.SetupDump[136] = {758,759}
    self.SetupDump[137] = {760,761}
    self.SetupDump[138] = {762,763}
    self.SetupDump[130] = {764,765}
    self.SetupDump[131] = {766,767}
    self.SetupDump[132] = {768,769}
    self.SetupDump[133] = {770,771}
    self.SetupDump[134] = {772,773}
    self.SetupDump[135] = {774,775}
    self.SetupDump[136] = {776,777}
    self.SetupDump[137] = {778,779}
    self.SetupDump[138] = {780,781}
    self.SetupDump[130] = {782,783}
    self.SetupDump[131] = {784,785}
    self.SetupDump[132] = {786,787}
    self.SetupDump[133] = {788,789}
    self.SetupDump[134] = {790,791}
    self.SetupDump[135] = {792,793}
    self.SetupDump[136] = {794,795}
    self.SetupDump[137] = {796,797}
    self.SetupDump[138] = {798,799}
    self.SetupDump[130] = {800,801}
    self.SetupDump[131] = {802,803}
    self.SetupDump[132] = {804,805}
    self.SetupDump[133] = {806,807}
    self.SetupDump[134] = {808,809}
    self.SetupDump[135] = {810,811}
    self.SetupDump[136] = {812,813}
    self.SetupDump[137] = {814,815}
    self.SetupDump[138] = {816,817}
    
  end

  do -- Setup Dump
      self.SetupDumpResponse = {}
      self.SetupDumpResponse[0] = {"1Caaaabbbbccccddddeeeeffffgggg[736]F7[1622443240657","Mask"}
      self.SetupDumpResponse[1] = {"1C","Command"}
      self.SetupDumpResponse[2] = {"aaaa","Number of Master General Parameters (11)"}
      self.SetupDumpResponse[3] = {"bbbb","Number of Master MIDI Parameters (22)"}
      self.SetupDumpResponse[4] = {"cccc","Number of Master Effects Parameters (16)"}
      self.SetupDumpResponse[5] = {"dddd","Number of Reserved Parameters (0)"}
      self.SetupDumpResponse[6] = {"eeee","Number of Non Channel Parameters (LSB first)"}
      self.SetupDumpResponse[7] = {"ffff","Number of MIDI Channels (LSB first)"}
      self.SetupDumpResponse[8] = {"gggg","Number of Parameters per Channel (LSB first)"}
      self.SetupDumpResponse[9] = {"[736]",""}
      self.SetupDumpResponse[10] = {"[16]","16 ASCII character Setup Name"}
      self.SetupDumpResponse[11] = {"[22]","Master General"}
      self.SetupDumpResponse[12] = {"[44]","Master MIDI"}
      self.SetupDumpResponse[13] = {"[32]","Master Effects"}
      self.SetupDumpResponse[14] = {"[40]","Reserved"}
      self.SetupDumpResponse[15] = {"[6]","Non Channel Parameter Values"}
      self.SetupDumpResponse[16] = {"[576]","Channel Parameters"}
      self.SetupDumpRequest = {}
      self.SetupDumpRequest[0] = {"1D","Mask"}
      self.SetupDumpRequest[1] = {"1D","Command"}
      -- Generic Dump
      self.GenericDumpRequest = {}
      self.GenericDumpRequest[0] = {"61000100aaaabbbb","Mask"}
      self.GenericDumpRequest[1] = {"6100","command::genericdump"}
      self.GenericDumpRequest[2] = {"0100","objecttype01=masterdata"}
      self.GenericDumpRequest[3] = {"aaaa","objectnumber(zeroformastersetupdata)"}
      self.GenericDumpRequest[4] = {"bbbb","romnumber(zeroformastersetupdata)"}
      self.GenericDump = {}
      self.GenericDump[0] = {"61aabbccddddeeeeffff[gggghhhhiiiijjjjkkkk]","Mask"}
      self.GenericDump[1] = {"61","Command"}
      self.GenericDump[2] = {"aa","subcommand::dumpversion"}
      self.GenericDump[3] = {"bb","objecttype01=masterdata,otherstofollow"}
      self.GenericDump[4] = {"cc","subtype00=mastersetup,otherstofollow"}
      self.GenericDump[5] = {"dddd","objectnumberifapplicableelsezero"}
      self.GenericDump[6] = {"eeee","romnumberifapplicableelsezero"}
      self.GenericDump[7] = {"ffff","numberofparamgroups"}
      self.GenericDump[8] = {"[",""}
      self.GenericDump[9] = {"gggg","startingparameteridforthegroup"}
      self.GenericDump[10] = {"hhhh","numberofparamtersinthegroup.Eachparameteridisinsequencefromthestartingidofthegroup"}
      self.GenericDump[11] = {"iiii","startingindexofparameterelements"}
      self.GenericDump[12] = {"jjjj","countofparameterelements"}
      self.GenericDump[13] = {"kkkk","twobytedataforeachparameterinthegroupelementrepeatedgn,gntimes"}
      self.GenericDump[14] = {"]",""}
  end

  do -- Generic Dump
      self.GenericName = {}
      self.GenericName[0] = {"0BaabbbbccccAAAAAAAAAAAAAAAA","Mask"}
      self.GenericName[1] = {"0B","Command"}
      self.GenericName[2] = {"aa","Object Type"}
      self.GenericName[3] = {"bbbb","Object Number"}
      self.GenericName[4] = {"cccc","Object ROM ID"}
      self.GenericName[5] = {"aaaaaaaaaaaaaaaa","Name ( x16 ASCII Chars )"}
      self.GenericNameRequest = {}
      self.GenericNameRequest[0] = {"0Caabbbbcccc","Mask"}
      self.GenericNameRequest[1] = {"0C","Command"}
      self.GenericNameRequest[2] = {"aa","Object Type"}
      self.GenericNameRequest[3] = {"bbbb","Object Number"}
      self.GenericNameRequest[4] = {"cccc","Object Rom ID"}
  end

  do -- Preset Dump ClosedLoop
      self.PresetDumpHeaderClosedLoopResponse = {}
      self.PresetDumpHeaderClosedLoopResponse[0] = {"1001aaaabbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm","Mask"}
      self.PresetDumpHeaderClosedLoopResponse[1] = {"10","Command"}
      self.PresetDumpHeaderClosedLoopResponse[2] = {"01","SubCommand"}
      self.PresetDumpHeaderClosedLoopResponse[3] = {"aaaa","Preset Number"}
      self.PresetDumpHeaderClosedLoopResponse[4] = {"bbbbbbbb","Number of DataBytes in Bump"}
      self.PresetDumpHeaderClosedLoopResponse[5] = {"cccc","Number of Preset Common General Parameters, LSB first"}
      self.PresetDumpHeaderClosedLoopResponse[6] = {"dddd","Number of Reserved Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[7] = {"eeee","Number of Preset Common Effects Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[8] = {"ffff","Number of Preset Common Link Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[9] = {"gggg","Number of Preset Layers, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[10] = {"hhhh","Number of Preset Layer General Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[11] = {"iiii","Number of Preset Layer Filter Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[12] = {"jjjj","Number of Preset Layer LFO Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[13] = {"kkkk","Number of Preset Layer Envelope Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[14] = {"llll","Number of Preset Layer PatchCord Parameters, LSB first."}
      self.PresetDumpHeaderClosedLoopResponse[15] = {"mmmm","Preset ROM ID"}
      self.PresetDumpDataClosedLoopResponse = {}
      self.PresetDumpDataClosedLoopResponse[0] = {"1002aaaa[244]ck","Mask"}
      self.PresetDumpDataClosedLoopResponse[1] = {"10","Command"}
      self.PresetDumpDataClosedLoopResponse[2] = {"02","SubCommand"}
      self.PresetDumpDataClosedLoopResponse[3] = {"aaaa","Running Packet count, LSB first, begins at 1"}
      self.PresetDumpDataClosedLoopResponse[4] = {"[244]","<up to 244 Data Bytes>"}
      self.PresetDumpDataClosedLoopResponse[5] = {"bb","1 Byte = 1’s complement of the sum of {<244 Data Bytes>"}
  end

  do -- Preset Dump Open Loop
      self.PresetDumpHeaderOpenLoopResponse = {}
      self.PresetDumpHeaderOpenLoopResponse[0] = {"1003aaaabbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm","Mask"}
      self.PresetDumpHeaderOpenLoopResponse[1] = {"10","Command"}
      self.PresetDumpHeaderOpenLoopResponse[2] = {"03","SubCommand"}
      self.PresetDumpHeaderOpenLoopResponse[3] = {"aaaa","Preset Number"}
      self.PresetDumpHeaderOpenLoopResponse[4] = {"bbbbbbbb","Number of DataBytes in Bump"}
      self.PresetDumpHeaderOpenLoopResponse[5] = {"cccc","Number of Preset Common General Parameters, LSB first"}
      self.PresetDumpHeaderOpenLoopResponse[6] = {"dddd","Number of Reserved Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[7] = {"eeee","Number of Preset Common Effects Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[8] = {"ffff","Number of Preset Common Link Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[9] = {"gggg","Number of Preset Layers, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[10] = {"hhhh","Number of Preset Layer General Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[11] = {"iiii","Number of Preset Layer Filter Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[12] = {"jjjj","Number of Preset Layer LFO Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[13] = {"kkkk","Number of Preset Layer Envelope Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[14] = {"llll","Number of Preset Layer PatchCord Parameters, LSB first."}
      self.PresetDumpHeaderOpenLoopResponse[15] = {"mmmm","Preset ROM ID"}
      self.PresetDumpDataOpenLoopResponse = {}
      self.PresetDumpDataOpenLoopResponse[0] = {"1004aabb[244]ck","Mask"}
      self.PresetDumpDataOpenLoopResponse[1] = {"10","Command"}
      self.PresetDumpDataOpenLoopResponse[2] = {"04","SubCommand"}
      self.PresetDumpDataOpenLoopResponse[3] = {"[244]",""}
      self.PresetDumpDataOpenLoopResponse[4] = {"ck","Checksum"}
  end

  do -- Preset Common
      self.PresetCommonParamsDumpDataResponse = {}
      self.PresetCommonParamsDumpDataResponse[0] = {"1010[240]","Mask"}
      self.PresetCommonParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetCommonParamsDumpDataResponse[2] = {"10","SubCommand"}
      self.PresetCommonParamsDumpDataResponse[3] = {"[240]",""}
      self.PresetCommonGeneralParamsDumpDataResponse = {}
      self.PresetCommonGeneralParamsDumpDataResponse[0] = {"1011[126]","Mask"}
      self.PresetCommonGeneralParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetCommonGeneralParamsDumpDataResponse[2] = {"11","SubCommand"}
      self.PresetCommonGeneralParamsDumpDataResponse[3] = {"[126]",""}
      self.PresetCommonArpParamsDumpDataResponse = {}
      self.PresetCommonArpParamsDumpDataResponse[0] = {"1012[38]","Mask"}
      self.PresetCommonArpParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetCommonArpParamsDumpDataResponse[2] = {"12","SubCommand"}
      self.PresetCommonArpParamsDumpDataResponse[3] = {"[38]",""}
      self.PresetCommonEffectsParamsDumpDataResponse = {}
      self.PresetCommonEffectsParamsDumpDataResponse[0] = {"1013[38]","Mask"}
      self.PresetCommonEffectsParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetCommonEffectsParamsDumpDataResponse[2] = {"13","SubCommand"}
      self.PresetCommonEffectsParamsDumpDataResponse[3] = {"[38]",""}
      self.PresetCommonLinkParamsDumpDataResponse = {}
      self.PresetCommonLinkParamsDumpDataResponse[0] = {"1014[46]","Mask"}
      self.PresetCommonLinkParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetCommonLinkParamsDumpDataResponse[2] = {"14","SubCommand"}
      self.PresetCommonLinkParamsDumpDataResponse[3] = {"[46]",""}
      self.PresetLayerParamsDumpDataResponse = {}
  end 

  do -- Preset Layer
      self.PresetLayerParamsDumpDataResponse[0] = {"1020[332]","Mask"}
      self.PresetLayerParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerParamsDumpDataResponse[2] = {"20","SubCommand"}
      self.PresetLayerParamsDumpDataResponse[3] = {"[332]",""}
      self.PresetLayerGeneralParamsDumpDataResponse = {}
      self.PresetLayerGeneralParamsDumpDataResponse[0] = {"1021[70]","Mask"}
      self.PresetLayerGeneralParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerGeneralParamsDumpDataResponse[2] = {"21","SubCommand"}
      self.PresetLayerGeneralParamsDumpDataResponse[3] = {"[70]",""}
      self.PresetLayerFilterParamsDumpDataResponse = {}
      self.PresetLayerFilterParamsDumpDataResponse[0] = {"1022[14]","Mask"}
      self.PresetLayerFilterParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerFilterParamsDumpDataResponse[2] = {"22","SubCommand"}
      self.PresetLayerFilterParamsDumpDataResponse[3] = {"[14]",""}
      self.PresetLayerLFOParamsDumpDataResponse = {}
      self.PresetLayerLFOParamsDumpDataResponse[0] = {"1023[28]","Mask"}
      self.PresetLayerLFOParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerLFOParamsDumpDataResponse[2] = {"23","SubCommand"}
      self.PresetLayerLFOParamsDumpDataResponse[3] = {"[28]",""}
      self.PresetLayerEnvelopeParamsDumpDataResponse = {}
      self.PresetLayerEnvelopeParamsDumpDataResponse[0] = {"1024[92]","Mask"}
      self.PresetLayerEnvelopeParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerEnvelopeParamsDumpDataResponse[2] = {"24","SubCommand"}
      self.PresetLayerEnvelopeParamsDumpDataResponse[3] = {"[92]",""}
      self.PresetLayerPatchcordParamsDumpDataResponse = {}
      self.PresetLayerPatchcordParamsDumpDataResponse[0] = {"1025[152]","Mask"}
      self.PresetLayerPatchcordParamsDumpDataResponse[1] = {"10","Command"}
      self.PresetLayerPatchcordParamsDumpDataResponse[2] = {"25","SubCommand"}
      self.PresetLayerPatchcordParamsDumpDataResponse[3] = {"[152]",""}
  end

  do -- Preset Dump Request
      self.PresetDumpRequestClosedLoop = {}
      self.PresetDumpRequestClosedLoop[0] = {"1102aaaabbbb","Mask"}
      self.PresetDumpRequestClosedLoop[1] = {"11","Command"}
      self.PresetDumpRequestClosedLoop[2] = {"02","SubCommand"}
      self.PresetDumpRequestClosedLoop[3] = {"aaaa","Preset Number"}
      self.PresetDumpRequestClosedLoop[4] = {"bbbb","Preset ROM ID"}
      self.PresetDumpRequestOpenLoop = {}
      self.PresetDumpRequestOpenLoop[0] = {"1104aaaabbbb","Mask"}
      self.PresetDumpRequestOpenLoop[1] = {"11","Command"}
      self.PresetDumpRequestOpenLoop[2] = {"04","SubCommand"}
      self.PresetDumpRequestOpenLoop[3] = {"aaaa","Preset Number"}
      self.PresetDumpRequestOpenLoop[4] = {"bbbb","Preset ROM ID"}
      self.PresetCommonParamsDumpRequest = {}
      self.PresetCommonParamsDumpRequest[0] = {"1110aaaabbbb","Mask"}
      self.PresetCommonParamsDumpRequest[1] = {"11","Command"}
      self.PresetCommonParamsDumpRequest[2] = {"10","SubCommand"}
      self.PresetCommonParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetCommonParamsDumpRequest[4] = {"bbbb","Preset ROM ID"}
      self.PresetCommonGeneralParamsDumpRequest = {}
      self.PresetCommonGeneralParamsDumpRequest[0] = {"1111aaaabbbb","Mask"}
      self.PresetCommonGeneralParamsDumpRequest[1] = {"11","Command"}
      self.PresetCommonGeneralParamsDumpRequest[2] = {"11","SubCommand"}
      self.PresetCommonGeneralParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetCommonGeneralParamsDumpRequest[4] = {"bbbb","Preset ROM ID"}
      self.PresetCommonArpParamsDumpRequest = {}
      self.PresetCommonArpParamsDumpRequest[0] = {"1112aaaabbbb","Mask"}
      self.PresetCommonArpParamsDumpRequest[1] = {"11","Command"}
      self.PresetCommonArpParamsDumpRequest[2] = {"12","SubCommand"}
      self.PresetCommonArpParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetCommonArpParamsDumpRequest[4] = {"bbbb","Preset ROM ID"}
      self.PresetCommonFXParamsDumpRequest = {}
      self.PresetCommonFXParamsDumpRequest[0] = {"1113aaaabbbb","Mask"}
      self.PresetCommonFXParamsDumpRequest[1] = {"11","Command"}
      self.PresetCommonFXParamsDumpRequest[2] = {"13","SubCommand"}
      self.PresetCommonFXParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetCommonFXParamsDumpRequest[4] = {"bbbb","Preset ROM ID"}
      self.PresetCommonLinkParamsDumpRequest = {}
      self.PresetCommonLinkParamsDumpRequest[0] = {"1114aaaabbbb","Mask"}
      self.PresetCommonLinkParamsDumpRequest[1] = {"11","Command"}
      self.PresetCommonLinkParamsDumpRequest[2] = {"14","SubCommand"}
      self.PresetCommonLinkParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetCommonLinkParamsDumpRequest[4] = {"bbbb","Preset ROM ID"}
      self.PresetLayerParamsDumpRequest = {}
      self.PresetLayerParamsDumpRequest[0] = {"1120aaaabbbbcccc","Mask"}
      self.PresetLayerParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerParamsDumpRequest[2] = {"20","SubCommand"}
      self.PresetLayerParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
      self.PresetLayerGeneralParamsDumpRequest = {}
      self.PresetLayerGeneralParamsDumpRequest[0] = {"1121aaaabbbbcccc","Mask"}
      self.PresetLayerGeneralParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerGeneralParamsDumpRequest[2] = {"21","SubCommand"}
      self.PresetLayerGeneralParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerGeneralParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerGeneralParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
      self.PresetLayerFilterParamsDumpRequest = {}
      self.PresetLayerFilterParamsDumpRequest[0] = {"1122aaaabbbbcccc","Mask"}
      self.PresetLayerFilterParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerFilterParamsDumpRequest[2] = {"22","SubCommand"}
      self.PresetLayerFilterParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerFilterParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerFilterParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
      self.PresetLayerLFOParamsDumpRequest = {}
      self.PresetLayerLFOParamsDumpRequest[0] = {"1123aaaabbbbcccc","Mask"}
      self.PresetLayerLFOParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerLFOParamsDumpRequest[2] = {"23","SubCommand"}
      self.PresetLayerLFOParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerLFOParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerLFOParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
      self.PresetLayerEnvelopeParamsDumpRequest= {}
      self.PresetLayerEnvelopeParamsDumpRequest[0] = {"1124aaaabbbbcccc","Mask"}
      self.PresetLayerEnvelopeParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerEnvelopeParamsDumpRequest[2] = {"24","SubCommand"}
      self.PresetLayerEnvelopeParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerEnvelopeParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerEnvelopeParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
      self.PresetLayerCordParamsDumpRequest = {}
      self.PresetLayerCordParamsDumpRequest[0] = {"1125aaaabbbbcccc","Mask"}
      self.PresetLayerCordParamsDumpRequest[1] = {"11","Command"}
      self.PresetLayerCordParamsDumpRequest[2] = {"25","SubCommand"}
      self.PresetLayerCordParamsDumpRequest[3] = {"aaaa","Preset Number"}
      self.PresetLayerCordParamsDumpRequest[4] = {"bbbb","Layer Number"}
      self.PresetLayerCordParamsDumpRequest[5] = {"cccc","Preset ROM ID"}
  end

  do -- arpeggiator
      self.ArpeggiatorPatternDumpResponse = {}
      self.ArpeggiatorPatternDumpResponse[0] = {"18aaaabbbbccccddddAAAAAAAAAAAA[256]","Mask"}
      self.ArpeggiatorPatternDumpResponse[1] = {"18","Command"}
      self.ArpeggiatorPatternDumpResponse[2] = {"aaaa","Arpeggiator Pattern Number (LSB first)"}
      self.ArpeggiatorPatternDumpResponse[3] = {"bbbb","Number of Arpeggiator Steps per Pattern(LSB first)"}
      self.ArpeggiatorPatternDumpResponse[4] = {"cccc","Number of Arpeggiator Parameters per Step (LSB first)"}
      self.ArpeggiatorPatternDumpResponse[5] = {"dddd","Arpeggiator Pattern Loop Point (LSB first)"}
      self.ArpeggiatorPatternDumpResponse[6] = {"AAAAAAAAAAAA","12 ASCII Character Pattern Name"}
      self.ArpeggiatorPatternDumpResponse[7] = {"[256]","DATA"}
      self.ArpeggiatorPatternDumpRequest = {}
      self.ArpeggiatorPatternDumpRequest[0] = {"19aaaabbbb","Mask"}
      self.ArpeggiatorPatternDumpRequest[1] = {"19","Command"}
      self.ArpeggiatorPatternDumpRequest[2] = {"aaaa","Arpeggiator Pattern Number (LSB first)"}
      self.ArpeggiatorPatternDumpRequest[3] = {"bbbb","Arpeggiator Pattern ROM ID"}
      self.LCDScreenDumpResponseP2KAudity2K = {}
  end

  do -- LCD 
      self.LCDScreenDumpResponseP2KAudity2K[0] = {"1A01aabbccMAP[48]","Mask"}
      self.LCDScreenDumpResponseP2KAudity2K[1] = {"1A","Command"}
      self.LCDScreenDumpResponseP2KAudity2K[2] = {"01","SubCommand"}
      self.LCDScreenDumpResponseP2KAudity2K[3] = {"aa","Number of Rows in the Display (2)"}
      self.LCDScreenDumpResponseP2KAudity2K[4] = {"bb","Number of Characters per Row (24)"}
      self.LCDScreenDumpResponseP2KAudity2K[5] = {"cc","Number of Custom Characters per Screen (8)"}
      self.LCDScreenDumpResponseP2KAudity2K[6] = {"MAP[48]",""}
      self.LCDScreenDumpRequestP2KAudity2K = {}
      self.LCDScreenDumpRequestP2KAudity2K[0] = {"1B01","Mask"}
      self.LCDScreenDumpRequestP2KAudity2K[1] = {"1B","Command"}
      self.LCDScreenDumpRequestP2KAudity2K[2] = {"01","SubCommand"}
      self.LCDScreenCharacterPalletResponse = {}
      self.LCDScreenCharacterPalletResponse[0] = {"1A02aabb[MAPS]","Mask"}
      self.LCDScreenCharacterPalletResponse[1] = {"1A","Command"}
      self.LCDScreenCharacterPalletResponse[2] = {"02","SubCommand"}
      self.LCDScreenCharacterPalletResponse[3] = {"aa","Number of total Custom Characters in the Palette"}
      self.LCDScreenCharacterPalletResponse[4] = {"bb","8 x Number of Custom Characters(13)=104 Bytes"}
      self.LCDScreenCharacterPalletResponse[5] = {"[MAPS]",""}
      self.LCDScreenCharacterPalletRequest = {}
      self.LCDScreenCharacterPalletRequest[0] = {"1B02","Mask"}
      self.LCDScreenCharacterPalletRequest[1] = {"1B","Command"}
      self.LCDScreenCharacterPalletRequest[2] = {"02","SubCommand"}
  end

  do -- copy/paste objects
      self.CopyPresetRequest = {}
      self.CopyPresetRequest[0] = {"20aaaabbbbcccc","Mask"}
      self.CopyPresetRequest[1] = {"20","Command"}
      self.CopyPresetRequest[2] = {"aaaa","Source Preset number (ROM or RAM) LSB first"}
      self.CopyPresetRequest[3] = {"bbbb","Destination Preset number (RAM only) LSB firstPreset Number of -1 bis the Edit Buffer."}
      self.CopyPresetRequest[4] = {"cccc","Source ROM ID"}
      self.CopyPresetCommonParametersRequest = {}
      self.CopyPresetCommonParametersRequest[0] = {"21aaaabbbbcccc","Mask"}
      self.CopyArpParametersRequest = {}
      self.CopyArpParametersRequest[0] = {"22aaaabbbbcccc","Mask"}
      self.CopyEffectsParametersRequestMasterorPreset = {}
      self.CopyEffectsParametersRequestMasterorPreset[0] = {"23aaaabbbbcccc","Mask"}
      self.CopyPresetLinkParametersRequest = {}
      self.CopyPresetLinkParametersRequest[0] = {"24aaaabbbbcccc","Mask"}
      self.CopyPresetLayerRequest = {}
      self.CopyPresetLayerRequest[0] = {"25aaaabbbbcccc","Mask"}
      self.CopyPresetLayerCommonParametersRequest = {}
      self.CopyPresetLayerCommonParametersRequest[0] = {"26aaaabbbbcccc","Mask"}
      self.CopyPresetLayerFilterParametersRequest = {}
      self.CopyPresetLayerFilterParametersRequest[0] = {"27aaaabbbbcccc","Mask"}
      self.CopyPresetLayerLFOParametersRequest = {}
      self.CopyPresetLayerLFOParametersRequest[0] = {"28aaaabbbbcccc","Mask"}
      self.CopyPresetLayerEnvelopeParametersRequest = {}
      self.CopyPresetLayerEnvelopeParametersRequest[0] = {"29aaaabbbbcccc","Mask"}
      self.CopyPresetLayerPatchCordsRequest = {}
      self.CopyPresetLayerPatchCordsRequest[0] = {"2Aaaaabbbbcccc","Mask"}
      self.CopyArpPatternRequest = {}
      self.CopyArpPatternRequest[0] = {"2Baaaabbbbcccc","Mask"}
      self.CopyMasterSetupRequest = {}
      self.CopyMasterSetupRequest[0] = {"2Caaaabbbb","Mask"}
      self.CopyPatternRequest = {}
      self.CopyPatternRequest[0] = {"2Daaaabbbbcccc","Mask"}
      self.CopySongRequest = {}
      self.CopySongRequest[0] = {"2Eaaaabbbbcccc","Mask"}
  end
  
  do -- utility methods
    function self.dumpHardwareConfigObject(tbl)
      if (type(tbl) ~= "table") then return end
      table_dump(tbl)
    end

    
    --- return substring of haystack by startIndex and field length
    function self.fetchDataUsingPositionAndLength(haystack,pointer,length)
      local last = pointer + length - 1
      return RequestModel.fetchDataUsingPositionStartEnd(haystack,pointer,last)
    end

    --- return substring of haystack by startIndex and field length

    ---comment
    ---@param haystack string string to search
    ---@param first integer first index of substring
    ---@param last integer last index of substring
    ---@return string result found substring
    ---@return integer length length of substring
    function self.fetchDataUsingPositionStartEnd(haystack,first,last)
      local result = string.sub(haystack,first,last)
      -- set pointer to first + len
      local length = #result -- moves pointer forward for next iteration
      return result, length
    end

    --- Fetches a substring from HAYSTACK, using a MASK/NEEDLE as a lookup table<br/>
      --searches MASK for NEED for START, END positions<br/>
      --returns substring from HAYSTACK of START, END<br/>
      --example: <br/>
      --local requestSetParameter = {}<br/>
      --requestSetParameter[0] = "0201aaaabbbb"<br/>
      --requestSetParameter[1] = {"aaaa","paramname"}<br/>
      --requestSetParameter[2] = {"bbbb","paramvalue"}<br/>
      --request = setDataUsingMask(request,requestSetMultiModeRomId[1][1],"0A01")<br/>
      --["0201aaaabbbb"] ==> ["02010A01bbbb"]<br/>
    --- @param haystack string source to fetch data
    --- @param mask string indexing string searched for needle to get substring first/last positions in haystack
    --- @param needle string search term for mask
    --- @return string - . return the haystack with replaced values
    function self.fetchDataUsingMask(haystack,mask,needle)
        local first,last = string.find(mask,needle,1,true)
        if (first ~= nil or last ~= nil) then
            first = first or 1
            local result = string.sub(haystack,first,last)
            local msg = string.format("Search dump:[%s] using mask:[%s] on needle: [%s] Found start:[%d] end:[%d] result:[%s]",haystack,mask,needle,first,last,result)
            print(msg)
            if (result == nil) then return ""
                else return result
            end
        else return haystack
        end
    end

    ---search mask for 
    ---@param haystack string - source to search
    ---@param needle string - search teram
    ---@return integer first if found, first position in haystack, else 0
    ---@return integer last if found, last posisiton in haystack, else 0
    ---@return integer len length of the needle
    ---@return string msg status message
    function self.fetchDataPositionFirstLast(haystack, needle)
      local first,last = string.find(haystack,needle,1,true)
      if (first ~= nil and last ~= nil) then
      else first = 0; last = 0 end
      local msg = string.format("Search mask:[%s] on needle: [%s] Found start:[%d] end:[%d]",haystack,needle,first,last)
      print(msg)
      return first, last, #needle, msg
    end

    ---search haystack for needle and return several formatted objects of the first/last postions<br/>
    ---results[1] = first..","..last<br/>
    ---results[2] = {first,last}<br/>
    ---results[3] = msg<br/>
    ---@param haystack string - source to search
    ---@param needle string - search teram
    ---@return table results table of various forms of first/last
    function self.fetchDataPositionFirstLastFormats (haystack,needle)
      local first, last, concat, msg
      local results = {}
      first,last, msg =  self.fetchDataPositionFirstLast(haystack,needle)
      -- string contact
      results[#results+1] = first..","..last
      results[#results+1] = {first,last}
      results[#results+1] = msg
      return results
    end

    --- Replaces a needle in a haystack with passed data
    --- @param haystack string - string to operated string replacement on
    --- @param needle string - needle to search for in haystack
    --- @param replaceWithData string - replacees the needle value in the haystack
    --- @return string - . returns the haystack with replacements made
    function self.setDataUsingMask (haystack,needle,replaceWithData)
        local result = string.gsub(haystack,needle,replaceWithData,1)
        if (result == "nil") then return haystack
        else
            local msg = string.format("Update dump:[%s] replacing:[%s] with data: [%s] result:[%s]",haystack,needle,replaceWithData,result)
            print(msg)
            return result -- return the data without changes
        end
    end

    ---Build complete Set Parameter Request
    ---@param paramId string - hexstring ParamId
    ---@param paramValue string - hexstring ParamValue
    ---@return string - full Set Parameter sysex message ready for wrapping header/footer & sending
    function self.buildPaParameterEditRequest(paramId,paramValue)
        local result = self.setDataUsingMask(self.ParameterEditRequestCommands[0][1],self.ParameterEditRequestCommands[3][1],paramId)
        result = self.setDataUsingMask(result,self.ParameterEditRequestCommands[4][1],paramValue)
        return result
    end

    function self.buildSetMultiModeRomId()
        -- local request = self.[0]
        -- request = self.setDataUsingMask(request,requestSetMultiModeRomId[1][1],"0A01")
        -- request = self.setDataUsingMask(request,requestSetMultiModeRomId[2][1],"0101")
        -- print(string.format("Built Request: [%s]",request))
        -- return request
    end

    ---Detect if message is Sysex NonRealTime: [F0**F7]
    ---Starts with F0 | Ends with F7
    ---@param msg string - message to parse
    ---@return boolean - . return true if starts with F0, ends with F7
    function self.isSysexNonRealtime(msg)
        local du = DataUtils:new()
        local resultStart = du.isStartsWith(msg,"F0",true)
        local resultEnd = du.isEndsWith(msg,"F7",true)
        if ((resultStart == true) and (resultEnd == true)) then return true
        else return false end
    end

    ---Detect if message is Sysex Universal: [F0180F0055**F7]
    ---Starts with F0180F0055 | Ends with F7
    ---@param msg string - message to parse
    ---@return boolean - . return true if starts with F0, ends with F7
    function self.isSysexUniversal(msg)
        local du = DataUtils:new()
        local resultStart = du.isStartsWith(msg,self.requestTypeEnum.SysexProteus,true)
        local resultEnd = du.isEndsWith(msg,"F7",true)
        if ((resultStart == true) and (resultEnd == true)) then return true
        else return false end
    end
    ---check that message is SysexNonRealtime, trim control bytes if true
    --- if error thrown, return the original message
    ---@param msg string - message to parse and clean
    ---@return string - . return cleaned message
    ---@return string - . return status message
    function self.cleanSysexNonRealtimeMessage(msg)
        local status, returnMsg
        local msgOriginal = msg     -- save original msg in the event error occurs
        -- if msg = nil, do nothing & return it
        if (msg == nil) then return msgOriginal, "NOTHING TODO: msg=nil, nothing to do" end

        -- check if SysexNonRealtime
        local isSysexNRT = self.isSysexNonRealtime(msg)
        print(tostring(isSysexNRT))
        -- stip SysexNonRealtime control bytes
        if ( isSysexNRT == true) then -- PROCESS MESSAGE
            msg = string.sub(msg, 3, #msg)
            msg = string.sub(msg, 1, #msg-2)
            -- check for something gone wrong 
            if (msg == nil) then -- FAIL: if result = nil, assign return message to the orginal
                status = string.format("Cleaned Message FAILED: original:[%s]",msgOriginal)
                returnMsg = msgOriginal
            else                 -- SUCCESS: assign return msg the cleaned message
                status = string.format("Cleaned Message: original:[%s] cleaned:[%s]",msgOriginal,msg)
                returnMsg = msg
            end
        else -- NOTHING TO DO: if not msg not SysexNonRealtime, assign return msg to the original
            status = string.format("msg is not SysexNonRealtime, nothing to do: [%s]",msgOriginal)
            returnMsg = msgOriginal
        end

        return returnMsg, status
    end

    ---check that message is SysexUniversal, trim control bytes if true
    --- if error thrown, return the original message
    ---@param msg string - message to parse and clean
    ---@return string - . return cleaned message
    ---@return string - . return status message
    function self.cleanSysexUniversalMessage(msg)
        local status, returnMsg
        local originalMsg = msg     -- save original msg in the event error occurs
        -- if msg = nil, do nothing & return it
        if (msg == nil) then return originalMsg, "NOTHING TODO: msg=nil, nothing to do" end

        -- check if SysexUniversal
        local isSysexUni = self.isSysexUniversal(msg)
        print(tostring(isSysexUni))

        -- stip SysexUniversal control bytes
        if ( isSysexUni == true) then -- PROCESS MESSAGE
            msg = string.sub(msg, #RequestModel.requestTypeEnum.SysexProteus+1 --[[+1 position offset--]] , #msg)
            msg = string.sub(msg, 1, #msg-2)
            -- check for something gone wrong 
            if (msg == nil) then -- FAIL: if result = nil, assign return message to the orginal
                status = string.format("Cleaned Message FAILED: original:[%s]",originalMsg)
                returnMsg = originalMsg
            else                 -- SUCCESS: assign return msg the cleaned message
                status = string.format("Cleaned Message: original:[%s] cleaned:[%s]",originalMsg,msg)
                returnMsg = msg
            end
        else -- NOTHING TO DO: if not msg not SysexUniversal, assign return msg to the original
            status = string.format("msg is not SysexUniversal, nothing to do: [%s]",originalMsg)
            returnMsg = originalMsg
        end

        return returnMsg, status
    end

    --[[ pending functions ]]--
    function self.dataNibblizeData () end
    function self.dataDeNibblizeData() end
    function self.dataDec2Hex() end
    function self.dataHex2Dec() end
  end

  return self
end
--[[ RequestModel holding ALL requests & builder/util functions: END ]]--



--[[ response parsing tests ]]--
function ResponseParseTests()
  local result, msg, status, haystack, needle, pointer, len, response
  local results = {}
  local du = DataUtils:new()
  local reqModel = RequestModel:new()
  haystack = "aaaabbbbccccdd"
  pointer = 1
  len = 4

  response = reqModel.cleanSysexUniversalMessage(RequestsTable:new().HardwareConfigurationResponse)

  local hwconfigObj = reqModel.HardwareConfigurationResponseObject:new(response)

  reqModel.dumpHardwareConfigObject(hwconfigObj)
  print("stop:")
end

ResponseParseTests()




  -- reqModel.HardwareConfigurationDataContract = 
  --   reqModel.BuildHardwareConfigurationDataContract(response)

  -- result = reqModel.fetchDataPositionFirstLast(haystack,"aaaa")
  -- result = reqModel.fetchDataPositionFirstLast(haystack,"bbbb")
  -- result = reqModel.fetchDataPositionFirstLast(haystack,"cccc")
  -- result = reqModel.fetchDataPositionFirstLast(haystack,"dd")


-- HWConfigDump
--   reqModel.HardwareConfigurationResponseData.getHardwareConfigResponseData(RequestsTable:new().HardwareConfigurationResponse)
--   print(string.format("Instrument Count: [%s]",reqModel.HardwareConfigurationResponseData.simDataTableList[1].simInstrumentCount))

--[[ fetchData functions
    haystack = "aaaabbbbccccdd"
  pointer = 1
  len = 4
  -- reqModel.fetchDataUsingPositionAndLength(haystack,pointer,len)
  len = 4 result, pointer = reqModel.fetchDataUsingPositionAndLength(haystack,pointer,len)
  len = 4 result, pointer = reqModel.fetchDataUsingPositionAndLength(haystack,pointer,len)
  len = 4 result, pointer = reqModel.fetchDataUsingPositionAndLength(haystack,pointer,len)
  len = 2 result, pointer = reqModel.fetchDataUsingPositionAndLength(haystack,pointer,len)
  pointer = 1
  len = 4 result, pointer = reqModel.fetchDataUsingPositionStartEnd(haystack,pointer,pointer+len-1)
  len = 4 result, pointer = reqModel.fetchDataUsingPositionStartEnd(haystack,pointer,pointer+len-1)
  len = 4 result, pointer = reqModel.fetchDataUsingPositionStartEnd(haystack,pointer,pointer+len-1)
  len = 2 result, pointer = reqModel.fetchDataUsingPositionStartEnd(haystack,pointer,pointer+len-1)
]]

--[[ maphex
function mapHex2()
  local results = {}
  results[#results+1] = string.format("du.hex2IntBase16(\"A0\")  : [%d]", du.hex2IntBase16("A0")   ) --   160
  results[#results+1] = string.format("du.hex2IntBase16(\"A0A0\"): [%d]", du.hex2IntBase16("A0A0") ) -- 41120
  results[#results+1] = string.format("du.hex2IntBase16(\"FF00\"): [%d]", du.hex2IntBase16("FF00") ) -- 65280
  results[#results+1] = string.format("du.hex2IntBase16(\"00FF\"): [%d]", du.hex2IntBase16("00FF") ) --   255
  results[#results+1] = string.format("du.hex2IntBase16(\"FFFF\"): [%d]", du.hex2IntBase16("FFFF") ) -- 65535
  results[#results+1] = string.format("du.hex2IntBase16(\"0000\"): [%d]", du.hex2IntBase16("0000") ) --     0
  results[#results+1] = string.format("du.Int2Hex2Byte(255)    : [%s]", du.Int2Hex2Byte(255)     )   --  00ff
  results[#results+1] = string.format("du.Int2Hex2Byte(1024)   : [%s]", du.Int2Hex2Byte(1024)    )   --  0400
  results[#results+1] = string.format("du.Int2Hex2Byte(9999)   : [%s]", du.Int2Hex2Byte(9999)    )   --  270f
  results[#results+1] = string.format("du.Int2Hex128(255)      : [%s]", du.Int2Hex128(255)       ) --  00ff
  results[#results+1] = string.format("du.Int2Hex128(1024)     : [%s]", du.Int2Hex128(1024)      ) --  0400
  results[#results+1] = string.format("du.Int2Hex128(9999)     : [%s]", du.Int2Hex128(9999)      ) --  270f
  results[#results+1] = string.format("du.Int2Hex128(-1)       : [%s]", du.Int2Hex128(-1)        )

  -- for v pairs (results) do
  --   print(v)
  -- end
  for key, value in pairs(results) do
    print(string.format("key:[%s] value:[%s]",key,value))
  end


end

function mapHex(value,length)
  local results = {}

  -- results[#results+1] = string.format("du.hex2IntBase16('A0')  : [%d]", du.hex2IntBase16('A0')   ) --   160

  -- results[#results+1] = string.format("%.0008x",value):sub(length)
  -- results[#results+1] = string.format("%.008x",value):sub(length)
  results[#results+1] = string.format("%.08x",value):sub(length)
  results[#results+1] = string.format("%.8x",value):sub(length)

  -- results[#results+1] = string.format("%.0007x",value):sub(length)
  -- results[#results+1] = string.format("%.007x",value):sub(length)
  results[#results+1] = string.format("%.07x",value):sub(length)
  results[#results+1] = string.format("%.7x",value):sub(length)

  -- results[#results+1] = string.format("%.0006x",value):sub(length)
  -- results[#results+1] = string.format("%.006x",value):sub(length)
  results[#results+1] = string.format("%.06x",value):sub(length)
  results[#results+1] = string.format("%.6x",value):sub(length)

  -- results[#results+1] = string.format("%.0005x",value):sub(length)
  -- results[#results+1] = string.format("%.005x",value):sub(length)
  results[#results+1] = string.format("%.05x",value):sub(length)
  results[#results+1] = string.format("%.5x",value):sub(length)

  -- results[#results+1] = string.format("%.0004x",value):sub(length)
  -- results[#results+1] = string.format("%.004x",value):sub(length)
  results[#results+1] = string.format("%.04x",value):sub(length)
  results[#results+1] = string.format("%.4x",value):sub(length)

  -- results[#results+1] = string.format("%.0003x",value):sub(length)
  -- results[#results+1] = string.format("%.003x",value):sub(length)
  results[#results+1] = string.format("%.03x",value):sub(length)
  results[#results+1] = string.format("%.3x",value):sub(length)

  -- results[#results+1] = string.format("%.0002x",value):sub(length)
  -- results[#results+1] = string.format("%.002x",value):sub(length)
  results[#results+1] = string.format("%.02x",value):sub(length)
  results[#results+1] = string.format("%.2x",value):sub(length)


  -- results[#results+1] = string.format("%.0001x",value):sub(length)
  -- results[#results+1] = string.format("%.001x",value):sub(length)
  results[#results+1] = string.format("%.01x",value):sub(length)
  results[#results+1] = string.format("%.1x",value):sub(length)


  -- results[#results+1] = string.format("%00080x",value):sub(length)
  -- results[#results+1] = string.format("%0080x",value):sub(length)
  results[#results+1] = string.format("%080x",value):sub(length)
  results[#results+1] = string.format("%80x",value):sub(length)
  results[#results+1] = string.format("%0008x",value):sub(length)
  results[#results+1] = string.format("%008x",value):sub(length)
  results[#results+1] = string.format("%08x",value):sub(length)
  results[#results+1] = string.format("%8x",value):sub(length)

  -- results[#results+1] = string.format("%00070x",value):sub(length)
  -- results[#results+1] = string.format("%0070x",value):sub(length)
  results[#results+1] = string.format("%070x",value):sub(length)
  results[#results+1] = string.format("%70x",value):sub(length)
  results[#results+1] = string.format("%0007x",value):sub(length)
  results[#results+1] = string.format("%007x",value):sub(length)
  results[#results+1] = string.format("%07x",value):sub(length)
  results[#results+1] = string.format("%7x",value):sub(length)

  -- results[#results+1] = string.format("%00060x",value):sub(length)
  -- results[#results+1] = string.format("%0060x",value):sub(length)
  results[#results+1] = string.format("%060x",value):sub(length)
  results[#results+1] = string.format("%60x",value):sub(length)
  results[#results+1] = string.format("%0006x",value):sub(length)
  results[#results+1] = string.format("%006x",value):sub(length)
  results[#results+1] = string.format("%06x",value):sub(length)
  results[#results+1] = string.format("%6x",value):sub(length)

  -- results[#results+1] = string.format("%00050x",value):sub(length)
  -- results[#results+1] = string.format("%0050x",value):sub(length)
  results[#results+1] = string.format("%050x",value):sub(length)
  results[#results+1] = string.format("%50x",value):sub(length)
  results[#results+1] = string.format("%0005x",value):sub(length)
  results[#results+1] = string.format("%005x",value):sub(length)
  results[#results+1] = string.format("%05x",value):sub(length)
  results[#results+1] = string.format("%5x",value):sub(length)

  -- results[#results+1] = string.format("%00040x",value):sub(length)
  -- results[#results+1] = string.format("%0040x",value):sub(length)
  results[#results+1] = string.format("%040x",value):sub(length)
  results[#results+1] = string.format("%40x",value):sub(length)
  results[#results+1] = string.format("%0004x",value):sub(length)
  results[#results+1] = string.format("%004x",value):sub(length)
  results[#results+1] = string.format("%04x",value):sub(length)
  results[#results+1] = string.format("%4x",value):sub(length)

  -- results[#results+1] = string.format("%00030x",value):sub(length)
  -- results[#results+1] = string.format("%0030x",value):sub(length)
  results[#results+1] = string.format("%030x",value):sub(length)
  results[#results+1] = string.format("%30x",value):sub(length)
  results[#results+1] = string.format("%0003x",value):sub(length)
  results[#results+1] = string.format("%003x",value):sub(length)
  results[#results+1] = string.format("%03x",value):sub(length)
  results[#results+1] = string.format("%3x",value):sub(length)

  -- results[#results+1] = string.format("%00020x",value):sub(length)
  -- results[#results+1] = string.format("%0020x",value):sub(length)
  results[#results+1] = string.format("%020x",value):sub(length)
  results[#results+1] = string.format("%20x",value):sub(length)
  results[#results+1] = string.format("%0002x",value):sub(length)
  results[#results+1] = string.format("%002x",value):sub(length)
  results[#results+1] = string.format("%02x",value):sub(length)
  results[#results+1] = string.format("%2x",value):sub(length)

  -- results[#results+1] = string.format("%00010x",value):sub(length)
  -- results[#results+1] = string.format("%0010x",value):sub(length)
  results[#results+1] = string.format("%010x",value):sub(length)
  results[#results+1] = string.format("%10x",value):sub(length)
  results[#results+1] = string.format("%0001x",value):sub(length)
  results[#results+1] = string.format("%001x",value):sub(length)
  results[#results+1] = string.format("%01x",value):sub(length)
  results[#results+1] = string.format("%1x",value):sub(length)


  -- results[#results+1] = string.format("%01x",value):sub(length)
  -- results[#results+1] = string.format("%01x",value):sub(length)
  -- results[#results+1] = string.format("%01x",value):sub(length)
  -- results[#results+1] = string.format("%01x",value):sub(length)

  for key, value in pairs(results) do
    print(string.format("key:[%s] value:[%s]",key,value))
  end
end

local values = {"-1","0","1","127","128","254","255","1024","1023","65534","65535","65536"}
for key, value in pairs(values) do
  for len=1,8 do
    mapHex(value,len)
  end
end


]]--

-- string.format("%.2x",value):sub(length)
-- string.format("%04x",valueInt256)
-- string.format("%.4x",value):sub(length)
-- string.format("%.2x",value):sub(length)
-- string.format("%04x",valueInt256)


--[[ Dump Tests

DeviceInquiry
DeviceInquiryResponse

HardwareConfigurationRequest
HardwareConfigurationResponse

PresetDumpHeaderClosedLoopRequest
PresetDumpHeaderClosedLoopResponse

PresetDumpHeaderClosedLoopResponse

self.ACKClosedLoopwithPacketCounter = {}

self.SetupDumpResponse = {}




]]--

--[[ tests 

function RequestModelTests()
    --RequestModel Tests
    local reqModel = RequestModel:new()
    -- test table access
    print(reqModel.ParameterEditRequestCommands[0][1])
    
    -- test internal fetchDataUsingMask()
    local resp = "1001aaaabbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm"
    local resp1 = "10019999bbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm"
    
    local result = reqModel.fetchDataUsingMask(resp1,
    reqModel.PresetDumpHeaderClosedLoopResponse[0][1],
    reqModel.PresetDumpHeaderClosedLoopResponse[3][1])
    print(result)
    result = reqModel.ParameterEditRequest[0][1]
    print(result) -- 9999
    -- build a complte ParameterSet Message using RequestModlinternal function
    local msg = reqModel.buildPaParameterEditRequest("0A01","0109")
    print(msg)
end
RequestModelTests()

]]--

--[[ unused functions

---Fetches a substring from HAYSTACK, using a MASK/NEEDLE as a lookup table<br/>
---searches MASK for NEED for START, END positions<br/>
---returns substring from HAYSTACK of START, END<br/>
---<br/>
---example: <br/>
--- local requestSetParameter = {}<br/>
--- requestSetParameter[0] = "0201aaaabbbb"<br/>
--- requestSetParameter[1] = {"aaaa","paramname"}<br/>
--- requestSetParameter[2] = {"bbbb","paramvalue"}<br/>
--- request = setDataUsingMask(request,requestSetMultiModeRomId[1][1],"0A01")<br/>
--- ["0201aaaabbbb"] ==> ["02010A01bbbb"]<br/>
---@param haystack string source to fetch data
---@param mask string indexing string searched for needle to get substring first/last positions in haystack
---@param needle string search term for mask
---@return string - . return the haystack with replaced values
function FetchDataUsingMask(haystack,mask,needle)
    local first,last = string.find(mask,needle,1,true)
    local result = string.sub(haystack,first,last)
    local msg = string.format("Search dump:[%s] using mask:[%s] on needle: [%s] Found start:[%d] end:[%d] result:[%s]",haystack,mask,needle,first,last,result)
    print(msg)
    if (result == nil) then return ""
    else return result
    end
end

---Replaces a needle in a haystack with passed data
---@param haystack string - string to operated string replacement on
---@param needle string - needle to search for in haystack
---@param replaceWithData string - replacees the needle value in the haystack
---@return string - . returns the haystack with replacements made
function SetDataUsingMask(haystack,needle,replaceWithData)
    local result = string.gsub(haystack,needle,replaceWithData,1)
    local msg = string.format("Update dump:[%s] replacing:[%s] with data: [%s] result:[%s]",haystack,needle,replaceWithData,result)
    print(msg)
    if (result == "nil") then return ""
    else return haystack -- return the data without changes
    end
end

]]--

--[[ Utilty Object for packing all utils in one place 
local DataUtils = {}
function DataUtils:new(o)
    o = o or {}
    setmetatable({},self)
    self.__index = self
    return self 
end
local dataUtils = DataUtils:new()
]]--

--[[
local request = {}
function request:new(o)
    o = o or {}
    setmetatable({},self)
    self.__index = self

    self.requestType = ""
    self.command = ""
    self.request = ""
    self.maskRequest = ""
    self.response = ""
    self.maskResponse = ""


    return self
end
]]--

--[[ DeviceInquiryReponseData
-- Identity Response
-- clean msg of SysexNonRealtime control bytes
msg, status = reqModel.cleanSysexNonRealtimeMessage(RequestsTable:new().IdentityResponse)
print(string.format("current msg:[%s] status:[%s]",msg, status))

-- fetch DeviceInquiryReponseData
local mask = reqModel.DeviceInquiryResponse[0][1]
for i=4,6 do -- iterate fields and assign to reciprocal indices in the data table
    reqModel.DeviceInquiryResponseData[i] =  reqModel.fetchDataUsingMask(msg,
    mask,
    reqModel.DeviceInquiryResponse[i][1]
)
end
print(table.concat(reqModel.DeviceInquiryResponseData,","))
]]--


--[[ HWConfigDump PoC code

    -- HWConfigDump
    -- fetch HWConfigDump & clean it of sysex control bytes
    msg,status = RequestModel.cleanSysexUniversalMessage(RequestsTable:new().HardwareConfigurationResponse)
    print(string.format("current msg:[%s] status:[%s]",msg, status))
    
    mask = reqModel.HardwareConfigurationResponse[0][1]
    reqModel.HardwareConfigurationResponseData.userPresetCount = reqModel.fetchDataUsingMask(msg, mask,
    reqModel.HardwareConfigurationResponse[3][1]
)
reqModel.HardwareConfigurationResponseData.simCount = reqModel.fetchDataUsingMask(msg, mask,
reqModel.HardwareConfigurationResponse[4][1]
)
  reqModel.HardwareConfigurationResponseData.simBytesPer = reqModel.fetchDataUsingMask(msg, mask,
  reqModel.HardwareConfigurationResponse[5][1]
)
reqModel.HardwareConfigurationResponseData.simDataTable = reqModel.HardwareConfigurationResponseData.simDataIterator(msg,
du.hex2IntBase16(reqModel.HardwareConfigurationResponseData.simCount)
    )

print(table.concat(reqModel.HardwareConfigurationResponseData.simDataTableList,","))

- single simData object for building simDataTable: NOT FOR STORING DATA DIRECTLY 
fields [6,7,8]
simSimPresetsMask = string.format("%s,%s,%s",
    self.HardwareConfigurationResponse[6][1], --eeee
    self.HardwareConfigurationResponse[7][1], --ffff
    self.HardwareConfigurationResponse[8][1]  --gggg
),


]]--


--[[ MESSAGES INBOUND


==========================
-- preset dump
==========================
    | msg# | Sysex |
| - | - |
 1 | F0180F0055100103015E0B0000380013001000140004001F0003000A002A0048000000F7 |
 2 | F0180F00551002010073796E3A4E6F726469636120202020205F00320000000000000059007F00000000001E005A0000002D0003000E0000002A00620064002B006300640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070052010500000001000000010000000000000000000000000000007F0000000E0000000E003000400020001600000000000200000006000000280000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E002C00000078F7 |
 3 | F0180F00551002020000000000000000006C000000000000007F000000000000007F0000000000000000004F0000000000000004000800010000000000000000000E000200000000004A0000000000000000006A7F0100000000000100010000006400400062002A000000000064000000230000000000010000003200000028003D0000000100640015000A0000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900447F23004A00447F24004C00410025004B00307F0C00400000002800310150000C003800000029002BF7 |
 4 | F0180F005510020300330164006800380000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064001301380000002A003D013C00120038002600000007007B7F00000000000067000600000000007F000000000000007F00000000007C7F0000000000000000000000000800010000000000000000000E00000037000E004B0000000000000000000F000000000000000100010000003F0059004F0010000000000064006E00000000000000010000006400100050003100000000006400460000000000000001000000000000006300140000000000640000006400000000000000000000005AF7 |
 5 | F0180F0055100204000C004000180010003000060060003000000011002A0106001600080064005000380064000C003800570009003800410014003800280015003900320020002D012700240038012100280051005A7F290052001700220049005D7F23004B00587F680038000000640041000000240039013800210030002400250068000C0012000000000009004000737F0900410026000000287F00000000000046006C000000000000007F000000000000007F00000000000000060000000C000000000007000000010000000000040000000E0001000800080047000000000000000000000000000000000000000100050043000000630074F7 |
 6 | F0180F00551002050028000000590064007D005F0000000000010021005100460063003E0000004A006400770056000000000001000000000000006300250000000000640000006400000000000000000000000C004000090010003000060060003000000011002A0106000C0038002A00500038002C00090038003E0016000800410012002A01030014002D010F0068004100190068002F0009000A00490005000A005100070014002E01577F200040004500090051001200120038000A00210030002400250068000C0000000000000000000000000000000000000000000000000000007B7F000000000000000060000500000000007F00000014F7 |
 7 | F0180F005510020600000000007F000000000000000E0000000C000000000000000000010000000000000000000E0001000D001B004700000000000000000008000000000000000000010001002B00000063004A000000670064007D005F0000000000010010003600460063004D0000004200640077002F000000000001000000000000006300250000000000640000006400000000000000000000000C004000110010003000060060003000000011002A0106000C0038002A00500038001E00090038003E0016000800410012002A01030014002D011B0068004100677F68002F00777F270030005B7F27002F00787F14002E01597F240039016DF7 |
 8 | F0180F0055100207001C7F630038000000680038010000210030002400250068000C000000000000000000000000000000000000000000000000001AF7 |
 9 | F0180F00557BF7 |

==========================
## USERBANK-000
==========================
O.179::F0180F0055110200000000F7
O.180::F0180F00557F0000F7
I.140::F0180F0055100100005E0B0000380013001000140004001F0003000A002A0048000000F7
O.181::F0180F00557F0100F7
I.141::F0180F0055100201006B69743A4B2D302020202020202020207F00000000003D0000004F0000003C0000001E00000000003C003C000E0000002E00620064002F00630064000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F000000070001020A00000001000000010000000000000000000000000000007F0000000E00000001002800600000000A000000000001000000030000000A0000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E004204000043F7
O.182::F0180F00557F0200F7
I.142::F0180F00551002020000000000290000007F000000000000007F000000000000007F0000000000000000000000000000000C0000000000010000000000000000000E00000000000000707F0100000000000100677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C003800000029005FF7
O.183::F0180F00557F0300F7
I.143::F0180F005510020300330150006800410000002A00350164002B0068000C006000300000002C0038014C002D00300026002D002F0006001600080064000000000000000000000000000000000000001B060600000000000000000024000000000000007F000000000000007F0000000000000000000000000001000C0000000000010000000000000000000E00000000000000707F0100000000000100677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000038F7
O.184::F0180F00557F0400F7
I.144::F0180F00551002040014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C0038014C002D00300026002D002F00060016000800640000000000000000000000000000000000000022040600000000002500000028000000000000007F000000000000007F0000000000000000000000000001000C0000000000010000000000000000000E00000000000000707F0100000000000100677F0100000000000100010000006400000064005DF7
O.185::F0180F00557F0500F7
I.145::F0180F005510020500140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C0038014C002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F0000000CF7
O.186::F0180F00557F0600F7
I.146::F0180F005510020600000000007F0000000000000000000000000000000C0000000000010000000000000000000E00000000000000707F0100000000000100677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B00680002F7
O.187::F0180F00557F0700F7
I.147::F0180F0055100207000C006000300000002C0038014C002D00300026002D002F0006001600080064000000000000000000000000000000000000004BF7
I.148::F0180F00557BF7

O.188::F0180F005501020A010000F7
O.189::F0180F0055010201077F7FF7


==========================
-- Preset Select CC0, CC32, (?ROM/Preset?) select
==========================
-- xl7
OE.1::b0000e
OE.2::b02000
OE.3::c02300
OE.4::b0000e
OE.5::b02000
OE.6::c02400
-- user
OE.7::b00000
OE.8::b02000
OE.9::c02400
OE.10::b00000
OE.11::b02000
OE.12::c04000

==========================
SESSION NOTES
==========================

F0 7E 00 - Universal System Exclusive Non-realtime header
F0 - SOX
7E - SysExclusive Non-realtime
00 - DeviceID

06 - General Information
01 - Identity Request
F7 - EOX

O.2::F0 7E 00 06 01 F7
I.1::F0 7E 00 06 02 18 04 04 0D 00 32 2E 30 30 F7


==========================
SESSION START SEQUENCE
==========================


-- identity request
O.1::F0 7E 00 06 01 F7
I.1::F0 7E 00 06 02 18 04 04 0D 00 32 2E 30 30 F7

-- set sysex common delay
O.3::F0 18 0F 00 55 01 02 15 03 20 01 F7

--HardwareConfigurationRequest
O.4::F0180F00550AF7
--HardwareConfigurationResponse
I.3::F0180F00550902000401060E0000043B09F7
-- ACK
O.5::F0180F00557F0000F7


-- SetupDumpRequest
O.6::F0180F00551DF7

-- ??? ACK ???? <== for ???SetupDumpResponse??
O.7::F07F0004015000F7

-- SetupDumpResponse 
I.4::F0180F00551C1E00230010001500030020000900557365722053657475702020202020200001010000000000020000000100010000000100000002007F7F7F7F0000000000000E0000003E007F7F0100000005000100000000000000010001000200000000004A00470019001A0049004B005500480040004100420011001000010020014E004D001B001C00010003005200530001000000000000000000000000000100000001002800600000000A0014001E000100000003000000000000000000000000000100000000000A00000001000000010000000000000000000000000000007F000000030000000000000000007F7F1F0003017F0040007F7F0000010000000100000001007F0040007F7F0000010000000100000002007F0040007F7F0000010000000100000003007F0040007F7F0000010000000100000004007F0040007F7F0000010000000100000005007F0040007F7F0000010000000100000006007F0040007F7F0000010000000100000007007F0040007F7F0000010000000100000008007F0040007F7F0000010000000100000009007F0040007F7F000001000000010000000A007F0040007F7F000001000000010000000B007F0040007F7F000001000000010000000C007F0040007F7F000001000000010000000D007F0040007F7F000001000000010000000E007F0040007F7F000001000000010000000F007F0040007F7F0000010000000100000010007F0040007F7F0000010000000100000011007F0040007F7F0000010000000100000012007F0040007F7F0000010000000100000013007F0040007F7F0000010000000100000014007F0040007F7F0000010000000100000015007F0040007F7F0000010000000100000016007F0040007F7F0000010000000100000017007F0040007F7F0000010000000100000018007F0040007F7F0000010000000100000019007F0040007F7F000001000000010000001A007F0040007F7F000001000000010000001B007F0040007F7F000001000000010000001C007F0040007F7F000001000000010000001D007F0040007F7F000001000000010000001E007F0040007F7F000001000000010000001F007F0040007F7F00000100000001000000F7


-- MultiMode Commands
O.8::F0180F0055010201010000F7
O.9::F0180F005501020B010000F7
O.10::F0180F0055110203010000F7
-- MultiMode Commands


-- Preset Dump Header Response
I.5::F0180F0055100103015E0B0000380013001000140004001F0003000A002A0048000000F7
-- Preset Dump Header Response: ACK
O.11::F0180F00557F0000F7

-- Preset Dump Response: Packet #1
I. 6::F0180F00551002010073796E3A4E6F726469636120202020205F00320000000000000059007F00000000001E005A0000002D0003000E0000002A00620064002B006300640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070052010500000001000000010000000000000000000000000000007F0000000E0000000E003000400020001600000000000200000006000000280000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E002C00000078F7
-- Preset Dump Response: Packet #3 ACK
O.12::F0180F00557F0100F7

-- Preset Dump Response: Packet #2
I.7::F0180F00551002020000000000000000006C000000000000007F000000000000007F0000000000000000004F0000000000000004000800010000000000000000000E000200000000004A0000000000000000006A7F0100000000000100010000006400400062002A000000000064000000230000000000010000003200000028003D0000000100640015000A0000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900447F23004A00447F24004C00410025004B00307F0C00400000002800310150000C003800000029002BF7
-- Preset Dump Response: Packet #2 ACK
O.13::F0180F00557F0200F7

-- Preset Dump Response: Packet #3
I.8::F0180F005510020300330164006800380000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064001301380000002A003D013C00120038002600000007007B7F00000000000067000600000000007F000000000000007F00000000007C7F0000000000000000000000000800010000000000000000000E00000037000E004B0000000000000000000F000000000000000100010000003F0059004F0010000000000064006E00000000000000010000006400100050003100000000006400460000000000000001000000000000006300140000000000640000006400000000000000000000005AF7
-- Preset Dump Response: Packet #3 ACK
O.14::F0180F00557F0300F7

-- Preset Dump Response: Packet #4
I.9::F0180F0055100204000C004000180010003000060060003000000011002A0106001600080064005000380064000C003800570009003800410014003800280015003900320020002D012700240038012100280051005A7F290052001700220049005D7F23004B00587F680038000000640041000000240039013800210030002400250068000C0012000000000009004000737F0900410026000000287F00000000000046006C000000000000007F000000000000007F00000000000000060000000C000000000007000000010000000000040000000E0001000800080047000000000000000000000000000000000000000100050043000000630074F7
-- Preset Dump Response: Packet #4 ACK
O.15::F0180F00557F0400F7

-- Preset Dump Response: Packet #5
I.10::F0180F00551002050028000000590064007D005F0000000000010021005100460063003E0000004A006400770056000000000001000000000000006300250000000000640000006400000000000000000000000C004000090010003000060060003000000011002A0106000C0038002A00500038002C00090038003E0016000800410012002A01030014002D010F0068004100190068002F0009000A00490005000A005100070014002E01577F200040004500090051001200120038000A00210030002400250068000C0000000000000000000000000000000000000000000000000000007B7F000000000000000060000500000000007F00000014F7
-- Preset Dump Response: Packet #5 ACK
O.16::F0180F00557F0500F7

-- Preset Dump Response: Packet #6
I.11::F0180F005510020600000000007F000000000000000E0000000C000000000000000000010000000000000000000E0001000D001B004700000000000000000008000000000000000000010001002B00000063004A000000670064007D005F0000000000010010003600460063004D0000004200640077002F000000000001000000000000006300250000000000640000006400000000000000000000000C004000110010003000060060003000000011002A0106000C0038002A00500038001E00090038003E0016000800410012002A01030014002D011B0068004100677F68002F00777F270030005B7F27002F00787F14002E01597F240039016DF7
-- Preset Dump Response: Packet #6 ACK
O.17::F0180F00557F0600F7

-- Preset Dump Response: Packet #7
I.12::F0180F0055100207001C7F630038000000680038010000210030002400250068000C000000000000000000000000000000000000000000000000001AF7
-- Preset Dump Response: Packet #7 ACK
O.18::F0180F00557F0700F7
-- -- Preset Dump Response: EOF
I.13::F0180F00557BF7


-- multi-mode ROM?
O.19::F0180F005501020A010000F7
-- edit buffer
O.20::F0180F0055010201077F7FF7


==========================
SESSION START SEQUENCE: DONE
==========================
]]--



        --[[
        self.BuildHardwareConfigurationDataContract = function(response)
          local contract = self.HardwareConfigurationDataContract.new()
          local mask = self.HardwareConfigurationResponse[0][1]
          contract.MaskMessage = mask
          contract.MaskSimmObjects = "eeeeffffgggg"
          contract.Command = RequestModel.fetchDataPositionFirstLastFormats(mask,self.HardwareConfigurationResponse[1][1])[2]
          contract.GeneralInfoBytes = RequestModel.fetchDataPositionFirstLastFormats(mask,self.HardwareConfigurationResponse[2][1])[2]
          contract.UserPresetCount = RequestModel.fetchDataPositionFirstLastFormats(mask,self.HardwareConfigurationResponse[3][1])[2]
          contract.SimmCount = RequestModel.fetchDataPositionFirstLastFormats(mask,self.HardwareConfigurationResponse[4][1])[2]
          contract.SimmBytePer = RequestModel.fetchDataPositionFirstLastFormats(mask,self.HardwareConfigurationResponse[5][1])[2]
          contract.SimmsTableStartPointer = contract.SimmCount[2]+1
          contract.SimmsTableList = {}
          local pointer = contract.SimmsTableStartPointer
          local countHex, _ = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmCount[1], contract.SimmCount[2])
          local count = self.du.hex2IntBase16(countHex)
          for i=1,count do
            local t = {}
            local first,last,len
            first,last,len = self.fetchDataPositionFirstLast(contract.MaskSimmObjects,self.HardwareConfigurationResponse[6][1])
            t.SimmID = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
            first,last,len = self.fetchDataPositionFirstLast(contract.MaskSimmObjects,self.HardwareConfigurationResponse[7][1])
            t.SimmPresetCount = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
            first,last,len = self.fetchDataPositionFirstLast(contract.MaskSimmObjects,self.HardwareConfigurationResponse[8][1])
            t.SimmInstrumentCount = {first+pointer,last+pointer} -- shift first,last by pointer amount & asign
            pointer = pointer + len -- update pointer by len
            table.insert(contract.SimmsTableList,t)
          end
          return contract
        end
        
        ]]--

    -- self.BuildHardwareConfigurationDataObject = function(response)
    --   local obj = self.HardwareConfigurationResponseObject.new()
    --   local contract = self.HardwareConfigurationDataContract.new(response)
    --   obj.generalInfoBytes = RequestModel.fetchDataUsingPositionStartEnd(response,contract.GeneralInfoBytes[1],contract.GeneralInfoBytes[2])
    --   obj.userPresetCount = RequestModel.fetchDataUsingPositionStartEnd(response,contract.userPresetCount[1],contract.userPresetCount[2])
    --   obj.simmCount = RequestModel.fetchDataUsingPositionStartEnd(response,contract.simmCount[1],contract.simmCount[2] )
    --   obj.simmInfoBytesPer = RequestModel.fetchDataUsingPositionStartEnd(response,contract.simmInfoBytesPer[1],contract.GeneralInfoBytes[2])

    --   for i=1,self.du.hex2IntBase16(obj.simmCount) do
    --     local simm = obj.simmDataModel.new()
    --     simm.simmId = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].simmID[1],contract.SimmsTableList[i].simmID[2])
    --     simm.simmPresets = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].simmPresets[1],contract.SimmsTableList[i].simmPresets[2])
    --     simm.simmInstruments = RequestModel.fetchDataUsingPositionStartEnd(response,contract.SimmsTableList[i].simmInstruments[1],contract.SimmsTableList[i].simmInstruments[2])
    --     table.insert(obj.SimmsTableList,simm)
    --   end
    -- end