--- Ctrlr BackEnd Logic for Sysex Handling
---@module SysexHandler

local SysexHandler = {}


---@class RequestsTable helper class for storing adhoc request samples
local RequestsTable = {}
---instatiates a RequestsTable object
---@param o any
---@return RequestsTable
function RequestsTable:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index                       = self
    -- identity request
    self.IdentityRequest               = "F07E000601F7"
    self.IdentityResponse              = "F07E0006021804040D00322E3030F7"
    self.HardwareConfigurationRequest  = "F0180F00550AF7"
    self.HardwareConfigurationResponse = "F0180F00550902000401060E0000043B09F7"
    
    --- 15-18 - handshake packet counter
    ---@type table
    self.PresetDumpResponse            = {}
    self.PresetDumpResponse[1]         = "F0180F0055100164005E0B0000380013001000140004001F0003000A002A0048000000F7"
    self.PresetDumpResponse[2]         = "F0180F0055100201006869743A44616E6365203231202020207F000000000000000000500000003C0000001E00000000003C0004000E0000002E00620064002F00630064000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F000000070021000A00000001000100070000000000000000000000000000007F007F7F0E00000001002800600000000A000000000001000000030000000A0000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E00650400005EF7"
    self.PresetDumpResponse[3]         = "F0180F00551002020000000000000000007F000000000000007F000000000000007F000000000000002600000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C003800000029001DF7"
    self.PresetDumpResponse[4]         = "F0180F005510020300330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000006F7"
    self.PresetDumpResponse[5]         = "F0180F00551002040014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F01000000000001000100000064000000640059F7"
    self.PresetDumpResponse[6]         = "F0180F005510020500140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F00000052F7"
    self.PresetDumpResponse[7]         = "F0180F005510020600000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068003DF7"
    self.PresetDumpResponse[8]         = "F0180F0055100207000C006000300000002C00380106002D00300026002D002F00060016000800640000000000000000000000000000000000000011F7"
    self.PresetDumpResponse[9]         = "F0180F00557BF7"
    
    --- 13-16 - handshake packet counter
    ---@type table
    self.PresetDumpAck                 = {}
    self.PresetDumpAck[1]              = "F0180F00557F0000F7"
    self.PresetDumpAck[2]              = "F0180F00557F0100F7"
    self.PresetDumpAck[3]              = "F0180F00557F0200F7"
    self.PresetDumpAck[4]              = "F0180F00557F0300F7"
    self.PresetDumpAck[5]              = "F0180F00557F0400F7"
    self.PresetDumpAck[6]              = "F0180F00557F0500F7"
    self.PresetDumpAck[7]              = "F0180F00557F0600F7"
    self.PresetDumpAck[8]              = "F0180F00557F0700F7"
    
    self.SetupDumpResponse             = "F0180F00551C1E00230010001500030020000900557365722053657475702020202020200001010000000000020000000100010000000100000002007F7F7F7F0000000000000E0000003E007F7F0100000005000100000000000000010001000200000000004A00470019001A0049004B005500480040004100420011001000010020014E004D001B001C00010003005200530001000000000000000000000000000100000001002800600000000A0014001E000100000003000000000000000000000000000100000000000A00000001000000010000000000000000000000000000007F000000030000000000000000007F7F1F0003017F0040007F7F0000010000000100000001007F0040007F7F0000010000000100000002007F0040007F7F0000010000000100000003007F0040007F7F0000010000000100000004007F0040007F7F0000010000000100000005007F0040007F7F0000010000000100000006007F0040007F7F0000010000000100000007007F0040007F7F0000010000000100000008007F0040007F7F0000010000000100000009007F0040007F7F000001000000010000000A007F0040007F7F000001000000010000000B007F0040007F7F000001000000010000000C007F0040007F7F000001000000010000000D007F0040007F7F000001000000010000000E007F0040007F7F000001000000010000000F007F0040007F7F0000010000000100000010007F0040007F7F0000010000000100000011007F0040007F7F0000010000000100000012007F0040007F7F0000010000000100000013007F0040007F7F0000010000000100000014007F0040007F7F0000010000000100000015007F0040007F7F0000010000000100000016007F0040007F7F0000010000000100000017007F0040007F7F0000010000000100000018007F0040007F7F0000010000000100000019007F0040007F7F000001000000010000001A007F0040007F7F000001000000010000001B007F0040007F7F000001000000010000001C007F0040007F7F000001000000010000001D007F0040007F7F000001000000010000001E007F0040007F7F000001000000010000001F007F0040007F7F00000100000001000000F7"
    self.SetupDumpResponseAck          = {}

    return self
end


