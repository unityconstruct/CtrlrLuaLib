local DataUtils = {}

function DataUtils:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self

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


  self.Int2Hex128 = function(valueInt128)
    return string.format("%2.x",valueInt128)
  end

  self.Int2Hex256 = function(valueInt256)
    return string.format("%04x",valueInt256)
  end


  self.Int2Char = function(value)
    return string.char(value)
  end

  ---print to console
  ---@param data any
  self.p = function(data)
    data = data or "error: nothing to print"
    print(tostring(data))
  end

  return self
end

--[[ tests ]]--

function DataUtilsTests()
  local du = DataUtils:new()
  local result
  result = du.DeNibblizeTable({1,1})
  du.p(result) --129

  result = du.Nibblize(128)
  resultTable = table.concat(result,",")
  du.p(result) -- table: 0x558499c41950
  du.p(resultTable) -- 0,1
  
  result = du.nibblize14bit(129)
  du.p(string.format("LSB:[%d] MSB:[%d]",result.lsb,result.msb))
  du.p(string.format("LSB:[%.2x] MSB:[%.2x]",result.lsb,result.msb))
  du.p(du.Int2Hex128(120))
  du.p(du.Int2Hex256(120))
  du.p(du.Int2Hex256(259))
end

-- DataUtilsTests()

return {
  DataUtils:new()
  --instantiate object with:
  --local dataUtils = DataUtils:new()
}


--[[

  function nibblize14bitToHexString (nibbleInt)
    local nibbleTable = {}
    p("Nibblize: value: " .. nibbleInt)
    -- negative values need [2's complement]
    if (nibbleInt < 0) then
      nibbleInt = nibbleInt + 16384
    end
    p("Nibblize: value after negative check/adjust: " .. nibbleInt)
    --- @type integer - value stored in first byte. modulus removes the msb from the value
    local lsb = nibbleInt % 128
    --- @type integer - value stored in second byte. divide revmoes the lsb from the value
    local msb = math.floor(nibbleInt / 128)
    nibbleTable[1] = msb
    nibbleTable[2] = lsb
    local hexstring = string.format("%s %s", formatValueToHex256(lsb), formatValueToHex256(msb) )
    local msg = string.format("Nibblized to Hexstring: Value:[%d] MSB:[%d] LSB:[%d] HexString:[%s]",nibbleInt, lsb, msb, hexstring)
    p(msg)
    return hexstring
  end
  ]]--

