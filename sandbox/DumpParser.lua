
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
  return self
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
    self.SetupDump[257] = {31,32}
    self.SetupDump[258] = {33,34}
    self.SetupDump[259] = {35,36}
    self.SetupDump[260] = {37,38}
    self.SetupDump[264] = {39,40}
    self.SetupDump[264] = {41,42}
    self.SetupDump[265] = {43,44}
    self.SetupDump[266] = {45,46}
    self.SetupDump[267] = {47,48}
    self.SetupDump[268] = {49,50}
    self.SetupDump[269] = {51,52}
    -- self.SetupDump[] = {53,54}
    -- self.SetupDump[] = {55,56}
    -- self.SetupDump[] = {57,58}
    -- self.SetupDump[] = {59,60}
    -- self.SetupDump[] = {61,62}
    -- self.SetupDump[] = {63,64}
    -- self.SetupDump[] = {65,66}
    -- self.SetupDump[] = {67,68}
    -- self.SetupDump[] = {69,70}
    -- self.SetupDump[] = {71,72}
    -- self.SetupDump[] = {73,74}
    -- self.SetupDump[] = {75,76}
    -- self.SetupDump[] = {77,78}
    -- self.SetupDump[] = {79,80}
    -- self.SetupDump[] = {81,82}
    -- self.SetupDump[] = {83,84}
    -- self.SetupDump[] = {85,86}
    -- self.SetupDump[] = {87,88}
    -- self.SetupDump[] = {89,90}
    self.SetupDump[385] = {91,92}
    self.SetupDump[386] = {93,94}
    self.SetupDump[388] = {95,96}
    self.SetupDump[391] = {97,98}
    self.SetupDump[392] = {99,100}
    self.SetupDump[393] = {101,102}
    self.SetupDump[394] = {103,104}
    self.SetupDump[395] = {105,106}
    self.SetupDump[396] = {107,108}
    self.SetupDump[397] = {109,110}
    self.SetupDump[398] = {111,112}
    self.SetupDump[399] = {113,114}
    self.SetupDump[400] = {115,116}
    self.SetupDump[401] = {117,118}
    self.SetupDump[402] = {119,120}
    self.SetupDump[403] = {121,122}
    self.SetupDump[404] = {123,124}
    self.SetupDump[405] = {125,126}
    self.SetupDump[406] = {127,128}
    self.SetupDump[407] = {129,130}
    self.SetupDump[408] = {131,132}
    self.SetupDump[409] = {133,134}
    self.SetupDump[411] = {135,136}
    self.SetupDump[412] = {137,138}
    self.SetupDump[413] = {139,140}
    self.SetupDump[414] = {141,142}
    self.SetupDump[415] = {143,144}
    self.SetupDump[416] = {145,146}
    self.SetupDump[417] = {147,148}
    self.SetupDump[418] = {149,150}
    self.SetupDump[419] = {151,152}
    self.SetupDump[420] = {153,154}
    self.SetupDump[421] = {155,156}
    self.SetupDump[422] = {157,158}
    -- self.SetupDump[OWN] = {159,160}
    self.SetupDump[513] = {161,162}
    self.SetupDump[514] = {163,164}
    self.SetupDump[515] = {165,166}
    self.SetupDump[516] = {167,168}
    self.SetupDump[517] = {169,170}
    self.SetupDump[518] = {171,172}
    self.SetupDump[519] = {173,174}
    self.SetupDump[520] = {175,176}
    self.SetupDump[521] = {177,178}
    self.SetupDump[522] = {179,180}
    self.SetupDump[523] = {181,182}
    self.SetupDump[524] = {183,184}
    self.SetupDump[525] = {185,186}
    self.SetupDump[526] = {187,188}
    self.SetupDump[527] = {189,190}
    self.SetupDump[528] = {191,192}
    self.SetupDump[641] = {193,194}
    self.SetupDump[642] = {195,196}
    self.SetupDump[643] = {197,198}
    self.SetupDump[644] = {199,200}
    self.SetupDump[645] = {201,202}
    self.SetupDump[646] = {203,204}
    self.SetupDump[647] = {205,206}
    self.SetupDump[648] = {207,208}
    self.SetupDump[649] = {209,210}
    self.SetupDump[650] = {211,212}
    self.SetupDump[651] = {213,214}
    self.SetupDump[652] = {215,216}
    self.SetupDump[653] = {217,218}
    self.SetupDump[654] = {219,220}
    self.SetupDump[655] = {221,222}
    self.SetupDump[656] = {223,224}
    self.SetupDump[657] = {225,226}
    self.SetupDump[658] = {227,228}
    self.SetupDump[659] = {229,230}
    self.SetupDump[661] = {231,232}
    self.SetupDump[768] = {233,234}
    self.SetupDump[139] = {235,236}
    self.SetupDump[140] = {237,238}
    self.SetupDump[141] = {239,240}
    self.SetupDump[130] = {241,242}
    self.SetupDump[131] = {243,244}
    self.SetupDump[132] = {245,246}
    self.SetupDump[133] = {247,248}
    self.SetupDump[134] = {249,250}
    self.SetupDump[135] = {251,252}
    self.SetupDump[136] = {253,254}
    self.SetupDump[137] = {255,256}
    self.SetupDump[138] = {257,258}
    self.SetupDump[130] = {259,260}
    self.SetupDump[131] = {261,262}
    self.SetupDump[132] = {263,264}
    self.SetupDump[133] = {265,266}
    self.SetupDump[134] = {267,268}
    self.SetupDump[135] = {269,270}
    self.SetupDump[136] = {271,272}
    self.SetupDump[137] = {273,274}
    self.SetupDump[138] = {275,276}
    self.SetupDump[130] = {277,278}
    self.SetupDump[131] = {279,280}
    self.SetupDump[132] = {281,282}
    self.SetupDump[133] = {283,284}
    self.SetupDump[134] = {285,286}
    self.SetupDump[135] = {287,288}
    self.SetupDump[136] = {289,290}
    self.SetupDump[137] = {291,292}
    self.SetupDump[138] = {293,294}
    self.SetupDump[130] = {295,296}
    self.SetupDump[131] = {297,298}
    self.SetupDump[132] = {299,300}
    self.SetupDump[133] = {301,302}
    self.SetupDump[134] = {303,304}
    self.SetupDump[135] = {305,306}
    self.SetupDump[136] = {307,308}
    self.SetupDump[137] = {309,310}
    self.SetupDump[138] = {311,312}
    self.SetupDump[130] = {313,314}
    self.SetupDump[131] = {315,316}
    self.SetupDump[132] = {317,318}
    self.SetupDump[133] = {319,320}
    self.SetupDump[134] = {321,322}
    self.SetupDump[135] = {323,324}
    self.SetupDump[136] = {325,326}
    self.SetupDump[137] = {327,328}
    self.SetupDump[138] = {329,330}
    self.SetupDump[130] = {331,332}
    self.SetupDump[131] = {333,334}
    self.SetupDump[132] = {335,336}
    self.SetupDump[133] = {337,338}
    self.SetupDump[134] = {339,340}
    self.SetupDump[135] = {341,342}
    self.SetupDump[136] = {343,344}
    self.SetupDump[137] = {345,346}
    self.SetupDump[138] = {347,348}
    self.SetupDump[130] = {349,350}
    self.SetupDump[131] = {351,352}
    self.SetupDump[132] = {353,354}
    self.SetupDump[133] = {355,356}
    self.SetupDump[134] = {357,358}
    self.SetupDump[135] = {359,360}
    self.SetupDump[136] = {361,362}
    self.SetupDump[137] = {363,364}
    self.SetupDump[138] = {365,366}
    self.SetupDump[130] = {367,368}
    self.SetupDump[131] = {369,370}
    self.SetupDump[132] = {371,372}
    self.SetupDump[133] = {373,374}
    self.SetupDump[134] = {375,376}
    self.SetupDump[135] = {377,378}
    self.SetupDump[136] = {379,380}
    self.SetupDump[137] = {381,382}
    self.SetupDump[138] = {383,384}
    self.SetupDump[130] = {385,386}
    self.SetupDump[131] = {387,388}
    self.SetupDump[132] = {389,390}
    self.SetupDump[133] = {391,392}
    self.SetupDump[134] = {393,394}
    self.SetupDump[135] = {395,396}
    self.SetupDump[136] = {397,398}
    self.SetupDump[137] = {399,400}
    self.SetupDump[138] = {401,402}
    self.SetupDump[130] = {403,404}
    self.SetupDump[131] = {405,406}
    self.SetupDump[132] = {407,408}
    self.SetupDump[133] = {409,410}
    self.SetupDump[134] = {411,412}
    self.SetupDump[135] = {413,414}
    self.SetupDump[136] = {415,416}
    self.SetupDump[137] = {417,418}
    self.SetupDump[138] = {419,420}
    self.SetupDump[130] = {421,422}
    self.SetupDump[131] = {423,424}
    self.SetupDump[132] = {425,426}
    self.SetupDump[133] = {427,428}
    self.SetupDump[134] = {429,430}
    self.SetupDump[135] = {431,432}
    self.SetupDump[136] = {433,434}
    self.SetupDump[137] = {435,436}
    self.SetupDump[138] = {437,438}
    self.SetupDump[130] = {439,440}
    self.SetupDump[131] = {441,442}
    self.SetupDump[132] = {443,444}
    self.SetupDump[133] = {445,446}
    self.SetupDump[134] = {447,448}
    self.SetupDump[135] = {449,450}
    self.SetupDump[136] = {451,452}
    self.SetupDump[137] = {453,454}
    self.SetupDump[138] = {455,456}
    self.SetupDump[130] = {457,458}
    self.SetupDump[131] = {459,460}
    self.SetupDump[132] = {461,462}
    self.SetupDump[133] = {463,464}
    self.SetupDump[134] = {465,466}
    self.SetupDump[135] = {467,468}
    self.SetupDump[136] = {469,470}
    self.SetupDump[137] = {471,472}
    self.SetupDump[138] = {473,474}
    self.SetupDump[130] = {475,476}
    self.SetupDump[131] = {477,478}
    self.SetupDump[132] = {479,480}
    self.SetupDump[133] = {481,482}
    self.SetupDump[134] = {483,484}
    self.SetupDump[135] = {485,486}
    self.SetupDump[136] = {487,488}
    self.SetupDump[137] = {489,490}
    self.SetupDump[138] = {491,492}
    self.SetupDump[130] = {493,494}
    self.SetupDump[131] = {495,496}
    self.SetupDump[132] = {497,498}
    self.SetupDump[133] = {499,500}
    self.SetupDump[134] = {501,502}
    self.SetupDump[135] = {503,504}
    self.SetupDump[136] = {505,506}
    self.SetupDump[137] = {507,508}
    self.SetupDump[138] = {509,510}
    self.SetupDump[130] = {511,512}
    self.SetupDump[131] = {513,514}
    self.SetupDump[132] = {515,516}
    self.SetupDump[133] = {517,518}
    self.SetupDump[134] = {519,520}
    self.SetupDump[135] = {521,522}
    self.SetupDump[136] = {523,524}
    self.SetupDump[137] = {525,526}
    self.SetupDump[138] = {527,528}
    self.SetupDump[130] = {529,530}
    self.SetupDump[131] = {531,532}
    self.SetupDump[132] = {533,534}
    self.SetupDump[133] = {535,536}
    self.SetupDump[134] = {537,538}
    self.SetupDump[135] = {539,540}
    self.SetupDump[136] = {541,542}
    self.SetupDump[137] = {543,544}
    self.SetupDump[138] = {545,546}
    self.SetupDump[130] = {547,548}
    self.SetupDump[131] = {549,550}
    self.SetupDump[132] = {551,552}
    self.SetupDump[133] = {553,554}
    self.SetupDump[134] = {555,556}
    self.SetupDump[135] = {557,558}
    self.SetupDump[136] = {559,560}
    self.SetupDump[137] = {561,562}
    self.SetupDump[138] = {563,564}
    self.SetupDump[130] = {565,566}
    self.SetupDump[131] = {567,568}
    self.SetupDump[132] = {569,570}
    self.SetupDump[133] = {571,572}
    self.SetupDump[134] = {573,574}
    self.SetupDump[135] = {575,576}
    self.SetupDump[136] = {577,578}
    self.SetupDump[137] = {579,580}
    self.SetupDump[138] = {581,582}
    self.SetupDump[130] = {583,584}
    self.SetupDump[131] = {585,586}
    self.SetupDump[132] = {587,588}
    self.SetupDump[133] = {589,590}
    self.SetupDump[134] = {591,592}
    self.SetupDump[135] = {593,594}
    self.SetupDump[136] = {595,596}
    self.SetupDump[137] = {597,598}
    self.SetupDump[138] = {599,600}
    self.SetupDump[130] = {601,602}
    self.SetupDump[131] = {603,604}
    self.SetupDump[132] = {605,606}
    self.SetupDump[133] = {607,608}
    self.SetupDump[134] = {609,610}
    self.SetupDump[135] = {611,612}
    self.SetupDump[136] = {613,614}
    self.SetupDump[137] = {615,616}
    self.SetupDump[138] = {617,618}
    self.SetupDump[130] = {619,620}
    self.SetupDump[131] = {621,622}
    self.SetupDump[132] = {623,624}
    self.SetupDump[133] = {625,626}
    self.SetupDump[134] = {627,628}
    self.SetupDump[135] = {629,630}
    self.SetupDump[136] = {631,632}
    self.SetupDump[137] = {633,634}
    self.SetupDump[138] = {635,636}
    self.SetupDump[130] = {637,638}
    self.SetupDump[131] = {639,640}
    self.SetupDump[132] = {641,642}
    self.SetupDump[133] = {643,644}
    self.SetupDump[134] = {645,646}
    self.SetupDump[135] = {647,648}
    self.SetupDump[136] = {649,650}
    self.SetupDump[137] = {651,652}
    self.SetupDump[138] = {653,654}
    self.SetupDump[130] = {655,656}
    self.SetupDump[131] = {657,658}
    self.SetupDump[132] = {659,660}
    self.SetupDump[133] = {661,662}
    self.SetupDump[134] = {663,664}
    self.SetupDump[135] = {665,666}
    self.SetupDump[136] = {667,668}
    self.SetupDump[137] = {669,670}
    self.SetupDump[138] = {671,672}
    self.SetupDump[130] = {673,674}
    self.SetupDump[131] = {675,676}
    self.SetupDump[132] = {677,678}
    self.SetupDump[133] = {679,680}
    self.SetupDump[134] = {681,682}
    self.SetupDump[135] = {683,684}
    self.SetupDump[136] = {685,686}
    self.SetupDump[137] = {687,688}
    self.SetupDump[138] = {689,690}
    self.SetupDump[130] = {691,692}
    self.SetupDump[131] = {693,694}
    self.SetupDump[132] = {695,696}
    self.SetupDump[133] = {697,698}
    self.SetupDump[134] = {699,700}
    self.SetupDump[135] = {701,702}
    self.SetupDump[136] = {703,704}
    self.SetupDump[137] = {705,706}
    self.SetupDump[138] = {707,708}
    self.SetupDump[130] = {709,710}
    self.SetupDump[131] = {711,712}
    self.SetupDump[132] = {713,714}
    self.SetupDump[133] = {715,716}
    self.SetupDump[134] = {717,718}
    self.SetupDump[135] = {719,720}
    self.SetupDump[136] = {721,722}
    self.SetupDump[137] = {723,724}
    self.SetupDump[138] = {725,726}
    self.SetupDump[130] = {727,728}
    self.SetupDump[131] = {729,730}
    self.SetupDump[132] = {731,732}
    self.SetupDump[133] = {733,734}
    self.SetupDump[134] = {735,736}
    self.SetupDump[135] = {737,738}
    self.SetupDump[136] = {739,740}
    self.SetupDump[137] = {741,742}
    self.SetupDump[138] = {743,744}
    self.SetupDump[130] = {745,746}
    self.SetupDump[131] = {747,748}
    self.SetupDump[132] = {749,750}
    self.SetupDump[133] = {751,752}
    self.SetupDump[134] = {753,754}
    self.SetupDump[135] = {755,756}
    self.SetupDump[136] = {757,758}
    self.SetupDump[137] = {759,760}
    self.SetupDump[138] = {761,762}
    self.SetupDump[130] = {763,764}
    self.SetupDump[131] = {765,766}
    self.SetupDump[132] = {767,768}
    self.SetupDump[133] = {769,770}
    self.SetupDump[134] = {771,772}
    self.SetupDump[135] = {773,774}
    self.SetupDump[136] = {775,776}
    self.SetupDump[137] = {777,778}
    self.SetupDump[138] = {779,780}
    self.SetupDump[130] = {781,782}
    self.SetupDump[131] = {783,784}
    self.SetupDump[132] = {785,786}
    self.SetupDump[133] = {787,788}
    self.SetupDump[134] = {789,790}
    self.SetupDump[135] = {791,792}
    self.SetupDump[136] = {793,794}
    self.SetupDump[137] = {795,796}
    self.SetupDump[138] = {797,798}
    self.SetupDump[130] = {799,800}
    self.SetupDump[131] = {801,802}
    self.SetupDump[132] = {803,804}
    self.SetupDump[133] = {805,806}
    self.SetupDump[134] = {807,808}
    self.SetupDump[135] = {809,810}
    self.SetupDump[136] = {811,812}
    self.SetupDump[137] = {813,814}
    self.SetupDump[138] = {815,816}
    
    
  end

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