---@class DataUtils utilites for data conversion and acces
local DataUtils = {}
---instatiates a DataUtils object
---@param o any
---@return DataUtils
function DataUtils:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    --- runc a function in protected mode: essentially try/catch
    ---@param func function - function to invoke using pcall(FUNCITON,ARGS)
    ---@return boolean, string - . true/false result + status message Success/Fail
    function self.tryCatchFunc(func, ...)
        local msg
        local isSuccess = false
        if ((#... == 0) == true) then -- NO arguments
            if pcall(func) then
                msg = "Success"
                isSuccess = true
            else
                msg = "Fail"
            end
        else -- WITH arguments
            if pcall(func, arg) then
                msg = "Success"
                isSuccess = true
            else
                msg = "Fail"
            end
        end
        return isSuccess, msg
    end

    --[[ output utils ]]

    --- output to console support for BOTH native Lua print() & Ctrlr console()
    --- attempts output to console using proected function call[pcall(fname,args..)] with print(), if error, then try console()
    --- using this func for ALL console out allows for switching based on env(Ctlr vs IDE)
    --- Ctrlr uses console() Lua lang uses print()
    --- Attempts print(), if error then try console()
    ---@param value any - string to output to call
    function self.p(value)
        if (pcall(print, tostring(value))) then
        else
            pcall(console, tostring(value))
        end
    end

    do -- string

        --- converts anything to a string
        --- @param value string
        --- @return string
        function self.toString(value)
            return tostring(value)
        end

        --- coverts table to delimited string
        --- @param valueTable table table to convert to string
        --- @param separator string separator character
        --- @return string
        function self.tableToStringWithDelimiter(valueTable, separator)
            return table.concat(valueTable, separator)
        end

        --- coverts table to delimited string using separator ","
        --- @param valueTable table
        --- @return string
        function self.tableToString(valueTable)
            return self.tableToStringWithDelimiter(valueTable, ",")
        end

        ---string spaces from a string
        ---@param string string to operate on
        ---@return string result cleaned string
        function self.removeSpaces(string)
            local result = string.gsub(string, " ", "")
            return result
        end

        ---read a string into a byte table with 2 chars per element
        ---@param str string input string, normally a hexString
        ---@return table byteTable a table of elements containing 2 chars each
        function self.stringToByteTable(str)
            -- string length must be even to be valid hexString
            if(#str%2 ~= 0) then return {} end -- return empty table

            -- scrape response string to byte table with 2 chars per cell
            local byteTable = {}
            local pointer = 1
            for i = 1, (#str / 2) do
                byteTable[i] = string.sub(str, pointer, pointer + 1)
                pointer = pointer + 2
            end
            return byteTable
        end

        --[[ string searching ]]
        --

        ---search a string for string value
        ---@param haystack any - value to search in
        ---@param needle any - value to search for
        ---@param startAt any - start index in the haystack
        ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
        ---@return boolean - . return true if needle is found in haystack
        function self.isContains(haystack, needle, startAt, boolPlain)
            startAt = startAt or 1
            boolPlain = boolPlain or true
            local found = string.find(haystack, needle, startAt, boolPlain)
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
        function self.isStartsWith(haystack, needle, boolPlain)
            boolPlain = boolPlain or true
            local starts = string.find(haystack, needle, 1, boolPlain)
            if (starts == nil) then
                return false
            else
                if starts == 1 then
                    return true
                else
                    return false
                end
            end
        end

                ---search a string for string value
        ---@param haystack any - value to search in
        ---@param needle any - value to search for
        ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
        ---@return boolean - . return true if needle is found in haystack
        function self.isStartsWithAtPosition(haystack, needle, startPos, boolPlain)
            boolPlain = boolPlain or true
            local starts = string.find(haystack, needle, startPos, boolPlain)
            if (starts == nil) then
                return false
            else
                if starts == startPos then
                    return true
                else
                    return false
                end
            end
        end

        ---check that haystack ends with needle
        ---@param haystack any - value to search in
        ---@param needle any - value to search for
        ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
        ---@return boolean - . return true if haystack ends with needle
        function self.isEndsWith(haystack, needle, boolPlain)
            local haystackSize = #haystack
            local needleSize = #needle
            local start = haystackSize - needleSize + 1 -- +1 = offset
            boolPlain = boolPlain or true

            local starts = string.find(haystack, needle, start, boolPlain)
            if (starts == nil) then
                return false
            else
                if (starts == start) then
                    return true
                else
                    return false
                end
            end
        end
    end

    do -- string operations returning/putting data

        --- return substring of haystack by startIndex and field length
        function self.fetchDataUsingPositionAndLength(haystack, pointer, length)
            local last = pointer + length - 1
            return self.fetchDataUsingPositionStartEnd(haystack, pointer, last)
        end

        --- return substring of haystack by startIndex and field length
        ---@param haystack string string to search
        ---@param first integer first index of substring
        ---@param last integer last index of substring
        ---@return string result found substring
        ---@return integer length length of substring
        function self.fetchDataUsingPositionStartEnd(haystack, first, last)
            local result = string.sub(haystack, first, last)
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
        function self.fetchDataUsingMask(haystack, mask, needle)
            local first, last = string.find(mask, needle, 1, true)
            if (first ~= nil or last ~= nil) then
                first = first or 1
                local result = string.sub(haystack, first, last)
                local msg = string.format(
                    "Search dump:[%s] using mask:[%s] on needle: [%s] Found start:[%d] end:[%d] result:[%s]", haystack,
                    mask,
                    needle, first, last, result)
                print(msg)
                if (result == nil) then
                    return ""
                else
                    return result
                end
            else
                return haystack
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
            local first, last = string.find(haystack, needle, 1, true)
            if (first ~= nil and last ~= nil) then
            else
                first = 0; last = 0
            end
            local msg = string.format("Search mask:[%s] on needle: [%s] Found start:[%d] end:[%d]", haystack, needle,
                first, last)
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
        function self.fetchDataPositionFirstLastFormats(haystack, needle)
            local first, last, concat, msg
            local results = {}
            first, last, msg = self.fetchDataPositionFirstLast(haystack, needle)
            -- string contact
            results[#results + 1] = first .. "," .. last
            results[#results + 1] = { first, last }
            results[#results + 1] = msg
            return results
        end

        --- Replaces a needle in a haystack with passed data
        --- @param haystack string - string to operated string replacement on
        --- @param needle string - needle to search for in haystack
        --- @param replaceWithData string - replacees the needle value in the haystack
        --- @return string - . returns the haystack with replacements made
        function self.setDataUsingMask(haystack, needle, replaceWithData)
            local result = string.gsub(haystack, needle, replaceWithData, 1)
            if (result == "nil") then
                return haystack
            else
                local msg = string.format("Update dump:[%s] replacing:[%s] with data: [%s] result:[%s]", haystack, needle,
                    replaceWithData, result)
                print(msg)
                return result -- return the data without changes
            end
        end

        --- replaces data in a haystack by search for needle and replacing it with provided data<br/>
        --   returns full haystack with or without replacement<br/>
        --- @param haystack string source to fetch data
        --- @param needle string search term for mask
        --- @param data string data to insert in place of mask
        --- @param isCheckLength? boolean if true, verify data and mask are same length
        --- @return string msg return the haystack with replaced values
        --- @return string status status message
        function self.replaceDataUsingMask(haystack, needle,data,isCheckLength)
            -- error checking
            isCheckLength = isCheckLength or false
            if(isCheckLength) then
                if(#needle ~= #data) then return "ERORR", string.format("ERROR: data[%s][%d] size does not match mask[%s][%d] size",data,#data,needle,#needle) end
            end
            -- replace need with data if found
            local result = string.gsub(haystack, needle, data)
            -- logging
            local msg = string.format(
                "put data using mask on haystack:[%s] using mask:[%s] on needle: [%s] put data:[%s]\n result:[%s]",
                haystack, needle, needle,data,result)
            print(msg)

            return result, msg
        end
    end

    do -- hex formatting
        ---convert single hex byte to integer ( does it handle multiple bytes?)
        ---@param hex string - hexString value
        ---@param base integer - base value for converting the hexString
        ---@return integer - integer value for provided hex value
        function self.hex2int(hex, base)
            base = base or 16
            return tonumber(hex, base)
        end

        ---convert single hex byte to integer ( does it handle multiple bytes?)
        ---@param hex string - hexString value
        ---@return integer - integer value for provided hex value
        function self.hex2IntBase16(hex)
            return self.hex2int(hex, 16)
        end

        --[[

            -- "%.#"
            -- negative operats from Left>Right.<br/>
            -- +int: returns substring with lenth from start>end index<br/>
            -- -int: returns substring with length from end>start
            -- %0#x: padds leading zeros to fill up # posistions
            -- %.#x:
        ]]--
        
        ---format an integer to hex. Supports :sub() length argument
        ---@param value integer value to convert
        ---@param length integer adjusts formatting length.
        ---@return string formattted hexString
        function self.formatValueToHex(value, length)
            if (value ~= "nil") then
                return
            elseif (value > -512) and (value < 511) then
                return string.format("%.2x", value):sub(-2)
            elseif (value > -65535) and (value < 65534) then
                return string.format("%.4x", value):sub(-4)
            else
                return string.format("%.4x", value):sub(-4)
            end
        end

        ---format value to Hex
        ---@param value any
        ---@param length any
        ---@return string
        ---@return string
        function self.formatValueToHex128(value, length)
            length = length or -2
            local hexString
            if (value < 0) then
                hexString = string.format("%.2x", value):sub(length)
            else
                hexString = string.format("%.2x", value)
            end
            --local hexString = string.format("%.2x",value):sub(length)
            local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ", value, hexString)
            return hexString, msg
        end

        ---format a value to 2byte hex
        ---@param value number
        ---@param length? integer
        ---@return string hexString hex value
        ---@return string msg status message
        function self.formatValueToHex256(value, length)
            length = length or -2
            local hexString
            if (value < 0) then
                hexString = string.format("%.2x", value):sub(length)
            else
                hexString = string.format("%.2x", value)
            end
            --local hexString = string.format("%.2x",value):sub(length)
            local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ", value, hexString)
            return hexString, msg
        end



        --[[ TODO: review all the hex conversions and consolidate. Some function names are incorrect ]]

        ---format a number to 4 byte hex
        ---@param value number to format
        ---@param length integer? optional length formatter( default=-8)
        ---@return string hexString formatted hex
        ---@return string msg status message
        function self.formatValueToHex1024(value, length)
            length = length or -8
            local hexString
            if (value < 0) then
                hexString = string.format("%.4x", value):sub(length)
            else
                hexString = string.format("%.4x", value)
            end
            --local hexString = string.format("%.2x",value):sub(length)
            local msg = string.format("Formatting to Hex: Value:[%s] HexString:[%s] ", value, hexString)
            return hexString, msg
        end

        -- function self.Int2Hex128(valueInt128)
        --     return string.format("%2.x", valueInt128)
        -- end

        ---format number to 2 byte hex value
        ---@param valueInt256 number value to convert
        ---@return string hexString value
        function self.int2Hex2Byte(valueInt256)
            return string.format("%04x", valueInt256)
        end

        ---Convert number to character
        ---@param value integer value of a character
        ---@return string character character of the number
        function self.int2Char(value)
            if(value == "nil") then return " " end
            value = value
            return string.char(value)
        end

        --[[ Nibblize ]]
        --
        ---Nibblize an integer: converts to 2 byte hex with LSB first( '1' = '01 00' )
        ---@param nibbleInt integer integer to convert
        ---@return table nibbleTable a table with 'msb' and 'lsb' fields
        ---@return string msg status message
        function self.nibblize14bitToTable(nibbleInt)
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

        function self.nibblize14bitToHexString(nibbleInt)
            local nibbleTable = self.nibblize14bitToTable(nibbleInt)
            local hexstring = string.format("%s %s", self.formatValueToHex256(nibbleTable.lsb),
                self.formatValueToHex256(nibbleTable.msb))
            local msg = string.format("Nibblized to Hexstring: Value:[%d] MSB:[%d] LSB:[%d] HexString:[%s]",
                nibbleInt, nibbleTable.lsb, nibbleTable.msb, hexstring)
            return hexstring, msg
        end

        --- nibblize a value into msb and lsb
        --- @param value integer to process
        --- @return table return table with msb,lsb
        function self.nibblize(value)
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
        function self.deNibblizeLSBMSB(lsb, msb)
            local value
            local rawValue = (msb * 128) + lsb

            -- if number is greate than 8192, its a negative value
            if (rawValue >= 8192) then
                value = 8192 - 16257
            else
                value = rawValue
            end

            return value
        end

        --- convert a nibble(msb/lsb) to integer value
        --- @param nibble table
        --- @return integer value
        function self.deNibblizeTable(nibble)
            if (#nibble == 2) then
                return self.deNibblizeLSBMSB(nibble[1], nibble[2])
            else
                return 0
            end
        end
    end


    do -- bin/dec

        ---convert decimal to binary: ( '3' =  '00000011'  )
        ---@param decNum integer
        ---@return string binString
        function self.dec2bin(decNum)
            local t = {}
            local i
            for i = 7, 0, -1 do
                t[#t + 1] = math.floor(decNum / 2 ^ i)
                decNum = decNum % 2 ^ i
            end
            return table.concat(t)
        end

        ---convert a binary represented as string to decimal using specified base
        --- base would normally be '2' for binary string
        ---@param binaryString string binary number represented as a string
        ---@param base integer base used for conversion
        ---@return integer .return converted decimal number
        function self.bin2decString(binaryString, base)
            return tonumber(binaryString, base)
        end

        ---convert a binary represented as string to decimal using base 2
        ---@param binNum string binary number represented as a string
        ---@return integer _ converted decimal number
        function self.bin2decInt(binNum)
            return bin2dec(binNum, 2)
        end
    end

    do -- bool/string

        --- convert boolean to string
        ---@param valueBoolean boolean boolean to parse
        ---@return string _ returns 0 if false, 1 if true
        function self.boolToStr(valueBoolean)
            if valueBoolean == true then
                return "1"
            else
                return "0"
            end
        end

        ---convert string to boolean
        ---@param valueString string string to parse
        ---@return boolean _ returns true if 1/"true", false if 0/"false"
        function self.strToBool(valueString)
            if valueString == "1" or valueString == "true" then
                return true
            else
                return false
            end
        end
    end

    do -- sysex utilities
        ---Detect if message is Sysex NonRealTime: [F0**F7]
        ---Starts with F0 | Ends with F7
        ---@param msg string message to parse
        ---@return boolean _ return true if starts with F0, ends with F7
        function self.isSysexNonRealtime(msg)
            local du = DataUtils:new()
            local resultStart = du.isStartsWith(msg, "F0", true)
            local resultEnd = du.isEndsWith(msg, "F7", true)
            if ((resultStart == true) and (resultEnd == true)) then
                return true
            else
                return false
            end
        end

        ---Detect if message is Sysex Universal: [F0180F0055**F7]
        ---Starts with F0180F0055 | Ends with F7
        ---@param msg string message to parse
        ---@return boolean _ return true if starts with F0, ends with F7
        function self.isSysexUniversal(msg)
            local du = DataUtils:new()
            local resultStart = du.isStartsWith(msg, "F0", true)
            local resultEnd = du.isEndsWith(msg, "F7", true)
            if ((resultStart == true) and (resultEnd == true)) then
                return true
            else
                return false
            end
        end

        ---check that message is SysexNonRealtime, trim control bytes if true
        --- if error thrown, return the original message
        ---@param msg string - message to parse and clean
        ---@return string returnMsg return cleaned message
        ---@return string status return status message
        function self.cleanSysexNonRealtimeMessage(msg)
            local status, returnMsg
            local msgOriginal = msg -- save original msg in the event error occurs
            -- if msg = nil, do nothing & return it
            if (msg == nil) then return msgOriginal, "NOTHING TODO: msg=nil, nothing to do" end

            -- check if SysexNonRealtime
            local isSysexNRT = self.isSysexNonRealtime(msg)
            print(tostring(isSysexNRT))
            -- stip SysexNonRealtime control bytes
            if (isSysexNRT == true) then -- PROCESS MESSAGE
                msg = string.sub(msg, 3, #msg)
                msg = string.sub(msg, 1, #msg - 2)
                -- check for something gone wrong
                if (msg == nil) then -- FAIL: if result = nil, assign return message to the orginal
                    status = string.format("Cleaned Message FAILED: original:[%s]", msgOriginal)
                    returnMsg = msgOriginal
                else -- SUCCESS: assign return msg the cleaned message
                    status = string.format("Cleaned Message: original:[%s] cleaned:[%s]", msgOriginal, msg)
                    returnMsg = msg
                end
            else -- NOTHING TO DO: if not msg not SysexNonRealtime, assign return msg to the original
                status = string.format("msg is not SysexNonRealtime, nothing to do: [%s]", msgOriginal)
                returnMsg = msgOriginal
            end

            return returnMsg, status
        end

        --[[

            ---check that message is SysexUniversal, trim control bytes if true
            --- if error thrown, return the original message
            ---pattern = string, use string length for substring start
            ---pattern = integer, use value
            ---@param msg string message to parse and clean
            ---@param pattern string|integer message to parse and clean
            ---@return string returnMsg return cleaned message
            ---@return string status return status message
            ]]


        ---Clean sysex control bytes from a message
        ---@param msg string message to clean
        ---@param patternOrInteger string|integer pattern to find and remove | number of chars to remove from start
        ---@return string returnMsg updated string
        ---@return string status status message
        function self.cleanSysexUniversalMessage(msg, patternOrInteger)
            local status, cleanedMsg
            local originalMsg = msg -- save original msg in the event error occurs
            -- if msg = nil, do nothing & return it
            if (msg == nil) then return originalMsg, "NOTHING TODO: msg=nil, nothing to do" end

            -- check if SysexUniversal
            local isSysexUni = self.isSysexUniversal(msg)
            -- print(tostring(isSysexUni))

            -- stip SysexUniversal control bytes
            if (isSysexUni == true) then -- PROCESS MESSAGE
                local datatype = type(patternOrInteger)
                if (datatype == "string") then
                    -- if pattern is text
                    msg = string.sub(msg, #patternOrInteger + 1 --[[+1 position offset--]], #msg)
                elseif (datatype == "number") then
                    -- if pattern is number
                    msg = string.sub(msg, patternOrInteger + 1 --[[+1 position offset--]], #msg)
                end

                msg = string.sub(msg, 1, #msg - 2)
                -- check for something gone wrong
                if (msg == nil) then -- FAIL: if result = nil, assign return message to the orginal
                    status = string.format("Cleaned Message FAILED: original:[%s]", originalMsg)
                    cleanedMsg = originalMsg
                else -- SUCCESS: assign return msg the cleaned message
                    status = string.format("Cleaned Message: original:[%s] cleaned:[%s]", originalMsg, msg)
                    cleanedMsg = msg
                end
            else -- NOTHING TO DO: if not msg not SysexUniversal, assign return msg to the original
                status = string.format("msg is not SysexUniversal, nothing to do: [%s]", originalMsg)
                cleanedMsg = originalMsg
            end

            return cleanedMsg, status
        end
    end

    return self
end

---@
---@class MessageSpecs
local MessageSpecs = {
    SysexWrapper = "F0180F0055XXF7",
    SysexUniversal_Prefix = "F0180F",
    SysexUniversal_SOX = "F0",
    SysexUniversal_EOX = "F7",
    Handshake = {
        ACK = "7F",
        ACKClosedLoop = "7Fpppp",
        NAK = "7Epppp",
        CANCEL = "7D",
        EOF = "7B",
    },
    Headers = {
        BasicHeader = "F0180FXX55",
        PresetDumpHeaderResponse = "1001",
        PresetDumpResponse = "1002pppp",
        SetupDumpResponse = "1C",
    },
    ---@enum
    Status = {
        START = "START",
        RUNNING = "RUNNING",
        STOP = "STOP",
        DONE = "DONE",
        IDLE = "IDLE",
        ERROR = "ERROR",
        WARN = "WARN",
        WAIT = "WAIT",
        FAIL = "FAIL",
        SUCESS = "SUCCESS",
        OK = "OK",
        TIMEOUT = "TIMEOUT"
    },
    Midi = { -- message masks for string replacement operations
        --- Polyphonic Mesage [0xnc, 0xkk, 0xpp]
        -- - c: channel | kk: key# | pp: pressure
        -- - n is the status (0xA)
        -- - c is the channel nybble
        -- - kk is the key number (0 to 127)
        -- - pp is the pressure value (0 to 127)
        PolyPhonic = "A# kk pp",
        --- Channel Aftertouch [0xnc, 0xpp]
        -- - n is the status (0xD)
        -- - c is the channel number
        -- - pp is the pressure value (0 to 127)
        ChannelAftertouch = "C# pp",
        --- PitchBend [0xnc, 0xLL, 0xMM]
        -- - n is the status (0xE)
        -- - c is the channel number
        -- - LL is the 7 least-significant bits of the value
        -- - MM is the 7 most-significant bits of the value
        PitchBend = "E# pp",
        --- ControlChange [0xnc, 0xcc, 0xvv]
        -- - n is the status (0xB)
        -- - c is the MIDI channel
        -- - cc is the controller number (0-127)
        -- - vv is the controller value (0-127)
        ControlChange = "B# cc vv",
        --- ProgramChange [0xnc, 0xpp]
        -- - n is the status (0xc)
        -- - c is the channel
        -- - pp is the patch number (0-127)
        ProgramChange = "C# pp",
        SystemMessages = {
            --- TimeCodeQuarterFrame: Indicates timing using absolute time code, primarily for synthronization with video playback systems. A single location requires eight messages to send the location in an encoded hours:minutes:seconds:frames format*.
            -- - 0xF1 | 1-byte
            TimeCodeQuarterFrame = "",
            ---SongPosition: Instructs a sequencer to jump to a new position in the song. The data bytes form a 14-bit value that expresses the location as the number of sixteenth notes from the start of the song.
            -- - 0xF2 | 2-bytes
            SongPosition = "",
            ---SongSelect: Instructs a sequencer to select a new song. The data byte indicates the song.
            -- - 0xF3 | 1-byte
            SongSelect = "",
            --- 0xF4 | 0-bytes
            UndefinedF4 = "",
            --- 0xF5 | 0-bytes
            UndefinedF5 = "",
            --- TuneRequest: Requests that the reciever retune itself**.
            --- 0xF6 | 0-bytes
            TuneRequest = ""

        }

    }


}
---tables holding sysex messaging specifications
---@param o any
---@return MessageSpecs
function MessageSpecs:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    do -- handshaking
        ---@type table
        self.ACK = {}
        self.ACK[0] = { "7F", "Mask" }
        self.ACK[1] = { "7F", "Command" }

        ---@type table
        self.ACKClosedLoopwithPacketCounter = {}
        self.ACKClosedLoopwithPacketCounter[0] = { "7Faaaa", "Mask" }
        self.ACKClosedLoopwithPacketCounter[1] = { "7F", "Command" }
        self.ACKClosedLoopwithPacketCounter[2] = { "aaaa", "" }
        ---@type table<table<string,string>>
        self.NAK = {}
        self.NAK[0] = { "7Eaaaa", "Mask" }
        self.NAK[1] = { "7E", "Command" }
        self.NAK[2] = { "aaaa", "" }
        ---@type table<table<string,string>>
        self.CANCEL = {}
        self.CANCEL[0] = { "7D", "Mask" }
        self.CANCEL[1] = { "7D", "Command" }
        ---@type table<table<string,string>>
        self.WAIT = {}
        self.WAIT[0] = { "7C", "Mask" }
        self.WAIT[1] = { "7C", "Command" }
        ---@type table<table<string,string>>
        self.EOF = {}
        self.EOF[0] = { "7B", "Mask" }
        self.EOF[1] = { "7B", "Command" }
    end

    do -- sysex non-realtime
        ---@type table<table<string,string>>
        self.MasterVolume = {}
        self.MasterVolume[0] = { "7Eid0401aaaa", "Mask" }
        self.MasterVolume[1] = { "04", "Command" }
        self.MasterVolume[2] = { "01", "SubCommand" }
        self.MasterVolume[3] = { "aaaa", "volumelevel" }
        ---@type table<table<string,string>>
        self.DeviceInquiry = {}
        self.DeviceInquiry[0] = { "7Eid0601", "Mask" }
        self.DeviceInquiry[1] = { "06", "Command" }
        self.DeviceInquiry[2] = { "01", "SubCommand" }
        ---@type table<table<string,string>>
        self.DeviceInquiryResponse = {}
        self.DeviceInquiryResponse[0] = { "7Eid060218aaaabbbbcccccccc", "Mask" }
        self.DeviceInquiryResponse[1] = { "06", "Command" }
        self.DeviceInquiryResponse[2] = { "02", "SubCommand" }
        self.DeviceInquiryResponse[3] = { "18", "Manufacturers System Exclusive Id code" }
        self.DeviceInquiryResponse[4] = { "aaaa", "Device Family code" }
        self.DeviceInquiryResponse[5] = { "bbbb", "Device Family Member Code" }
        self.DeviceInquiryResponse[6] = { "cccccccc", "Software Revision Level (4 ASCII char)" }
        self.DeviceInquiryResponseData = {}
    end

    do -- Program Change

        ---@type table<table<string,string>>
        self.ProgramChangePresetMapDumpResponse = {}
        self.ProgramChangePresetMapDumpResponse[0] = { "16aa[256]bb[256]", "Mask" }
        self.ProgramChangePresetMapDumpResponse[1] = { "16", "Command" }
        self.ProgramChangePresetMapDumpResponse[2] = { "aa", "" }
        self.ProgramChangePresetMapDumpResponse[3] = { "[256]", "<256 Data Bytes Preset Numbers>" }
        self.ProgramChangePresetMapDumpResponse[4] = { "bb", "" }
        self.ProgramChangePresetMapDumpResponse[5] = { "[256]", "<256 Data Bytes Preset ROM ID Numbers>" }
        self.ProgramChangePresetMapDumpRequest = {}
        self.ProgramChangePresetMapDumpRequest[0] = { "17", "Mask" }
        self.ProgramChangePresetMapDumpRequest[1] = { "17", "Command" }
    end

    do -- parameter request/response
        ---@type table<table<string,string>>
        self.ParameterEditRequest = {}
        self.ParameterEditRequest[0] = { "0102aaaabbbb", "Mask" }
        self.ParameterEditRequest[1] = { "01", "Command" }
        self.ParameterEditRequest[2] = { "02", "SubCommand" }
        self.ParameterEditRequest[3] = { "aaaa", "Parameter ID (LSB first)" }
        self.ParameterEditRequest[4] = { "bbbb", "Parameter Data" }
        --[[
            -- self.ParameterEditRequestCommands = {}
            -- self.ParameterEditRequestCommands[0] = {"0102aaaabbbb","Mask"}
            -- self.ParameterEditRequestCommands[1] = {"01","Command"}
            -- self.ParameterEditRequestCommands[2] = {"02","SubCommand"}
            -- self.ParameterEditRequestCommands[3] = {"aaaa","ParamId"}
            -- self.ParameterEditRequestCommands[4] = {"bbbb","ParamValue"}
        ]]
        --

        ---@type table<table<string,string>>
        self.ParameterValueRequest = {}
        self.ParameterValueRequest[0] = { "0201aaaa", "Mask" }
        self.ParameterValueRequest[1] = { "02", "Command" }
        self.ParameterValueRequest[2] = { "01", "SubCommand" }
        self.ParameterValueRequest[3] = { "aaaa", "Parameter ID (LSB first)" }

        ---@type table<table<string,string>>
        self.ParamMinMaxDefaultValueRequest = {}
        self.ParamMinMaxDefaultValueRequest[0] = { "04aaaa", "Mask" }
        self.ParamMinMaxDefaultValueRequest[1] = { "04", "Command" }
        self.ParamMinMaxDefaultValueRequest[2] = { "aaaa", "Parameter ID" }

        ---@type table<table<string,string>>
        self.ParamMinMaxDefaultValueResponse = {}
        self.ParamMinMaxDefaultValueResponse[0] = { "03aaaabbbbccccddddee", "Mask" }
        self.ParamMinMaxDefaultValueResponse[1] = { "03", "Command" }
        self.ParamMinMaxDefaultValueResponse[2] = { "aaaa", "Parameter ID" }
        self.ParamMinMaxDefaultValueResponse[3] = { "bbbb", "Parameter minimum value" }
        self.ParamMinMaxDefaultValueResponse[4] = { "cccc", "Parameter maximum value" }
        self.ParamMinMaxDefaultValueResponse[5] = { "dddd", "Parameter default value" }
        self.ParamMinMaxDefaultValueResponse[6] = { "ee",
            "Read Only (0 = Read/Write, 1 = Read Only, values above 1 reserved)" }
    end

    do -- Hardware Configuration
        ---@type table<table<string,string>>
        self.HardwareConfigurationRequest = {}
        self.HardwareConfigurationRequest[0] = { "0A", "Mask" }
        self.HardwareConfigurationRequest[1] = { "0A", "Command" }

        ---@type table <table<string,string>>
        self.HardwareConfigurationResponse = {}
        self.HardwareConfigurationResponse[0] = { "09aabbbbccddeeeeffffgggg", "Mask" }
        self.HardwareConfigurationResponse[1] = { "09", "Command" }
        -- 02 0004 01 06 0E00 0004 3B09
        self.HardwareConfigurationResponse[2] = { "aa", "Number of General Information Bytes" }
        self.HardwareConfigurationResponse[3] = { "bbbb", "Number of User Presets" }
        -- simm data iterator
        self.HardwareConfigurationResponse[4] = { "cc", "Number of Simms Installed" }
        self.HardwareConfigurationResponse[5] = { "dd", "Number of Information Bytes per Sim" }
        -- simm preset model
        self.HardwareConfigurationResponse[6] = { "eeee", "Simm ID" }
        self.HardwareConfigurationResponse[7] = { "ffff", "Number of Sim Presets" }
        self.HardwareConfigurationResponse[8] = { "gggg", "Number of Sim Instruments" }
    end

    do -- Setup Dump

        ---@type table<table<string,string>>
        self.SetupDumpResponse = {}
        self.SetupDumpResponse[0] = { "1Caaaabbbbccccddddeeeeffffgggg[736]F7[1622443240657", "Mask" }
        self.SetupDumpResponse[1] = { "1C", "Command" }
        self.SetupDumpResponse[2] = { "aaaa", "Number of Master General Parameters (11)" }
        self.SetupDumpResponse[3] = { "bbbb", "Number of Master MIDI Parameters (22)" }
        self.SetupDumpResponse[4] = { "cccc", "Number of Master Effects Parameters (16)" }
        self.SetupDumpResponse[5] = { "dddd", "Number of Reserved Parameters (0)" }
        self.SetupDumpResponse[6] = { "eeee", "Number of Non Channel Parameters (LSB first)" }
        self.SetupDumpResponse[7] = { "ffff", "Number of MIDI Channels (LSB first)" }
        self.SetupDumpResponse[8] = { "gggg", "Number of Parameters per Channel (LSB first)" }
        self.SetupDumpResponse[9] = { "[736]", "" }
        self.SetupDumpResponse[10] = { "[16]", "16 ASCII character Setup Name" }
        self.SetupDumpResponse[11] = { "[22]", "Master General" }
        self.SetupDumpResponse[12] = { "[44]", "Master MIDI" }
        self.SetupDumpResponse[13] = { "[32]", "Master Effects" }
        self.SetupDumpResponse[14] = { "[40]", "Reserved" }
        self.SetupDumpResponse[15] = { "[6]", "Non Channel Parameter Values" }
        self.SetupDumpResponse[16] = { "[576]", "Channel Parameters" }
        ---@type table<table<string,string>>
        self.SetupDumpRequest = {}
        self.SetupDumpRequest[0] = { "1D", "Mask" }
        self.SetupDumpRequest[1] = { "1D", "Command" }
        -- Generic Dump
        ---@type table<table<string,string>>
        self.GenericDumpRequest = {}
        self.GenericDumpRequest[0] = { "61000100aaaabbbb", "Mask" }
        self.GenericDumpRequest[1] = { "6100", "command::genericdump" }
        self.GenericDumpRequest[2] = { "0100", "objecttype01=masterdata" }
        self.GenericDumpRequest[3] = { "aaaa", "objectnumber(zeroformastersetupdata)" }
        self.GenericDumpRequest[4] = { "bbbb", "romnumber(zeroformastersetupdata)" }
        ---@type table<table<string,string>>
        self.GenericDump = {}
        self.GenericDump[0] = { "61aabbccddddeeeeffff[gggghhhhiiiijjjjkkkk]", "Mask" }
        self.GenericDump[1] = { "61", "Command" }
        self.GenericDump[2] = { "aa", "subcommand::dumpversion" }
        self.GenericDump[3] = { "bb", "objecttype01=masterdata,otherstofollow" }
        self.GenericDump[4] = { "cc", "subtype00=mastersetup,otherstofollow" }
        self.GenericDump[5] = { "dddd", "objectnumberifapplicableelsezero" }
        self.GenericDump[6] = { "eeee", "romnumberifapplicableelsezero" }
        self.GenericDump[7] = { "ffff", "numberofparamgroups" }
        self.GenericDump[8] = { "[", "" }
        self.GenericDump[9] = { "gggg", "startingparameteridforthegroup" }
        self.GenericDump[10] = { "hhhh",
            "numberofparamtersinthegroup.Eachparameteridisinsequencefromthestartingidofthegroup" }
        self.GenericDump[11] = { "iiii", "startingindexofparameterelements" }
        self.GenericDump[12] = { "jjjj", "countofparameterelements" }
        self.GenericDump[13] = { "kkkk", "twobytedataforeachparameterinthegroupelementrepeatedgn,gntimes" }
        self.GenericDump[14] = { "]", "" }
    end

    do -- Generic Dump
        ---@type table<table<string,string>>
        self.GenericName = {}
        self.GenericName[0] = { "0BaabbbbccccAAAAAAAAAAAAAAAA", "Mask" }
        self.GenericName[1] = { "0B", "Command" }
        self.GenericName[2] = { "aa", "Object Type" }
        self.GenericName[3] = { "bbbb", "Object Number" }
        self.GenericName[4] = { "cccc", "Object ROM ID" }
        self.GenericName[5] = { "aaaaaaaaaaaaaaaa", "Name ( x16 ASCII Chars )" }
        ---@type table<table<string,string>>
        self.GenericNameRequest = {}
        self.GenericNameRequest[0] = { "0Caabbbbcccc", "Mask" }
        self.GenericNameRequest[1] = { "0C", "Command" }
        self.GenericNameRequest[2] = { "aa", "Object Type" }
        self.GenericNameRequest[3] = { "bbbb", "Object Number" }
        self.GenericNameRequest[4] = { "cccc", "Object Rom ID" }
    end

    do -- Preset Dump ClosedLoop
        ---@type table<table<string,string>>
        self.PresetDumpHeaderClosedLoopResponse = {}
        self.PresetDumpHeaderClosedLoopResponse[0] = { "1001aaaabbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm",
            "Mask" }
        self.PresetDumpHeaderClosedLoopResponse[1] = { "10", "Command" }
        self.PresetDumpHeaderClosedLoopResponse[2] = { "01", "SubCommand" }
        self.PresetDumpHeaderClosedLoopResponse[3] = { "aaaa", "Preset Number" }
        self.PresetDumpHeaderClosedLoopResponse[4] = { "bbbbbbbb", "Number of DataBytes in Bump" }
        self.PresetDumpHeaderClosedLoopResponse[5] = { "cccc", "Number of Preset Common General Parameters, LSB first" }
        self.PresetDumpHeaderClosedLoopResponse[6] = { "dddd", "Number of Reserved Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[7] = { "eeee", "Number of Preset Common Effects Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[8] = { "ffff", "Number of Preset Common Link Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[9] = { "gggg", "Number of Preset Layers, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[10] = { "hhhh", "Number of Preset Layer General Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[11] = { "iiii", "Number of Preset Layer Filter Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[12] = { "jjjj", "Number of Preset Layer LFO Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[13] = { "kkkk", "Number of Preset Layer Envelope Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[14] = { "llll", "Number of Preset Layer PatchCord Parameters, LSB first." }
        self.PresetDumpHeaderClosedLoopResponse[15] = { "mmmm", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetDumpDataClosedLoopResponse = {}
        self.PresetDumpDataClosedLoopResponse[0] = { "1002aaaa[244]ck", "Mask" }
        self.PresetDumpDataClosedLoopResponse[1] = { "10", "Command" }
        self.PresetDumpDataClosedLoopResponse[2] = { "02", "SubCommand" }
        self.PresetDumpDataClosedLoopResponse[3] = { "aaaa", "Running Packet count, LSB first, begins at 1" }
        self.PresetDumpDataClosedLoopResponse[4] = { "[244]", "<up to 244 Data Bytes>" }
        self.PresetDumpDataClosedLoopResponse[5] = { "bb", "1 Byte = 1’s complement of the sum of {<244 Data Bytes>" }
    end

    do -- Preset Dump Open Loop
        ---@type table<table<string,string>>
        self.PresetDumpHeaderOpenLoopResponse = {}
        self.PresetDumpHeaderOpenLoopResponse[0] = { "1003aaaabbbbbbbbccccddddeeeeffffgggghhhhiiiijjjjkkkkllllmmmm",
            "Mask" }
        self.PresetDumpHeaderOpenLoopResponse[1] = { "10", "Command" }
        self.PresetDumpHeaderOpenLoopResponse[2] = { "03", "SubCommand" }
        self.PresetDumpHeaderOpenLoopResponse[3] = { "aaaa", "Preset Number" }
        self.PresetDumpHeaderOpenLoopResponse[4] = { "bbbbbbbb", "Number of DataBytes in Bump" }
        self.PresetDumpHeaderOpenLoopResponse[5] = { "cccc", "Number of Preset Common General Parameters, LSB first" }
        self.PresetDumpHeaderOpenLoopResponse[6] = { "dddd", "Number of Reserved Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[7] = { "eeee", "Number of Preset Common Effects Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[8] = { "ffff", "Number of Preset Common Link Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[9] = { "gggg", "Number of Preset Layers, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[10] = { "hhhh", "Number of Preset Layer General Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[11] = { "iiii", "Number of Preset Layer Filter Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[12] = { "jjjj", "Number of Preset Layer LFO Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[13] = { "kkkk", "Number of Preset Layer Envelope Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[14] = { "llll", "Number of Preset Layer PatchCord Parameters, LSB first." }
        self.PresetDumpHeaderOpenLoopResponse[15] = { "mmmm", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetDumpDataOpenLoopResponse = {}
        self.PresetDumpDataOpenLoopResponse[0] = { "1004aabb[244]ck", "Mask" }
        self.PresetDumpDataOpenLoopResponse[1] = { "10", "Command" }
        self.PresetDumpDataOpenLoopResponse[2] = { "04", "SubCommand" }
        self.PresetDumpDataOpenLoopResponse[3] = { "[244]", "" }
        self.PresetDumpDataOpenLoopResponse[4] = { "ck", "Checksum" }
    end

    do -- Preset Common
        ---@type table<integer, table<string,string>>
        self.PresetCommonParamsDumpDataResponse = {}
        self.PresetCommonParamsDumpDataResponse[0] = { "1010[240]", "Mask" }
        self.PresetCommonParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetCommonParamsDumpDataResponse[2] = { "10", "SubCommand" }
        self.PresetCommonParamsDumpDataResponse[3] = { "[240]", "" }
        ---@type table<table<string,string>>
        self.PresetCommonGeneralParamsDumpDataResponse = {}
        self.PresetCommonGeneralParamsDumpDataResponse[0] = { "1011[126]", "Mask" }
        self.PresetCommonGeneralParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetCommonGeneralParamsDumpDataResponse[2] = { "11", "SubCommand" }
        self.PresetCommonGeneralParamsDumpDataResponse[3] = { "[126]", "" }
        ---@type table<table<string,string>>
        self.PresetCommonArpParamsDumpDataResponse = {}
        self.PresetCommonArpParamsDumpDataResponse[0] = { "1012[38]", "Mask" }
        self.PresetCommonArpParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetCommonArpParamsDumpDataResponse[2] = { "12", "SubCommand" }
        self.PresetCommonArpParamsDumpDataResponse[3] = { "[38]", "" }
        ---@type table<table<string,string>>
        self.PresetCommonEffectsParamsDumpDataResponse = {}
        self.PresetCommonEffectsParamsDumpDataResponse[0] = { "1013[38]", "Mask" }
        self.PresetCommonEffectsParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetCommonEffectsParamsDumpDataResponse[2] = { "13", "SubCommand" }
        self.PresetCommonEffectsParamsDumpDataResponse[3] = { "[38]", "" }
        ---@type table<table<string,string>>
        self.PresetCommonLinkParamsDumpDataResponse = {}
        self.PresetCommonLinkParamsDumpDataResponse[0] = { "1014[46]", "Mask" }
        self.PresetCommonLinkParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetCommonLinkParamsDumpDataResponse[2] = { "14", "SubCommand" }
        self.PresetCommonLinkParamsDumpDataResponse[3] = { "[46]", "" }
    end
    
    do -- Preset Layer
        ---@type table<table<string,string>>
        self.PresetLayerParamsDumpDataResponse = {}
        self.PresetLayerParamsDumpDataResponse[0] = { "1020[332]", "Mask" }
        self.PresetLayerParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerParamsDumpDataResponse[2] = { "20", "SubCommand" }
        self.PresetLayerParamsDumpDataResponse[3] = { "[332]", "" }
        ---@type table<table<string,string>>
        self.PresetLayerGeneralParamsDumpDataResponse = {}
        self.PresetLayerGeneralParamsDumpDataResponse[0] = { "1021[70]", "Mask" }
        self.PresetLayerGeneralParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerGeneralParamsDumpDataResponse[2] = { "21", "SubCommand" }
        self.PresetLayerGeneralParamsDumpDataResponse[3] = { "[70]", "" }
        ---@type table<table<string,string>>
        self.PresetLayerFilterParamsDumpDataResponse = {}
        self.PresetLayerFilterParamsDumpDataResponse[0] = { "1022[14]", "Mask" }
        self.PresetLayerFilterParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerFilterParamsDumpDataResponse[2] = { "22", "SubCommand" }
        self.PresetLayerFilterParamsDumpDataResponse[3] = { "[14]", "" }
        ---@type table<table<string,string>>
        self.PresetLayerLFOParamsDumpDataResponse = {}
        self.PresetLayerLFOParamsDumpDataResponse[0] = { "1023[28]", "Mask" }
        self.PresetLayerLFOParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerLFOParamsDumpDataResponse[2] = { "23", "SubCommand" }
        self.PresetLayerLFOParamsDumpDataResponse[3] = { "[28]", "" }
        ---@type table<table<string,string>>
        self.PresetLayerEnvelopeParamsDumpDataResponse = {}
        self.PresetLayerEnvelopeParamsDumpDataResponse[0] = { "1024[92]", "Mask" }
        self.PresetLayerEnvelopeParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerEnvelopeParamsDumpDataResponse[2] = { "24", "SubCommand" }
        self.PresetLayerEnvelopeParamsDumpDataResponse[3] = { "[92]", "" }
        ---@type table<table<string,string>>
        self.PresetLayerPatchcordParamsDumpDataResponse = {}
        self.PresetLayerPatchcordParamsDumpDataResponse[0] = { "1025[152]", "Mask" }
        self.PresetLayerPatchcordParamsDumpDataResponse[1] = { "10", "Command" }
        self.PresetLayerPatchcordParamsDumpDataResponse[2] = { "25", "SubCommand" }
        self.PresetLayerPatchcordParamsDumpDataResponse[3] = { "[152]", "" }
    end

    do -- Preset Dump Request
        ---@type table<table<string,string>>
        self.PresetDumpRequestClosedLoop = {}
        self.PresetDumpRequestClosedLoop[0] = { "1102aaaabbbb", "Mask" }
        self.PresetDumpRequestClosedLoop[1] = { "11", "Command" }
        self.PresetDumpRequestClosedLoop[2] = { "02", "SubCommand" }
        self.PresetDumpRequestClosedLoop[3] = { "aaaa", "Preset Number" }
        self.PresetDumpRequestClosedLoop[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetDumpRequestOpenLoop = {}
        self.PresetDumpRequestOpenLoop[0] = { "1104aaaabbbb", "Mask" }
        self.PresetDumpRequestOpenLoop[1] = { "11", "Command" }
        self.PresetDumpRequestOpenLoop[2] = { "04", "SubCommand" }
        self.PresetDumpRequestOpenLoop[3] = { "aaaa", "Preset Number" }
        self.PresetDumpRequestOpenLoop[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetCommonParamsDumpRequest = {}
        self.PresetCommonParamsDumpRequest[0] = { "1110aaaabbbb", "Mask" }
        self.PresetCommonParamsDumpRequest[1] = { "11", "Command" }
        self.PresetCommonParamsDumpRequest[2] = { "10", "SubCommand" }
        self.PresetCommonParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetCommonParamsDumpRequest[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetCommonGeneralParamsDumpRequest = {}
        self.PresetCommonGeneralParamsDumpRequest[0] = { "1111aaaabbbb", "Mask" }
        self.PresetCommonGeneralParamsDumpRequest[1] = { "11", "Command" }
        self.PresetCommonGeneralParamsDumpRequest[2] = { "11", "SubCommand" }
        self.PresetCommonGeneralParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetCommonGeneralParamsDumpRequest[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetCommonArpParamsDumpRequest = {}
        self.PresetCommonArpParamsDumpRequest[0] = { "1112aaaabbbb", "Mask" }
        self.PresetCommonArpParamsDumpRequest[1] = { "11", "Command" }
        self.PresetCommonArpParamsDumpRequest[2] = { "12", "SubCommand" }
        self.PresetCommonArpParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetCommonArpParamsDumpRequest[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetCommonFXParamsDumpRequest = {}
        self.PresetCommonFXParamsDumpRequest[0] = { "1113aaaabbbb", "Mask" }
        self.PresetCommonFXParamsDumpRequest[1] = { "11", "Command" }
        self.PresetCommonFXParamsDumpRequest[2] = { "13", "SubCommand" }
        self.PresetCommonFXParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetCommonFXParamsDumpRequest[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetCommonLinkParamsDumpRequest = {}
        self.PresetCommonLinkParamsDumpRequest[0] = { "1114aaaabbbb", "Mask" }
        self.PresetCommonLinkParamsDumpRequest[1] = { "11", "Command" }
        self.PresetCommonLinkParamsDumpRequest[2] = { "14", "SubCommand" }
        self.PresetCommonLinkParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetCommonLinkParamsDumpRequest[4] = { "bbbb", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerParamsDumpRequest = {}
        self.PresetLayerParamsDumpRequest[0] = { "1120aaaabbbbcccc", "Mask" }
        self.PresetLayerParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerParamsDumpRequest[2] = { "20", "SubCommand" }
        self.PresetLayerParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerGeneralParamsDumpRequest = {}
        self.PresetLayerGeneralParamsDumpRequest[0] = { "1121aaaabbbbcccc", "Mask" }
        self.PresetLayerGeneralParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerGeneralParamsDumpRequest[2] = { "21", "SubCommand" }
        self.PresetLayerGeneralParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerGeneralParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerGeneralParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerFilterParamsDumpRequest = {}
        self.PresetLayerFilterParamsDumpRequest[0] = { "1122aaaabbbbcccc", "Mask" }
        self.PresetLayerFilterParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerFilterParamsDumpRequest[2] = { "22", "SubCommand" }
        self.PresetLayerFilterParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerFilterParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerFilterParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerLFOParamsDumpRequest = {}
        self.PresetLayerLFOParamsDumpRequest[0] = { "1123aaaabbbbcccc", "Mask" }
        self.PresetLayerLFOParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerLFOParamsDumpRequest[2] = { "23", "SubCommand" }
        self.PresetLayerLFOParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerLFOParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerLFOParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerEnvelopeParamsDumpRequest = {}
        self.PresetLayerEnvelopeParamsDumpRequest[0] = { "1124aaaabbbbcccc", "Mask" }
        self.PresetLayerEnvelopeParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerEnvelopeParamsDumpRequest[2] = { "24", "SubCommand" }
        self.PresetLayerEnvelopeParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerEnvelopeParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerEnvelopeParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
        ---@type table<table<string,string>>
        self.PresetLayerCordParamsDumpRequest = {}
        self.PresetLayerCordParamsDumpRequest[0] = { "1125aaaabbbbcccc", "Mask" }
        self.PresetLayerCordParamsDumpRequest[1] = { "11", "Command" }
        self.PresetLayerCordParamsDumpRequest[2] = { "25", "SubCommand" }
        self.PresetLayerCordParamsDumpRequest[3] = { "aaaa", "Preset Number" }
        self.PresetLayerCordParamsDumpRequest[4] = { "bbbb", "Layer Number" }
        self.PresetLayerCordParamsDumpRequest[5] = { "cccc", "Preset ROM ID" }
    end

    do -- arpeggiator
        ---@type table<table<string,string>>
        self.ArpeggiatorPatternDumpResponse = {}
        self.ArpeggiatorPatternDumpResponse[0] = { "18aaaabbbbccccddddAAAAAAAAAAAA[256]", "Mask" }
        self.ArpeggiatorPatternDumpResponse[1] = { "18", "Command" }
        self.ArpeggiatorPatternDumpResponse[2] = { "aaaa", "Arpeggiator Pattern Number (LSB first)" }
        self.ArpeggiatorPatternDumpResponse[3] = { "bbbb", "Number of Arpeggiator Steps per Pattern(LSB first)" }
        self.ArpeggiatorPatternDumpResponse[4] = { "cccc", "Number of Arpeggiator Parameters per Step (LSB first)" }
        self.ArpeggiatorPatternDumpResponse[5] = { "dddd", "Arpeggiator Pattern Loop Point (LSB first)" }
        self.ArpeggiatorPatternDumpResponse[6] = { "AAAAAAAAAAAA", "12 ASCII Character Pattern Name" }
        self.ArpeggiatorPatternDumpResponse[7] = { "[256]", "DATA" }
        ---@type table<table<string,string>>
        self.ArpeggiatorPatternDumpRequest = {}
        self.ArpeggiatorPatternDumpRequest[0] = { "19aaaabbbb", "Mask" }
        self.ArpeggiatorPatternDumpRequest[1] = { "19", "Command" }
        self.ArpeggiatorPatternDumpRequest[2] = { "aaaa", "Arpeggiator Pattern Number (LSB first)" }
        self.ArpeggiatorPatternDumpRequest[3] = { "bbbb", "Arpeggiator Pattern ROM ID" }
        ---@type table<table<string,string>>
        self.LCDScreenDumpResponseP2KAudity2K = {}
    end

    do -- LCD
        ---@type table<table<string,string>>
        self.LCDScreenDumpResponseP2KAudity2K[0] = { "1A01aabbccMAP[48]", "Mask" }
        self.LCDScreenDumpResponseP2KAudity2K[1] = { "1A", "Command" }
        self.LCDScreenDumpResponseP2KAudity2K[2] = { "01", "SubCommand" }
        self.LCDScreenDumpResponseP2KAudity2K[3] = { "aa", "Number of Rows in the Display (2)" }
        self.LCDScreenDumpResponseP2KAudity2K[4] = { "bb", "Number of Characters per Row (24)" }
        self.LCDScreenDumpResponseP2KAudity2K[5] = { "cc", "Number of Custom Characters per Screen (8)" }
        self.LCDScreenDumpResponseP2KAudity2K[6] = { "MAP[48]", "" }
        ---@type table<table<string,string>>
        self.LCDScreenDumpRequestP2KAudity2K = {}
        self.LCDScreenDumpRequestP2KAudity2K[0] = { "1B01", "Mask" }
        self.LCDScreenDumpRequestP2KAudity2K[1] = { "1B", "Command" }
        self.LCDScreenDumpRequestP2KAudity2K[2] = { "01", "SubCommand" }
        ---@type table<table<string,string>>
        self.LCDScreenCharacterPalletResponse = {}
        self.LCDScreenCharacterPalletResponse[0] = { "1A02aabb[MAPS]", "Mask" }
        self.LCDScreenCharacterPalletResponse[1] = { "1A", "Command" }
        self.LCDScreenCharacterPalletResponse[2] = { "02", "SubCommand" }
        self.LCDScreenCharacterPalletResponse[3] = { "aa", "Number of total Custom Characters in the Palette" }
        self.LCDScreenCharacterPalletResponse[4] = { "bb", "8 x Number of Custom Characters(13)=104 Bytes" }
        self.LCDScreenCharacterPalletResponse[5] = { "[MAPS]", "" }
        ---@type table<table<string,string>>
        self.LCDScreenCharacterPalletRequest = {}
        self.LCDScreenCharacterPalletRequest[0] = { "1B02", "Mask" }
        self.LCDScreenCharacterPalletRequest[1] = { "1B", "Command" }
        self.LCDScreenCharacterPalletRequest[2] = { "02", "SubCommand" }
    end

    do -- copy/paste objects
        ---@type table<table<string,string>>
        self.CopyPresetRequest = {}
        self.CopyPresetRequest[0] = { "20aaaabbbbcccc", "Mask" }
        self.CopyPresetRequest[1] = { "20", "Command" }
        self.CopyPresetRequest[2] = { "aaaa", "Source Preset number (ROM or RAM) LSB first" }
        self.CopyPresetRequest[3] = { "bbbb",
            "Destination Preset number (RAM only) LSB firstPreset Number of -1 bis the Edit Buffer." }
        self.CopyPresetRequest[4] = { "cccc", "Source ROM ID" }
        ---@type table<table<string,string>>
        self.CopyPresetCommonParametersRequest = {}
        self.CopyPresetCommonParametersRequest[0] = { "21aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyArpParametersRequest = {}
        self.CopyArpParametersRequest[0] = { "22aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyEffectsParametersRequestMasterorPreset = {}
        self.CopyEffectsParametersRequestMasterorPreset[0] = { "23aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLinkParametersRequest = {}
        self.CopyPresetLinkParametersRequest[0] = { "24aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLayerRequest = {}
        self.CopyPresetLayerRequest[0] = { "25aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLayerCommonParametersRequest = {}
        self.CopyPresetLayerCommonParametersRequest[0] = { "26aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLayerFilterParametersRequest = {}
        self.CopyPresetLayerFilterParametersRequest[0] = { "27aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLayerLFOParametersRequest = {}
        self.CopyPresetLayerLFOParametersRequest[0] = { "28aaaabbbbcccc", "Mask" }
        self.CopyPresetLayerEnvelopeParametersRequest = {}
        self.CopyPresetLayerEnvelopeParametersRequest[0] = { "29aaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPresetLayerPatchCordsRequest = {}
        self.CopyPresetLayerPatchCordsRequest[0] = { "2Aaaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyArpPatternRequest = {}
        self.CopyArpPatternRequest[0] = { "2Baaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopyMasterSetupRequest = {}
        self.CopyMasterSetupRequest[0] = { "2Caaaabbbb", "Mask" }
        ---@type table<table<string,string>>
        self.CopyPatternRequest = {}
        self.CopyPatternRequest[0] = { "2Daaaabbbbcccc", "Mask" }
        ---@type table<table<string,string>>
        self.CopySongRequest = {}
        self.CopySongRequest[0] = { "2Eaaaabbbbcccc", "Mask" }
    end

    return self
end


---@class MessageContracts
local MessageContracts = {}
---tables holding positions of elements in sysex messages
---@param o any
---@return MessageContracts
function MessageContracts:new(o)
    o = o or {}
    setmetatable(o, self)
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

    do -- Setup Dump By Position
        ---@type table<table<integer,integer>>
        self.SetupDump = {}
        self.SetupDump[0] = { 1, 1 }
        self.SetupDump[2] = { 2, 3 }
        self.SetupDump[4] = { 4, 5 }
        self.SetupDump[6] = { 6, 7 }
        self.SetupDump[8] = { 8, 9 }
        self.SetupDump[10] = { 10, 11 }
        self.SetupDump[12] = { 12, 13 }
        self.SetupDump[14] = { 14, 15 }
        self.SetupDump[142] = { 16, 16 }
        self.SetupDump[143] = { 17, 17 }
        self.SetupDump[144] = { 18, 18 }
        self.SetupDump[145] = { 19, 19 }
        self.SetupDump[146] = { 20, 20 }
        self.SetupDump[147] = { 21, 21 }
        self.SetupDump[148] = { 22, 22 }
        self.SetupDump[149] = { 23, 23 }
        self.SetupDump[150] = { 24, 24 }
        self.SetupDump[151] = { 25, 25 }
        self.SetupDump[152] = { 26, 26 }
        self.SetupDump[153] = { 27, 27 }
        self.SetupDump[154] = { 28, 28 }
        self.SetupDump[155] = { 29, 29 }
        self.SetupDump[156] = { 30, 30 }
        self.SetupDump[157] = { 31, 31 }
        self.SetupDump[257] = { 32, 33 }
        self.SetupDump[258] = { 34, 35 }
        self.SetupDump[259] = { 36, 37 }
        self.SetupDump[260] = { 38, 39 }
        self.SetupDump[264] = { 40, 41 }
        self.SetupDump[264] = { 42, 43 }
        self.SetupDump[265] = { 44, 45 }
        self.SetupDump[266] = { 46, 47 }
        self.SetupDump[267] = { 48, 49 }
        self.SetupDump[268] = { 50, 51 }
        self.SetupDump[269] = { 52, 53 }
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
        self.SetupDump[385] = { 92, 93 }
        self.SetupDump[386] = { 94, 95 }
        self.SetupDump[388] = { 96, 97 }
        self.SetupDump[391] = { 98, 99 }
        self.SetupDump[392] = { 100, 101 }
        self.SetupDump[393] = { 102, 103 }
        self.SetupDump[394] = { 104, 105 }
        self.SetupDump[395] = { 106, 107 }
        self.SetupDump[396] = { 108, 109 }
        self.SetupDump[397] = { 110, 111 }
        self.SetupDump[398] = { 112, 113 }
        self.SetupDump[399] = { 114, 115 }
        self.SetupDump[400] = { 116, 117 }
        self.SetupDump[401] = { 118, 119 }
        self.SetupDump[402] = { 120, 121 }
        self.SetupDump[403] = { 122, 123 }
        self.SetupDump[404] = { 124, 125 }
        self.SetupDump[405] = { 126, 127 }
        self.SetupDump[406] = { 128, 129 }
        self.SetupDump[407] = { 130, 131 }
        self.SetupDump[408] = { 132, 133 }
        self.SetupDump[409] = { 134, 135 }
        self.SetupDump[411] = { 136, 137 }
        self.SetupDump[412] = { 138, 139 }
        self.SetupDump[413] = { 140, 141 }
        self.SetupDump[414] = { 142, 143 }
        self.SetupDump[415] = { 144, 145 }
        self.SetupDump[416] = { 146, 147 }
        self.SetupDump[417] = { 148, 149 }
        self.SetupDump[418] = { 150, 151 }
        self.SetupDump[419] = { 152, 153 }
        self.SetupDump[420] = { 154, 155 }
        self.SetupDump[421] = { 156, 157 }
        self.SetupDump[422] = { 158, 159 }
        -- self.SetupDump[OWN] = {160,161}
        self.SetupDump[513] = { 162, 163 }
        self.SetupDump[514] = { 164, 165 }
        self.SetupDump[515] = { 166, 167 }
        self.SetupDump[516] = { 168, 169 }
        self.SetupDump[517] = { 170, 171 }
        self.SetupDump[518] = { 172, 173 }
        self.SetupDump[519] = { 174, 175 }
        self.SetupDump[520] = { 176, 177 }
        self.SetupDump[521] = { 178, 179 }
        self.SetupDump[522] = { 180, 181 }
        self.SetupDump[523] = { 182, 183 }
        self.SetupDump[524] = { 184, 185 }
        self.SetupDump[525] = { 186, 187 }
        self.SetupDump[526] = { 188, 189 }
        self.SetupDump[527] = { 190, 191 }
        self.SetupDump[528] = { 192, 193 }
        self.SetupDump[641] = { 194, 195 }
        self.SetupDump[642] = { 196, 197 }
        self.SetupDump[643] = { 198, 199 }
        self.SetupDump[644] = { 200, 201 }
        self.SetupDump[645] = { 202, 203 }
        self.SetupDump[646] = { 204, 205 }
        self.SetupDump[647] = { 206, 207 }
        self.SetupDump[648] = { 208, 209 }
        self.SetupDump[649] = { 210, 211 }
        self.SetupDump[650] = { 212, 213 }
        self.SetupDump[651] = { 214, 215 }
        self.SetupDump[652] = { 216, 217 }
        self.SetupDump[653] = { 218, 219 }
        self.SetupDump[654] = { 220, 221 }
        self.SetupDump[655] = { 222, 223 }
        self.SetupDump[656] = { 224, 225 }
        self.SetupDump[657] = { 226, 227 }
        self.SetupDump[658] = { 228, 229 }
        self.SetupDump[659] = { 230, 231 }
        self.SetupDump[661] = { 232, 233 }
        self.SetupDump[768] = { 234, 235 }
        self.SetupDump[139] = { 236, 237 }
        self.SetupDump[140] = { 238, 239 }
        self.SetupDump[141] = { 240, 241 }
        self.SetupDump[130] = { 242, 243 }
        self.SetupDump[131] = { 244, 245 }
        self.SetupDump[132] = { 246, 247 }
        self.SetupDump[133] = { 248, 249 }
        self.SetupDump[134] = { 250, 251 }
        self.SetupDump[135] = { 252, 253 }
        self.SetupDump[136] = { 254, 255 }
        self.SetupDump[137] = { 256, 257 }
        self.SetupDump[138] = { 258, 259 }
        self.SetupDump[130] = { 260, 261 }
        self.SetupDump[131] = { 262, 263 }
        self.SetupDump[132] = { 264, 265 }
        self.SetupDump[133] = { 266, 267 }
        self.SetupDump[134] = { 268, 269 }
        self.SetupDump[135] = { 270, 271 }
        self.SetupDump[136] = { 272, 273 }
        self.SetupDump[137] = { 274, 275 }
        self.SetupDump[138] = { 276, 277 }
        self.SetupDump[130] = { 278, 279 }
        self.SetupDump[131] = { 280, 281 }
        self.SetupDump[132] = { 282, 283 }
        self.SetupDump[133] = { 284, 285 }
        self.SetupDump[134] = { 286, 287 }
        self.SetupDump[135] = { 288, 289 }
        self.SetupDump[136] = { 290, 291 }
        self.SetupDump[137] = { 292, 293 }
        self.SetupDump[138] = { 294, 295 }
        self.SetupDump[130] = { 296, 297 }
        self.SetupDump[131] = { 298, 299 }
        self.SetupDump[132] = { 300, 301 }
        self.SetupDump[133] = { 302, 303 }
        self.SetupDump[134] = { 304, 305 }
        self.SetupDump[135] = { 306, 307 }
        self.SetupDump[136] = { 308, 309 }
        self.SetupDump[137] = { 310, 311 }
        self.SetupDump[138] = { 312, 313 }
        self.SetupDump[130] = { 314, 315 }
        self.SetupDump[131] = { 316, 317 }
        self.SetupDump[132] = { 318, 319 }
        self.SetupDump[133] = { 320, 321 }
        self.SetupDump[134] = { 322, 323 }
        self.SetupDump[135] = { 324, 325 }
        self.SetupDump[136] = { 326, 327 }
        self.SetupDump[137] = { 328, 329 }
        self.SetupDump[138] = { 330, 331 }
        self.SetupDump[130] = { 332, 333 }
        self.SetupDump[131] = { 334, 335 }
        self.SetupDump[132] = { 336, 337 }
        self.SetupDump[133] = { 338, 339 }
        self.SetupDump[134] = { 340, 341 }
        self.SetupDump[135] = { 342, 343 }
        self.SetupDump[136] = { 344, 345 }
        self.SetupDump[137] = { 346, 347 }
        self.SetupDump[138] = { 348, 349 }
        self.SetupDump[130] = { 350, 351 }
        self.SetupDump[131] = { 352, 353 }
        self.SetupDump[132] = { 354, 355 }
        self.SetupDump[133] = { 356, 357 }
        self.SetupDump[134] = { 358, 359 }
        self.SetupDump[135] = { 360, 361 }
        self.SetupDump[136] = { 362, 363 }
        self.SetupDump[137] = { 364, 365 }
        self.SetupDump[138] = { 366, 367 }
        self.SetupDump[130] = { 368, 369 }
        self.SetupDump[131] = { 370, 371 }
        self.SetupDump[132] = { 372, 373 }
        self.SetupDump[133] = { 374, 375 }
        self.SetupDump[134] = { 376, 377 }
        self.SetupDump[135] = { 378, 379 }
        self.SetupDump[136] = { 380, 381 }
        self.SetupDump[137] = { 382, 383 }
        self.SetupDump[138] = { 384, 385 }
        self.SetupDump[130] = { 386, 387 }
        self.SetupDump[131] = { 388, 389 }
        self.SetupDump[132] = { 390, 391 }
        self.SetupDump[133] = { 392, 393 }
        self.SetupDump[134] = { 394, 395 }
        self.SetupDump[135] = { 396, 397 }
        self.SetupDump[136] = { 398, 399 }
        self.SetupDump[137] = { 400, 401 }
        self.SetupDump[138] = { 402, 403 }
        self.SetupDump[130] = { 404, 405 }
        self.SetupDump[131] = { 406, 407 }
        self.SetupDump[132] = { 408, 409 }
        self.SetupDump[133] = { 410, 411 }
        self.SetupDump[134] = { 412, 413 }
        self.SetupDump[135] = { 414, 415 }
        self.SetupDump[136] = { 416, 417 }
        self.SetupDump[137] = { 418, 419 }
        self.SetupDump[138] = { 420, 421 }
        self.SetupDump[130] = { 422, 423 }
        self.SetupDump[131] = { 424, 425 }
        self.SetupDump[132] = { 426, 427 }
        self.SetupDump[133] = { 428, 429 }
        self.SetupDump[134] = { 430, 431 }
        self.SetupDump[135] = { 432, 433 }
        self.SetupDump[136] = { 434, 435 }
        self.SetupDump[137] = { 436, 437 }
        self.SetupDump[138] = { 438, 439 }
        self.SetupDump[130] = { 440, 441 }
        self.SetupDump[131] = { 442, 443 }
        self.SetupDump[132] = { 444, 445 }
        self.SetupDump[133] = { 446, 447 }
        self.SetupDump[134] = { 448, 449 }
        self.SetupDump[135] = { 450, 451 }
        self.SetupDump[136] = { 452, 453 }
        self.SetupDump[137] = { 454, 455 }
        self.SetupDump[138] = { 456, 457 }
        self.SetupDump[130] = { 458, 459 }
        self.SetupDump[131] = { 460, 461 }
        self.SetupDump[132] = { 462, 463 }
        self.SetupDump[133] = { 464, 465 }
        self.SetupDump[134] = { 466, 467 }
        self.SetupDump[135] = { 468, 469 }
        self.SetupDump[136] = { 470, 471 }
        self.SetupDump[137] = { 472, 473 }
        self.SetupDump[138] = { 474, 475 }
        self.SetupDump[130] = { 476, 477 }
        self.SetupDump[131] = { 478, 479 }
        self.SetupDump[132] = { 480, 481 }
        self.SetupDump[133] = { 482, 483 }
        self.SetupDump[134] = { 484, 485 }
        self.SetupDump[135] = { 486, 487 }
        self.SetupDump[136] = { 488, 489 }
        self.SetupDump[137] = { 490, 491 }
        self.SetupDump[138] = { 492, 493 }
        self.SetupDump[130] = { 494, 495 }
        self.SetupDump[131] = { 496, 497 }
        self.SetupDump[132] = { 498, 499 }
        self.SetupDump[133] = { 500, 501 }
        self.SetupDump[134] = { 502, 503 }
        self.SetupDump[135] = { 504, 505 }
        self.SetupDump[136] = { 506, 507 }
        self.SetupDump[137] = { 508, 509 }
        self.SetupDump[138] = { 510, 511 }
        self.SetupDump[130] = { 512, 513 }
        self.SetupDump[131] = { 514, 515 }
        self.SetupDump[132] = { 516, 517 }
        self.SetupDump[133] = { 518, 519 }
        self.SetupDump[134] = { 520, 521 }
        self.SetupDump[135] = { 522, 523 }
        self.SetupDump[136] = { 524, 525 }
        self.SetupDump[137] = { 526, 527 }
        self.SetupDump[138] = { 528, 529 }
        self.SetupDump[130] = { 530, 531 }
        self.SetupDump[131] = { 532, 533 }
        self.SetupDump[132] = { 534, 535 }
        self.SetupDump[133] = { 536, 537 }
        self.SetupDump[134] = { 538, 539 }
        self.SetupDump[135] = { 540, 541 }
        self.SetupDump[136] = { 542, 543 }
        self.SetupDump[137] = { 544, 545 }
        self.SetupDump[138] = { 546, 547 }
        self.SetupDump[130] = { 548, 549 }
        self.SetupDump[131] = { 550, 551 }
        self.SetupDump[132] = { 552, 553 }
        self.SetupDump[133] = { 554, 555 }
        self.SetupDump[134] = { 556, 557 }
        self.SetupDump[135] = { 558, 559 }
        self.SetupDump[136] = { 560, 561 }
        self.SetupDump[137] = { 562, 563 }
        self.SetupDump[138] = { 564, 565 }
        self.SetupDump[130] = { 566, 567 }
        self.SetupDump[131] = { 568, 569 }
        self.SetupDump[132] = { 570, 571 }
        self.SetupDump[133] = { 572, 573 }
        self.SetupDump[134] = { 574, 575 }
        self.SetupDump[135] = { 576, 577 }
        self.SetupDump[136] = { 578, 579 }
        self.SetupDump[137] = { 580, 581 }
        self.SetupDump[138] = { 582, 583 }
        self.SetupDump[130] = { 584, 585 }
        self.SetupDump[131] = { 586, 587 }
        self.SetupDump[132] = { 588, 589 }
        self.SetupDump[133] = { 590, 591 }
        self.SetupDump[134] = { 592, 593 }
        self.SetupDump[135] = { 594, 595 }
        self.SetupDump[136] = { 596, 597 }
        self.SetupDump[137] = { 598, 599 }
        self.SetupDump[138] = { 600, 601 }
        self.SetupDump[130] = { 602, 603 }
        self.SetupDump[131] = { 604, 605 }
        self.SetupDump[132] = { 606, 607 }
        self.SetupDump[133] = { 608, 609 }
        self.SetupDump[134] = { 610, 611 }
        self.SetupDump[135] = { 612, 613 }
        self.SetupDump[136] = { 614, 615 }
        self.SetupDump[137] = { 616, 617 }
        self.SetupDump[138] = { 618, 619 }
        self.SetupDump[130] = { 620, 621 }
        self.SetupDump[131] = { 622, 623 }
        self.SetupDump[132] = { 624, 625 }
        self.SetupDump[133] = { 626, 627 }
        self.SetupDump[134] = { 628, 629 }
        self.SetupDump[135] = { 630, 631 }
        self.SetupDump[136] = { 632, 633 }
        self.SetupDump[137] = { 634, 635 }
        self.SetupDump[138] = { 636, 637 }
        self.SetupDump[130] = { 638, 639 }
        self.SetupDump[131] = { 640, 641 }
        self.SetupDump[132] = { 642, 643 }
        self.SetupDump[133] = { 644, 645 }
        self.SetupDump[134] = { 646, 647 }
        self.SetupDump[135] = { 648, 649 }
        self.SetupDump[136] = { 650, 651 }
        self.SetupDump[137] = { 652, 653 }
        self.SetupDump[138] = { 654, 655 }
        self.SetupDump[130] = { 656, 657 }
        self.SetupDump[131] = { 658, 659 }
        self.SetupDump[132] = { 660, 661 }
        self.SetupDump[133] = { 662, 663 }
        self.SetupDump[134] = { 664, 665 }
        self.SetupDump[135] = { 666, 667 }
        self.SetupDump[136] = { 668, 669 }
        self.SetupDump[137] = { 670, 671 }
        self.SetupDump[138] = { 672, 673 }
        self.SetupDump[130] = { 674, 675 }
        self.SetupDump[131] = { 676, 677 }
        self.SetupDump[132] = { 678, 679 }
        self.SetupDump[133] = { 680, 681 }
        self.SetupDump[134] = { 682, 683 }
        self.SetupDump[135] = { 684, 685 }
        self.SetupDump[136] = { 686, 687 }
        self.SetupDump[137] = { 688, 689 }
        self.SetupDump[138] = { 690, 691 }
        self.SetupDump[130] = { 692, 693 }
        self.SetupDump[131] = { 694, 695 }
        self.SetupDump[132] = { 696, 697 }
        self.SetupDump[133] = { 698, 699 }
        self.SetupDump[134] = { 700, 701 }
        self.SetupDump[135] = { 702, 703 }
        self.SetupDump[136] = { 704, 705 }
        self.SetupDump[137] = { 706, 707 }
        self.SetupDump[138] = { 708, 709 }
        self.SetupDump[130] = { 710, 711 }
        self.SetupDump[131] = { 712, 713 }
        self.SetupDump[132] = { 714, 715 }
        self.SetupDump[133] = { 716, 717 }
        self.SetupDump[134] = { 718, 719 }
        self.SetupDump[135] = { 720, 721 }
        self.SetupDump[136] = { 722, 723 }
        self.SetupDump[137] = { 724, 725 }
        self.SetupDump[138] = { 726, 727 }
        self.SetupDump[130] = { 728, 729 }
        self.SetupDump[131] = { 730, 731 }
        self.SetupDump[132] = { 732, 733 }
        self.SetupDump[133] = { 734, 735 }
        self.SetupDump[134] = { 736, 737 }
        self.SetupDump[135] = { 738, 739 }
        self.SetupDump[136] = { 740, 741 }
        self.SetupDump[137] = { 742, 743 }
        self.SetupDump[138] = { 744, 745 }
        self.SetupDump[130] = { 746, 747 }
        self.SetupDump[131] = { 748, 749 }
        self.SetupDump[132] = { 750, 751 }
        self.SetupDump[133] = { 752, 753 }
        self.SetupDump[134] = { 754, 755 }
        self.SetupDump[135] = { 756, 757 }
        self.SetupDump[136] = { 758, 759 }
        self.SetupDump[137] = { 760, 761 }
        self.SetupDump[138] = { 762, 763 }
        self.SetupDump[130] = { 764, 765 }
        self.SetupDump[131] = { 766, 767 }
        self.SetupDump[132] = { 768, 769 }
        self.SetupDump[133] = { 770, 771 }
        self.SetupDump[134] = { 772, 773 }
        self.SetupDump[135] = { 774, 775 }
        self.SetupDump[136] = { 776, 777 }
        self.SetupDump[137] = { 778, 779 }
        self.SetupDump[138] = { 780, 781 }
        self.SetupDump[130] = { 782, 783 }
        self.SetupDump[131] = { 784, 785 }
        self.SetupDump[132] = { 786, 787 }
        self.SetupDump[133] = { 788, 789 }
        self.SetupDump[134] = { 790, 791 }
        self.SetupDump[135] = { 792, 793 }
        self.SetupDump[136] = { 794, 795 }
        self.SetupDump[137] = { 796, 797 }
        self.SetupDump[138] = { 798, 799 }
        self.SetupDump[130] = { 800, 801 }
        self.SetupDump[131] = { 802, 803 }
        self.SetupDump[132] = { 804, 805 }
        self.SetupDump[133] = { 806, 807 }
        self.SetupDump[134] = { 808, 809 }
        self.SetupDump[135] = { 810, 811 }
        self.SetupDump[136] = { 812, 813 }
        self.SetupDump[137] = { 814, 815 }
        self.SetupDump[138] = { 816, 817 }
    end


    do -- Preset Dump By Position
        self.PresetDump = {}
        self.PresetDump[899] = {1,1}
        self.PresetDump[900] = {2,2}
        self.PresetDump[901] = {3,3}
        self.PresetDump[902] = {4,4}
        self.PresetDump[903] = {5,5}
        self.PresetDump[904] = {6,6}
        self.PresetDump[905] = {7,7}
        self.PresetDump[906] = {8,8}
        self.PresetDump[907] = {9,9}
        self.PresetDump[908] = {10,10}
        self.PresetDump[909] = {11,11}
        self.PresetDump[910] = {12,12}
        self.PresetDump[911] = {13,13}
        self.PresetDump[912] = {14,14}
        self.PresetDump[913] = {15,15}
        self.PresetDump[914] = {16,16}
        self.PresetDump[915] = {17,18}
        self.PresetDump[916] = {19,20}
        self.PresetDump[917] = {21,22}
        self.PresetDump[918] = {23,24}
        self.PresetDump[919] = {25,26}
        self.PresetDump[920] = {27,28}
        self.PresetDump[921] = {29,30}
        self.PresetDump[922] = {31,32}
        self.PresetDump[923] = {33,34}
        self.PresetDump[924] = {35,36}
        self.PresetDump[925] = {37,38}
        self.PresetDump[926] = {39,40}
        self.PresetDump[927] = {41,42}
        self.PresetDump[928] = {43,44}
        self.PresetDump[929] = {45,46}
        self.PresetDump[930] = {47,48}
        self.PresetDump[931] = {49,50}
        self.PresetDump[932] = {51,52}
        self.PresetDump[933] = {53,54}
        self.PresetDump[934] = {55,56}
        self.PresetDump[935] = {57,58}
        self.PresetDump[936] = {59,60}
        self.PresetDump[937] = {61,62}
        self.PresetDump[938] = {63,64}
        self.PresetDump[939] = {65,66}
        self.PresetDump[940] = {67,68}
        self.PresetDump[941] = {69,70}
        self.PresetDump[942] = {71,72}
        self.PresetDump[943] = {73,74}
        self.PresetDump[944] = {75,76}
        self.PresetDump[945] = {77,78}
        self.PresetDump[946] = {79,80}
        self.PresetDump[947] = {81,82}
        self.PresetDump[948] = {83,84}
        self.PresetDump[949] = {85,86}
        self.PresetDump[950] = {87,88}
        self.PresetDump[951] = {89,90}
        self.PresetDump[952] = {91,92}
        self.PresetDump[953] = {93,94}
        self.PresetDump[954] = {95,96}
        self.PresetDump[955] = {97,98}
        self.PresetDump[956] = {99,100}
        self.PresetDump[957] = {101,102}
        self.PresetDump[958] = {103,104}
        self.PresetDump[959] = {105,106}
        self.PresetDump[960] = {107,108}
        self.PresetDump[961] = {109,110}
        self.PresetDump[962] = {111,112}
        self.PresetDump[963] = {113,114}
        self.PresetDump[964] = {115,116}
        self.PresetDump[965] = {117,118}
        self.PresetDump[966] = {119,120}
        self.PresetDump[967] = {121,122}
        self.PresetDump[968] = {123,124}
        self.PresetDump[969] = {125,126}
        self.PresetDump[970] = {127,128}
        self.PresetDump[1025] = {129,130}
        self.PresetDump[1026] = {131,132}
        self.PresetDump[1027] = {133,134}
        self.PresetDump[1028] = {135,136}
        self.PresetDump[1029] = {137,138}
        self.PresetDump[1030] = {139,140}
        self.PresetDump[1031] = {141,142}
        self.PresetDump[1032] = {143,144}
        self.PresetDump[1033] = {145,146}
        self.PresetDump[1034] = {147,148}
        self.PresetDump[1035] = {149,150}
        self.PresetDump[1036] = {151,152}
        self.PresetDump[1037] = {153,154}
        self.PresetDump[1038] = {155,156}
        self.PresetDump[1039] = {157,158}
        self.PresetDump[1040] = {159,160}
        self.PresetDump[1041] = {161,162}
        self.PresetDump[1042] = {163,164}
        self.PresetDump[1043] = {165,166}
        self.PresetDump[1153] = {167,168}
        self.PresetDump[1154] = {169,170}
        self.PresetDump[1155] = {171,172}
        self.PresetDump[1156] = {173,174}
        self.PresetDump[1157] = {175,176}
        self.PresetDump[1158] = {177,178}
        self.PresetDump[1159] = {179,180}
        self.PresetDump[1160] = {181,182}
        self.PresetDump[1161] = {183,184}
        self.PresetDump[1162] = {185,186}
        self.PresetDump[1163] = {187,188}
        self.PresetDump[1164] = {189,190}
        self.PresetDump[1165] = {191,192}
        self.PresetDump[1166] = {193,194}
        self.PresetDump[1167] = {195,196}
        self.PresetDump[1168] = {197,198}
        self.PresetDump[1281] = {199,200}
        self.PresetDump[1282] = {201,202}
        self.PresetDump[1283] = {203,204}
        self.PresetDump[1284] = {205,206}
        self.PresetDump[1285] = {207,208}
        self.PresetDump[1286] = {209,210}
        self.PresetDump[1287] = {211,212}
        self.PresetDump[1288] = {213,214}
        self.PresetDump[1289] = {215,216}
        self.PresetDump[1290] = {217,218}
        self.PresetDump[1291] = {219,220}
        self.PresetDump[1292] = {221,222}
        self.PresetDump[1293] = {223,224}
        self.PresetDump[1294] = {225,226}
        self.PresetDump[1295] = {227,228}
        self.PresetDump[1296] = {229,230}
        self.PresetDump[1297] = {231,232}
        self.PresetDump[1298] = {233,234}
        self.PresetDump[1299] = {235,236}
        self.PresetDump[1300] = {237,238}
        self.PresetDump[14091] = {239,240}
        self.PresetDump[14101] = {241,242}
        self.PresetDump[14111] = {243,244}
        self.PresetDump[14121] = {245,246}
        self.PresetDump[14131] = {247,248}
        self.PresetDump[14141] = {249,250}
        self.PresetDump[14151] = {251,252}
        self.PresetDump[14161] = {253,254}
        self.PresetDump[14171] = {255,256}
        self.PresetDump[14181] = {257,258}
        self.PresetDump[14191] = {259,260}
        self.PresetDump[14201] = {261,262}
        self.PresetDump[14211] = {263,264}
        self.PresetDump[14221] = {265,266}
        self.PresetDump[14231] = {267,268}
        self.PresetDump[14241] = {269,270}
        self.PresetDump[14251] = {271,272}
        self.PresetDump[14261] = {273,274}
        self.PresetDump[14271] = {275,276}
        self.PresetDump[14281] = {277,278}
        self.PresetDump[14291] = {279,280}
        self.PresetDump[14301] = {281,282}
        self.PresetDump[14311] = {283,284}
        self.PresetDump[14321] = {285,286}
        self.PresetDump[14331] = {287,288}
        self.PresetDump[14341] = {289,290}
        self.PresetDump[14351] = {291,292}
        self.PresetDump[14361] = {293,294}
        self.PresetDump[14371] = {295,296}
        self.PresetDump[14381] = {297,298}
        self.PresetDump[14391] = {299,300}
        self.PresetDump[15371] = {301,302}
        self.PresetDump[15381] = {303,304}
        self.PresetDump[15391] = {305,306}
        self.PresetDump[16651] = {307,308}
        self.PresetDump[16661] = {309,310}
        self.PresetDump[16671] = {311,312}
        self.PresetDump[16681] = {313,314}
        self.PresetDump[16691] = {315,316}
        self.PresetDump[16701] = {317,318}
        self.PresetDump[16711] = {319,320}
        self.PresetDump[16721] = {321,322}
        self.PresetDump[16731] = {323,324}
        self.PresetDump[16741] = {325,326}
        self.PresetDump[17931] = {327,328}
        self.PresetDump[17941] = {329,330}
        self.PresetDump[17951] = {331,332}
        self.PresetDump[17961] = {333,334}
        self.PresetDump[17971] = {335,336}
        self.PresetDump[17981] = {337,338}
        self.PresetDump[17991] = {339,340}
        self.PresetDump[18001] = {341,342}
        self.PresetDump[18011] = {343,344}
        self.PresetDump[18021] = {345,346}
        self.PresetDump[18031] = {347,348}
        self.PresetDump[18041] = {349,350}
        self.PresetDump[18051] = {351,352}
        self.PresetDump[18061] = {353,354}
        self.PresetDump[18071] = {355,356}
        self.PresetDump[18081] = {357,358}
        self.PresetDump[18091] = {359,360}
        self.PresetDump[18101] = {361,362}
        self.PresetDump[18111] = {363,364}
        self.PresetDump[18121] = {365,366}
        self.PresetDump[18131] = {367,368}
        self.PresetDump[18141] = {369,370}
        self.PresetDump[18151] = {371,372}
        self.PresetDump[18161] = {373,374}
        self.PresetDump[18171] = {375,376}
        self.PresetDump[18181] = {377,378}
        self.PresetDump[18191] = {379,380}
        self.PresetDump[18201] = {381,382}
        self.PresetDump[18211] = {383,384}
        self.PresetDump[18221] = {385,386}
        self.PresetDump[18231] = {387,388}
        self.PresetDump[18241] = {389,390}
        self.PresetDump[18251] = {391,392}
        self.PresetDump[18261] = {393,394}
        self.PresetDump[18271] = {395,396}
        self.PresetDump[18281] = {397,398}
        self.PresetDump[18291] = {399,400}
        self.PresetDump[18301] = {401,402}
        self.PresetDump[18311] = {403,404}
        self.PresetDump[18331] = {405,406}
        self.PresetDump[18341] = {407,408}
        self.PresetDump[19201] = {409,410}
        self.PresetDump[19211] = {411,412}
        self.PresetDump[19221] = {413,414}
        self.PresetDump[19231] = {415,416}
        self.PresetDump[19241] = {417,418}
        self.PresetDump[19251] = {419,420}
        self.PresetDump[19261] = {421,422}
        self.PresetDump[19271] = {423,424}
        self.PresetDump[19281] = {425,426}
        self.PresetDump[19291] = {427,428}
        self.PresetDump[19301] = {429,430}
        self.PresetDump[19311] = {431,432}
        self.PresetDump[19321] = {433,434}
        self.PresetDump[19331] = {435,436}
        self.PresetDump[19341] = {437,438}
        self.PresetDump[19351] = {439,440}
        self.PresetDump[19361] = {441,442}
        self.PresetDump[19371] = {443,444}
        self.PresetDump[19381] = {445,446}
        self.PresetDump[19391] = {447,448}
        self.PresetDump[19401] = {449,450}
        self.PresetDump[19411] = {451,452}
        self.PresetDump[19421] = {453,454}
        self.PresetDump[19431] = {455,456}
        self.PresetDump[19441] = {457,458}
        self.PresetDump[19451] = {459,460}
        self.PresetDump[19461] = {461,462}
        self.PresetDump[19471] = {463,464}
        self.PresetDump[19481] = {465,466}
        self.PresetDump[19491] = {467,468}
        self.PresetDump[19501] = {469,470}
        self.PresetDump[19511] = {471,472}
        self.PresetDump[19521] = {473,474}
        self.PresetDump[19531] = {475,476}
        self.PresetDump[19541] = {477,478}
        self.PresetDump[19551] = {479,480}
        self.PresetDump[19561] = {481,482}
        self.PresetDump[19571] = {483,484}
        self.PresetDump[19581] = {485,486}
        self.PresetDump[19591] = {487,488}
        self.PresetDump[19601] = {489,490}
        self.PresetDump[19611] = {491,492}
        self.PresetDump[19621] = {493,494}
        self.PresetDump[19631] = {495,496}
        self.PresetDump[19641] = {497,498}
        self.PresetDump[19651] = {499,500}
        self.PresetDump[19661] = {501,502}
        self.PresetDump[19671] = {503,504}
        self.PresetDump[19681] = {505,506}
        self.PresetDump[19691] = {507,508}
        self.PresetDump[19701] = {509,510}
        self.PresetDump[19711] = {511,512}
        self.PresetDump[19721] = {513,514}
        self.PresetDump[19731] = {515,516}
        self.PresetDump[19741] = {517,518}
        self.PresetDump[19751] = {519,520}
        self.PresetDump[19761] = {521,522}
        self.PresetDump[19771] = {523,524}
        self.PresetDump[19781] = {525,526}
        self.PresetDump[19791] = {527,528}
        self.PresetDump[19801] = {529,530}
        self.PresetDump[19811] = {531,532}
        self.PresetDump[19821] = {533,534}
        self.PresetDump[19831] = {535,536}
        self.PresetDump[19841] = {537,538}
        self.PresetDump[19851] = {539,540}
        self.PresetDump[19861] = {541,542}
        self.PresetDump[19871] = {543,544}
        self.PresetDump[19881] = {545,546}
        self.PresetDump[19891] = {547,548}
        self.PresetDump[19901] = {549,550}
        self.PresetDump[19911] = {551,552}
        self.PresetDump[19921] = {553,554}
        self.PresetDump[14092] = {555,556}
        self.PresetDump[14102] = {557,558}
        self.PresetDump[14112] = {559,560}
        self.PresetDump[14122] = {561,562}
        self.PresetDump[14132] = {563,564}
        self.PresetDump[14142] = {565,566}
        self.PresetDump[14152] = {567,568}
        self.PresetDump[14162] = {569,570}
        self.PresetDump[14172] = {571,572}
        self.PresetDump[14182] = {573,574}
        self.PresetDump[14192] = {575,576}
        self.PresetDump[14202] = {577,578}
        self.PresetDump[14212] = {579,580}
        self.PresetDump[14222] = {581,582}
        self.PresetDump[14232] = {583,584}
        self.PresetDump[14242] = {585,586}
        self.PresetDump[14252] = {587,588}
        self.PresetDump[14262] = {589,590}
        self.PresetDump[14272] = {591,592}
        self.PresetDump[14282] = {593,594}
        self.PresetDump[14292] = {595,596}
        self.PresetDump[14302] = {597,598}
        self.PresetDump[14312] = {599,600}
        self.PresetDump[14322] = {601,602}
        self.PresetDump[14332] = {603,604}
        self.PresetDump[14342] = {605,606}
        self.PresetDump[14352] = {607,608}
        self.PresetDump[14362] = {609,610}
        self.PresetDump[14372] = {611,612}
        self.PresetDump[14382] = {613,614}
        self.PresetDump[14392] = {615,616}
        self.PresetDump[15372] = {617,618}
        self.PresetDump[15382] = {619,620}
        self.PresetDump[15392] = {621,622}
        self.PresetDump[16652] = {623,624}
        self.PresetDump[16662] = {625,626}
        self.PresetDump[16672] = {627,628}
        self.PresetDump[16682] = {629,630}
        self.PresetDump[16692] = {631,632}
        self.PresetDump[16702] = {633,634}
        self.PresetDump[16712] = {635,636}
        self.PresetDump[16722] = {637,638}
        self.PresetDump[16732] = {639,640}
        self.PresetDump[16742] = {641,642}
        self.PresetDump[17932] = {643,644}
        self.PresetDump[17942] = {645,646}
        self.PresetDump[17952] = {647,648}
        self.PresetDump[17962] = {649,650}
        self.PresetDump[17972] = {651,652}
        self.PresetDump[17982] = {653,654}
        self.PresetDump[17992] = {655,656}
        self.PresetDump[18002] = {657,658}
        self.PresetDump[18012] = {659,660}
        self.PresetDump[18022] = {661,662}
        self.PresetDump[18032] = {663,664}
        self.PresetDump[18042] = {665,666}
        self.PresetDump[18052] = {667,668}
        self.PresetDump[18062] = {669,670}
        self.PresetDump[18072] = {671,672}
        self.PresetDump[18082] = {673,674}
        self.PresetDump[18092] = {675,676}
        self.PresetDump[18102] = {677,678}
        self.PresetDump[18112] = {679,680}
        self.PresetDump[18122] = {681,682}
        self.PresetDump[18132] = {683,684}
        self.PresetDump[18142] = {685,686}
        self.PresetDump[18152] = {687,688}
        self.PresetDump[18162] = {689,690}
        self.PresetDump[18172] = {691,692}
        self.PresetDump[18182] = {693,694}
        self.PresetDump[18192] = {695,696}
        self.PresetDump[18202] = {697,698}
        self.PresetDump[18212] = {699,700}
        self.PresetDump[18222] = {701,702}
        self.PresetDump[18232] = {703,704}
        self.PresetDump[18242] = {705,706}
        self.PresetDump[18252] = {707,708}
        self.PresetDump[18262] = {709,710}
        self.PresetDump[18272] = {711,712}
        self.PresetDump[18282] = {713,714}
        self.PresetDump[18292] = {715,716}
        self.PresetDump[18302] = {717,718}
        self.PresetDump[18312] = {719,720}
        self.PresetDump[18332] = {721,722}
        self.PresetDump[18342] = {723,724}
        self.PresetDump[19202] = {725,726}
        self.PresetDump[19212] = {727,728}
        self.PresetDump[19222] = {729,730}
        self.PresetDump[19232] = {731,732}
        self.PresetDump[19242] = {733,734}
        self.PresetDump[19252] = {735,736}
        self.PresetDump[19262] = {737,738}
        self.PresetDump[19272] = {739,740}
        self.PresetDump[19282] = {741,742}
        self.PresetDump[19292] = {743,744}
        self.PresetDump[19302] = {745,746}
        self.PresetDump[19312] = {747,748}
        self.PresetDump[19322] = {749,750}
        self.PresetDump[19332] = {751,752}
        self.PresetDump[19342] = {753,754}
        self.PresetDump[19352] = {755,756}
        self.PresetDump[19362] = {757,758}
        self.PresetDump[19372] = {759,760}
        self.PresetDump[19382] = {761,762}
        self.PresetDump[19392] = {763,764}
        self.PresetDump[19402] = {765,766}
        self.PresetDump[19412] = {767,768}
        self.PresetDump[19422] = {769,770}
        self.PresetDump[19432] = {771,772}
        self.PresetDump[19442] = {773,774}
        self.PresetDump[19452] = {775,776}
        self.PresetDump[19462] = {777,778}
        self.PresetDump[19472] = {779,780}
        self.PresetDump[19482] = {781,782}
        self.PresetDump[19492] = {783,784}
        self.PresetDump[19502] = {785,786}
        self.PresetDump[19512] = {787,788}
        self.PresetDump[19522] = {789,790}
        self.PresetDump[19532] = {791,792}
        self.PresetDump[19542] = {793,794}
        self.PresetDump[19552] = {795,796}
        self.PresetDump[19562] = {797,798}
        self.PresetDump[19572] = {799,800}
        self.PresetDump[19582] = {801,802}
        self.PresetDump[19592] = {803,804}
        self.PresetDump[19602] = {805,806}
        self.PresetDump[19612] = {807,808}
        self.PresetDump[19622] = {809,810}
        self.PresetDump[19632] = {811,812}
        self.PresetDump[19642] = {813,814}
        self.PresetDump[19652] = {815,816}
        self.PresetDump[19662] = {817,818}
        self.PresetDump[19672] = {819,820}
        self.PresetDump[19682] = {821,822}
        self.PresetDump[19692] = {823,824}
        self.PresetDump[19702] = {825,826}
        self.PresetDump[19712] = {827,828}
        self.PresetDump[19722] = {829,830}
        self.PresetDump[19732] = {831,832}
        self.PresetDump[19742] = {833,834}
        self.PresetDump[19752] = {835,836}
        self.PresetDump[19762] = {837,838}
        self.PresetDump[19772] = {839,840}
        self.PresetDump[19782] = {841,842}
        self.PresetDump[19792] = {843,844}
        self.PresetDump[19802] = {845,846}
        self.PresetDump[19812] = {847,848}
        self.PresetDump[19822] = {849,850}
        self.PresetDump[19832] = {851,852}
        self.PresetDump[19842] = {853,854}
        self.PresetDump[19852] = {855,856}
        self.PresetDump[19862] = {857,858}
        self.PresetDump[19872] = {859,860}
        self.PresetDump[19882] = {861,862}
        self.PresetDump[19892] = {863,864}
        self.PresetDump[19902] = {865,866}
        self.PresetDump[19912] = {867,868}
        self.PresetDump[19922] = {869,870}
        self.PresetDump[14093] = {871,872}
        self.PresetDump[14103] = {873,874}
        self.PresetDump[14113] = {875,876}
        self.PresetDump[14123] = {877,878}
        self.PresetDump[14133] = {879,880}
        self.PresetDump[14143] = {881,882}
        self.PresetDump[14153] = {883,884}
        self.PresetDump[14163] = {885,886}
        self.PresetDump[14173] = {887,888}
        self.PresetDump[14183] = {889,890}
        self.PresetDump[14193] = {891,892}
        self.PresetDump[14203] = {893,894}
        self.PresetDump[14213] = {895,896}
        self.PresetDump[14223] = {897,898}
        self.PresetDump[14233] = {899,900}
        self.PresetDump[14243] = {901,902}
        self.PresetDump[14253] = {903,904}
        self.PresetDump[14263] = {905,906}
        self.PresetDump[14273] = {907,908}
        self.PresetDump[14283] = {909,910}
        self.PresetDump[14293] = {911,912}
        self.PresetDump[14303] = {913,914}
        self.PresetDump[14313] = {915,916}
        self.PresetDump[14323] = {917,918}
        self.PresetDump[14333] = {919,920}
        self.PresetDump[14343] = {921,922}
        self.PresetDump[14353] = {923,924}
        self.PresetDump[14363] = {925,926}
        self.PresetDump[14373] = {927,928}
        self.PresetDump[14383] = {929,930}
        self.PresetDump[14393] = {931,932}
        self.PresetDump[15373] = {933,934}
        self.PresetDump[15383] = {935,936}
        self.PresetDump[15393] = {937,938}
        self.PresetDump[16653] = {939,940}
        self.PresetDump[16663] = {941,942}
        self.PresetDump[16673] = {943,944}
        self.PresetDump[16683] = {945,946}
        self.PresetDump[16693] = {947,948}
        self.PresetDump[16703] = {949,950}
        self.PresetDump[16713] = {951,952}
        self.PresetDump[16723] = {953,954}
        self.PresetDump[16733] = {955,956}
        self.PresetDump[16743] = {957,958}
        self.PresetDump[17933] = {959,960}
        self.PresetDump[17943] = {961,962}
        self.PresetDump[17953] = {963,964}
        self.PresetDump[17963] = {965,966}
        self.PresetDump[17973] = {967,968}
        self.PresetDump[17983] = {969,970}
        self.PresetDump[17993] = {971,972}
        self.PresetDump[18003] = {973,974}
        self.PresetDump[18013] = {975,976}
        self.PresetDump[18023] = {977,978}
        self.PresetDump[18033] = {979,980}
        self.PresetDump[18043] = {981,982}
        self.PresetDump[18053] = {983,984}
        self.PresetDump[18063] = {985,986}
        self.PresetDump[18073] = {987,988}
        self.PresetDump[18083] = {989,990}
        self.PresetDump[18093] = {991,992}
        self.PresetDump[18103] = {993,994}
        self.PresetDump[18113] = {995,996}
        self.PresetDump[18123] = {997,998}
        self.PresetDump[18133] = {999,1000}
        self.PresetDump[18143] = {1001,1002}
        self.PresetDump[18153] = {1003,1004}
        self.PresetDump[18163] = {1005,1006}
        self.PresetDump[18173] = {1007,1008}
        self.PresetDump[18183] = {1009,1010}
        self.PresetDump[18193] = {1011,1012}
        self.PresetDump[18203] = {1013,1014}
        self.PresetDump[18213] = {1015,1016}
        self.PresetDump[18223] = {1017,1018}
        self.PresetDump[18233] = {1019,1020}
        self.PresetDump[18243] = {1021,1022}
        self.PresetDump[18253] = {1023,1024}
        self.PresetDump[18263] = {1025,1026}
        self.PresetDump[18273] = {1027,1028}
        self.PresetDump[18283] = {1029,1030}
        self.PresetDump[18293] = {1031,1032}
        self.PresetDump[18303] = {1033,1034}
        self.PresetDump[18313] = {1035,1036}
        self.PresetDump[18333] = {1037,1038}
        self.PresetDump[18343] = {1039,1040}
        self.PresetDump[19203] = {1041,1042}
        self.PresetDump[19213] = {1043,1044}
        self.PresetDump[19223] = {1045,1046}
        self.PresetDump[19233] = {1047,1048}
        self.PresetDump[19243] = {1049,1050}
        self.PresetDump[19253] = {1051,1052}
        self.PresetDump[19263] = {1053,1054}
        self.PresetDump[19273] = {1055,1056}
        self.PresetDump[19283] = {1057,1058}
        self.PresetDump[19293] = {1059,1060}
        self.PresetDump[19303] = {1061,1062}
        self.PresetDump[19313] = {1063,1064}
        self.PresetDump[19323] = {1065,1066}
        self.PresetDump[19333] = {1067,1068}
        self.PresetDump[19343] = {1069,1070}
        self.PresetDump[19353] = {1071,1072}
        self.PresetDump[19363] = {1073,1074}
        self.PresetDump[19373] = {1075,1076}
        self.PresetDump[19383] = {1077,1078}
        self.PresetDump[19393] = {1079,1080}
        self.PresetDump[19403] = {1081,1082}
        self.PresetDump[19413] = {1083,1084}
        self.PresetDump[19423] = {1085,1086}
        self.PresetDump[19433] = {1087,1088}
        self.PresetDump[19443] = {1089,1090}
        self.PresetDump[19453] = {1091,1092}
        self.PresetDump[19463] = {1093,1094}
        self.PresetDump[19473] = {1095,1096}
        self.PresetDump[19483] = {1097,1098}
        self.PresetDump[19493] = {1099,1100}
        self.PresetDump[19503] = {1101,1102}
        self.PresetDump[19513] = {1103,1104}
        self.PresetDump[19523] = {1105,1106}
        self.PresetDump[19533] = {1107,1108}
        self.PresetDump[19543] = {1109,1110}
        self.PresetDump[19553] = {1111,1112}
        self.PresetDump[19563] = {1113,1114}
        self.PresetDump[19573] = {1115,1116}
        self.PresetDump[19583] = {1117,1118}
        self.PresetDump[19593] = {1119,1120}
        self.PresetDump[19603] = {1121,1122}
        self.PresetDump[19613] = {1123,1124}
        self.PresetDump[19623] = {1125,1126}
        self.PresetDump[19633] = {1127,1128}
        self.PresetDump[19643] = {1129,1130}
        self.PresetDump[19653] = {1131,1132}
        self.PresetDump[19663] = {1133,1134}
        self.PresetDump[19673] = {1135,1136}
        self.PresetDump[19683] = {1137,1138}
        self.PresetDump[19693] = {1139,1140}
        self.PresetDump[19703] = {1141,1142}
        self.PresetDump[19713] = {1143,1144}
        self.PresetDump[19723] = {1145,1146}
        self.PresetDump[19733] = {1147,1148}
        self.PresetDump[19743] = {1149,1150}
        self.PresetDump[19753] = {1151,1152}
        self.PresetDump[19763] = {1153,1154}
        self.PresetDump[19773] = {1155,1156}
        self.PresetDump[19783] = {1157,1158}
        self.PresetDump[19793] = {1159,1160}
        self.PresetDump[19803] = {1161,1162}
        self.PresetDump[19813] = {1163,1164}
        self.PresetDump[19823] = {1165,1166}
        self.PresetDump[19833] = {1167,1168}
        self.PresetDump[19843] = {1169,1170}
        self.PresetDump[19853] = {1171,1172}
        self.PresetDump[19863] = {1173,1174}
        self.PresetDump[19873] = {1175,1176}
        self.PresetDump[19883] = {1177,1178}
        self.PresetDump[19893] = {1179,1180}
        self.PresetDump[19903] = {1181,1182}
        self.PresetDump[19913] = {1183,1184}
        self.PresetDump[19923] = {1185,1186}
        self.PresetDump[14094] = {1187,1188}
        self.PresetDump[14104] = {1189,1190}
        self.PresetDump[14114] = {1191,1192}
        self.PresetDump[14124] = {1193,1194}
        self.PresetDump[14134] = {1195,1196}
        self.PresetDump[14144] = {1197,1198}
        self.PresetDump[14154] = {1199,1200}
        self.PresetDump[14164] = {1201,1202}
        self.PresetDump[14174] = {1203,1204}
        self.PresetDump[14184] = {1205,1206}
        self.PresetDump[14194] = {1207,1208}
        self.PresetDump[14204] = {1209,1210}
        self.PresetDump[14214] = {1211,1212}
        self.PresetDump[14224] = {1213,1214}
        self.PresetDump[14234] = {1215,1216}
        self.PresetDump[14244] = {1217,1218}
        self.PresetDump[14254] = {1219,1220}
        self.PresetDump[14264] = {1221,1222}
        self.PresetDump[14274] = {1223,1224}
        self.PresetDump[14284] = {1225,1226}
        self.PresetDump[14294] = {1227,1228}
        self.PresetDump[14304] = {1229,1230}
        self.PresetDump[14314] = {1231,1232}
        self.PresetDump[14324] = {1233,1234}
        self.PresetDump[14334] = {1235,1236}
        self.PresetDump[14344] = {1237,1238}
        self.PresetDump[14354] = {1239,1240}
        self.PresetDump[14364] = {1241,1242}
        self.PresetDump[14374] = {1243,1244}
        self.PresetDump[14384] = {1245,1246}
        self.PresetDump[14394] = {1247,1248}
        self.PresetDump[15374] = {1249,1250}
        self.PresetDump[15384] = {1251,1252}
        self.PresetDump[15394] = {1253,1254}
        self.PresetDump[16654] = {1255,1256}
        self.PresetDump[16664] = {1257,1258}
        self.PresetDump[16674] = {1259,1260}
        self.PresetDump[16684] = {1261,1262}
        self.PresetDump[16694] = {1263,1264}
        self.PresetDump[16704] = {1265,1266}
        self.PresetDump[16714] = {1267,1268}
        self.PresetDump[16724] = {1269,1270}
        self.PresetDump[16734] = {1271,1272}
        self.PresetDump[16744] = {1273,1274}
        self.PresetDump[17934] = {1275,1276}
        self.PresetDump[17944] = {1277,1278}
        self.PresetDump[17954] = {1279,1280}
        self.PresetDump[17964] = {1281,1282}
        self.PresetDump[17974] = {1283,1284}
        self.PresetDump[17984] = {1285,1286}
        self.PresetDump[17994] = {1287,1288}
        self.PresetDump[18004] = {1289,1290}
        self.PresetDump[18014] = {1291,1292}
        self.PresetDump[18024] = {1293,1294}
        self.PresetDump[18034] = {1295,1296}
        self.PresetDump[18044] = {1297,1298}
        self.PresetDump[18054] = {1299,1300}
        self.PresetDump[18064] = {1301,1302}
        self.PresetDump[18074] = {1303,1304}
        self.PresetDump[18084] = {1305,1306}
        self.PresetDump[18094] = {1307,1308}
        self.PresetDump[18104] = {1309,1310}
        self.PresetDump[18114] = {1311,1312}
        self.PresetDump[18124] = {1313,1314}
        self.PresetDump[18134] = {1315,1316}
        self.PresetDump[18144] = {1317,1318}
        self.PresetDump[18154] = {1319,1320}
        self.PresetDump[18164] = {1321,1322}
        self.PresetDump[18174] = {1323,1324}
        self.PresetDump[18184] = {1325,1326}
        self.PresetDump[18194] = {1327,1328}
        self.PresetDump[18204] = {1329,1330}
        self.PresetDump[18214] = {1331,1332}
        self.PresetDump[18224] = {1333,1334}
        self.PresetDump[18234] = {1335,1336}
        self.PresetDump[18244] = {1337,1338}
        self.PresetDump[18254] = {1339,1340}
        self.PresetDump[18264] = {1341,1342}
        self.PresetDump[18274] = {1343,1344}
        self.PresetDump[18284] = {1345,1346}
        self.PresetDump[18294] = {1347,1348}
        self.PresetDump[18304] = {1349,1350}
        self.PresetDump[18314] = {1351,1352}
        self.PresetDump[18334] = {1353,1354}
        self.PresetDump[18344] = {1355,1356}
        self.PresetDump[19204] = {1357,1358}
        self.PresetDump[19214] = {1359,1360}
        self.PresetDump[19224] = {1361,1362}
        self.PresetDump[19234] = {1363,1364}
        self.PresetDump[19244] = {1365,1366}
        self.PresetDump[19254] = {1367,1368}
        self.PresetDump[19264] = {1369,1370}
        self.PresetDump[19274] = {1371,1372}
        self.PresetDump[19284] = {1373,1374}
        self.PresetDump[19294] = {1375,1376}
        self.PresetDump[19304] = {1377,1378}
        self.PresetDump[19314] = {1379,1380}
        self.PresetDump[19324] = {1381,1382}
        self.PresetDump[19334] = {1383,1384}
        self.PresetDump[19344] = {1385,1386}
        self.PresetDump[19354] = {1387,1388}
        self.PresetDump[19364] = {1389,1390}
        self.PresetDump[19374] = {1391,1392}
        self.PresetDump[19384] = {1393,1394}
        self.PresetDump[19394] = {1395,1396}
        self.PresetDump[19404] = {1397,1398}
        self.PresetDump[19414] = {1399,1400}
        self.PresetDump[19424] = {1401,1402}
        self.PresetDump[19434] = {1403,1404}
        self.PresetDump[19444] = {1405,1406}
        self.PresetDump[19454] = {1407,1408}
        self.PresetDump[19464] = {1409,1410}
        self.PresetDump[19474] = {1411,1412}
        self.PresetDump[19484] = {1413,1414}
        self.PresetDump[19494] = {1415,1416}
        self.PresetDump[19504] = {1417,1418}
        self.PresetDump[19514] = {1419,1420}
        self.PresetDump[19524] = {1421,1422}
        self.PresetDump[19534] = {1423,1424}
        self.PresetDump[19544] = {1425,1426}
        self.PresetDump[19554] = {1427,1428}
        self.PresetDump[19564] = {1429,1430}
        self.PresetDump[19574] = {1431,1432}
        self.PresetDump[19584] = {1433,1434}
        self.PresetDump[19594] = {1435,1436}
        self.PresetDump[19604] = {1437,1438}
        self.PresetDump[19614] = {1439,1440}
        self.PresetDump[19624] = {1441,1442}
        self.PresetDump[19634] = {1443,1444}
        self.PresetDump[19644] = {1445,1446}
        self.PresetDump[19654] = {1447,1448}
        self.PresetDump[19664] = {1449,1450}
        self.PresetDump[19674] = {1451,1452}
        self.PresetDump[19684] = {1453,1454}
        self.PresetDump[19694] = {1455,1456}
        self.PresetDump[19704] = {1457,1458}
        self.PresetDump[19714] = {1459,1460}
        self.PresetDump[19724] = {1461,1462}
        self.PresetDump[19734] = {1463,1464}
        self.PresetDump[19744] = {1465,1466}
        self.PresetDump[19754] = {1467,1468}
        self.PresetDump[19764] = {1469,1470}
        self.PresetDump[19774] = {1471,1472}
        self.PresetDump[19784] = {1473,1474}
        self.PresetDump[19794] = {1475,1476}
        self.PresetDump[19804] = {1477,1478}
        self.PresetDump[19814] = {1479,1480}
        self.PresetDump[19824] = {1481,1482}
        self.PresetDump[19834] = {1483,1484}
        self.PresetDump[19844] = {1485,1486}
        self.PresetDump[19854] = {1487,1488}
        self.PresetDump[19864] = {1489,1490}
        self.PresetDump[19874] = {1491,1492}
        self.PresetDump[19884] = {1493,1494}
        self.PresetDump[19894] = {1495,1496}
        self.PresetDump[19904] = {1497,1498}
        self.PresetDump[19914] = {1499,1500}
        self.PresetDump[19924] = {1501,1502}
    end

    return self
end


---@class MessageObjects
local MessageObjects = {}
---Table for holding Populated Sysex Messages
---@param o any
---@return MessageObjects
function MessageObjects:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self.DeviceInquiryMessageObject = {}
    self.SetupDumpMessageObject = {}
    self.PresetDumpMessageObject = {}

    return self
end


---@class MessageBuffer
local MessageBuffer = {
    msgSpecs = MessageSpecs:new(),
    du = DataUtils:new(),
    sysexHeader = "",
    command = "",
    subcommand = "",
    messages = {},
    packetCounter = 0,
    totalPackets = 0,
    bytesPerMessage = 0,
    receiveHandler = function() end,
    sendHandler = function() end,

}
---Buffer object for midi communication mitigation
---@param o any
---@return MessageBuffer
function MessageBuffer:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  local du = DataUtils:new()


  ---Send Closed Loop ACK with packet counter
  ---@param counter? integer
  ---@return string
  function self.sendACK(counter)
    -- if no counter provided try using the store one, else 0
    counter = counter or self.packetCounter or 0
    -- fetch ACK template
    local msg = self.msgSpecs.Handshake.ACKClosedLoop
    -- nibblize packet counter
    local counterHex = tostring(du.removeSpaces(du.nibblize14bitToHexString(counter)))
    -- inject nibblized packet counter into the ACK message 'pppp'
    msg = du.replaceDataUsingMask(msg,"pppp",counterHex)
    -- wrap message in sysex control bytes
    msg = self.wrapWithSysexControlBytes(msg)
    -- msg = du.replaceDataUsingMask(MessageSpecs.SysexWrapper,"XX",msg)
    return msg
  end

  ---wrap a string in sysex control bytes
  ---@param message any
  ---@return string message string with sysex header and EOX control bytes
  function self.wrapWithSysexControlBytes(message)
    local status
    -- wrap message in sysex control bytes
    message, status = du.replaceDataUsingMask(MessageSpecs.SysexWrapper,"XX",message)
    print(string.format("STATUS:[%s] MESSAGE:[%s]",status,message))
    return message
  end

  -- TODO: add logic
  function self.isSysexNonRealtime() end
  function self.isSysexUniversal() end
  function self.isValueHexString() end

  return self 
  -- example instantiation
  -- local messageBuffer = MessageBuffer:new()
end


---@class PresetDumpHander
local PresetDumpHandler = {}
--- Manages PresetDumps
---@param o any
---@return PresetDumpHander
function PresetDumpHandler:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    local du = DataUtils:new()
    
    local PresetDumpBuffer = MessageBuffer:new()
    
    ---parse response message to byteTable then create mapped object table from it using MessageContract
    ---@param response string response message
    ---@return table MessageObject table of mapped paramIds -> hex value(s)
    function self.presetDumpResponseParser(response)
        -- clean spaces and remove sysex universal control bytes
        local syxctl = "F0180F0055"
        response = du.cleanSysexUniversalMessage(du.removeSpaces(response), syxctl)
        local byteTable = du.stringToByteTable(response)
        -- use Message Contract to build MessageObject Table mapped {paramid,byte(s)}
        -- same keys used in both tables
        local msgObj = {}
        for k, v in pairs(MessageContracts:new().PresetDump) do
            if (v[1] == v[2]) then
                msgObj[k] = string.format("%s", byteTable[v[1]])
            else
                msgObj[k] = string.format("%s%s", byteTable[v[1]], byteTable[v[2]])
            end
            if (du.isContains(msgObj[k],"nil") ) then 
                print(string.format("ERROR at k[%s] v[%s]",k,v))
            end
        end
        return msgObj
    end

    ---Preset Dump Receiver that accumulates messages, extracts the handshake packet count and returns applicable ACKs
    ---once EOF reveived, save to buffer, clean sysex control bytes, and save to hexString(then to MemoryBlock)
    ---If error enountered, return 'STOP'
    ---@param buffer any MessageBuffer object
    ---@param message string inbound midi message
    ---@return table dump presetDump after aggregating & cleaning
    ---@return string status status message
    function self.presetDumpReceiverHandler(buffer, message)
        -- error checking
        if(message == nil or #message == 0) then return buffer, MessageSpecs.Status.STOP end

        -- strip sysex control bytes from incomming message
        -- check if message is DumpHeader or Dump Segment & change length removed from start accordingly
        -- PresetDumpHeader
        if(du.isStartsWithAtPosition(message, "1001",#MessageSpecs.Headers.BasicHeader+1,true)) then
            message = du.cleanSysexUniversalMessage(message, 
                (#MessageSpecs.Headers.BasicHeader + #MessageSpecs.Headers.PresetDumpHeaderResponse)) 
        -- PresetDump Segment
        elseif (du.isStartsWithAtPosition(message, "1002",#MessageSpecs.Headers.BasicHeader+1,true)) then
            message = du.cleanSysexUniversalMessage(message, 
                (#MessageSpecs.Headers.BasicHeader + #MessageSpecs.Headers.PresetDumpResponse))
        -- EOF, DONE with transmission
        elseif (du.isEndsWith(message,(MessageSpecs.Handshake.EOF .. MessageSpecs.SysexUniversal_EOX))) then
            -- do nothing, just return buffer. no ACK needed
            return buffer, MessageSpecs.Status.DONE
        end

        -- add message to buffer stack
        buffer.messages[#buffer.messages+1] = message
        -- send ack
        buffer.sendACK(buffer.packetCounter)
        -- update packet count
        buffer.packetCounter = buffer.packetCounter + 1
        return buffer, MessageSpecs.Status.DONE
    end

    ---prepare the PresetDump messages for parsing
    ---@param presetDumpTable table table holding RAW preset sysex data
    ---@return string response
    ---@return string statusMessage
    function self.presetDumpResponseHandler(presetDumpTable)
        -- iterate the table, stripping sysex control bytes and any spaces
        -- check for even message length
        local syxctl = "F0180Fid551002pppp" -- +4 for packet numbers




                                    --[[ PresetDumpHeader is 1st message in table ]]
        -- TODO add PresetHeaderResponse Handling
        local presetHeader = presetDumpTable[1]




        -- PresetDump starts at 2nd message in table
        local response = ""
        for i=2,#presetDumpTable do
            -- clean spaces and remove sysex universal control bytes
            response = response .. du.cleanSysexUniversalMessage(du.removeSpaces(presetDumpTable[i]), #syxctl)
            -- check message length is even, abort if not
            if(#response %2 ~= 0) then return "",string.format("response is invalid length [%s]",#response) end
        end

        return response, "Successful compacting of Message Table to single string"
    end

    self.PresetDumpBuffer = {}
    function self.presetDumpBufferHandler()
    end

  return self
  -- local setupDumpHandler = SetupDumpHandler:new()
end


--- @class SetupDumpHandler manages SetupDumps
local SetupDumpHandler = {}

---instantiate a SetupDumpHandler object
---@param o any
---@return SetupDumpHandler SetupDumpHandler
function SetupDumpHandler:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self

    local du = DataUtils:new()

    local PresetDumpBuffer = MessageBuffer:new()

    ---parse response message to byteTable then create mapped object table from it using MessageContract
    ---@param response string response message
    ---@return table MessageObject table of mapped paramIds -> hex value(s)
    function self.setupDumpResponseParser(response)
        -- clean spaces and remove sysex universal control bytes
        local syxctl = "F0180F0055"
        response = du.cleanSysexUniversalMessage(du.removeSpaces(response), syxctl)

        -- scrape response string to byte table with 2 chars per cell
        local byteTable = {}
        local pointer = 1
        for i = 1, (#response / 2) do
            byteTable[i] = string.sub(response, pointer, pointer + 1)
            pointer = pointer + 2
        end

        -- use Message Contract to build MessageObject Table mapped {paramid,byte(s)}
        local msgObj = {}
        for k, v in pairs(MessageContracts:new().SetupDump) do
            if (v[1] == v[2]) then
                msgObj[k] = string.format("%s", byteTable[v[1]])
            else
                msgObj[k] = string.format("%s%s", byteTable[v[1]], byteTable[v[2]])
            end
        end
        return msgObj
    end

    return self
    -- local setupDumpHandler = SetupDumpHandler:new()
end


---@class MessageHandler
local MessageHandler = {}
---Function library table for managing sysex messages
---@param o any
---@return MessageHandler
function MessageHandler:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    -- caches incoming messages/dumps
    -- could be used to hold data so any changes made can be injected in-place without needing to rebuild message from scratch
    local InboundMessageBuffer = {}
    -- caches outgoing messages/dumps
    local OutboundMessageBuffer = {}
    -- utility class instantiated for easy access
    local du = DataUtils:new()

    do -- Preset/ROM/Bank Handling

        ---Send Program Change using CC0,CC32,0xC#(ProgChange)
        -- - Values are nibblized LSB first
        -- - b0 rr rr: ROMID
        -- - b0 bb bb: Bank#
        -- - c0 pp pp: ProgNumber
        ---@param rom integer
        ---@param bank integer
        ---@param prog integer
        ---@param ch integer 1-16
        function self.sendProgramChange(rom,bank,prog,ch)
            ch = ch or 0 -- default to channel 0
            -- b0 00 0e CC0  - rom select
            -- b0 20 00 CC32 - bank select
            -- c0 70 00 PRG  - prog change
        end

        ---send ROMID select request
        -- - Ex: [0102 0A01 0000 F7]
        ---@param romid integer
        function self.sendROMSelect(romid)
            -- build message: 
            -- ParameterSetRequest 0102
            -- build ROMID hexString
            local hexString = du.nibblize14bitToHexString(romid)
        end

        --- send PresetSelect for EditBuffer ( -1 )
        -- - Ex: [0102 0107 7F7F F7]
        function self.sendPresetEditBuffer()
        end

    end

    return self
end



--[[ tests MessageBuffer 
]]
local requestTables = RequestsTable:new()
local msgParser = MessageHandler:new()
local buffer = MessageBuffer:new()
local  responseTable = requestTables.PresetDumpResponse
local presetDumpHander = PresetDumpHandler:new()

-- iterate the PresetDumpResponse table, simulating midi rx/ack
for i=1,8 do
    buffer = presetDumpHander.presetDumpReceiverHandler(buffer,responseTable[i])
end
local responseString = presetDumpHander.presetDumpResponseHandler(buffer.messages)
local byteTable = presetDumpHander.presetDumpResponseParser(responseString)


--[[ tests PresetDump
]]
local requestTables = RequestsTable:new()
-- local msgParser = MessageHandler:new()
local  responseTable = requestTables.PresetDumpResponse
local setupDumpResponse = presetDumpHander.presetDumpResponseHandler(responseTable)
local byteTable2 = presetDumpHander.presetDumpResponseParser(setupDumpResponse)


--[[ tests PresetDumpReceiver handles incomming messages and builds correct reponse message ( same as prefab static string) ]]
local isSuccess = true
for k,v in pairs(byteTable) do
    if(byteTable2[k] ~= byteTable[k]) then
        isSuccess = false
    end
end

print(string.format("Verifying byte tables match: SUCCESS:[%s]",tostring(isSuccess)))


--[[ tests SetupDump 
local requestTables = RequestsTable:new()
local msgParser = MessageParser:new()
local setupDumpResponse = RequestsTable:new().SetupDumpResponse
MessageParser:new().parseSetupDumpResponse(setupDumpResponse)
]]


--[[ debug stop ]]
print("stop")


--[[ test code

    local du = DataUtils:new()
    local dataTable = RequestsTable:new()
    local respTable = dataTable.PresetDumpResponse
-- local dataClean = du.removeSpaces(data)

-- local syx = du.cleanSysexUniversalMessage(data,10)

-- iterate response table, strip spaces, then strip sysex universal control bytes
local syx = {}
for i = 1, #respTable do
    syx[#syx + 1] = du.cleanSysexUniversalMessage(du.removeSpaces(respTable[i]), 10)
end
local respMessage = table.concat(syx)
print(respMessage)
local setupDumpResponse = du.cleanSysexUniversalMessage(du.removeSpaces(dataTable.SetupDumpResponse), 10)


]]--

        -- -- scrape response string to byte table with 2 chars per cell
        -- local byteTable = {}
        -- local pointer = 1
        -- for i = 1, (#response / 2) do
        --     byteTable[i] = string.sub(response, pointer, pointer + 1)
        --     pointer = pointer + 2
        -- end
