local RequestsTable = {}
function RequestsTable:new(o)
    o = o or {}
    setmetatable({}, self)
    self.__index                       = self
    -- identity request
    self.IdentityRequest               = "F07E000601F7"
    self.IdentityResponse              = "F07E0006021804040D00322E3030F7"
    self.HardwareConfigurationRequest  = "F0180F00550AF7"
    self.HardwareConfigurationResponse = "F0180F00550902000401060E0000043B09F7"
    self.PresetDumpResponse            = {}
    self.PresetDumpAck                 = {}
    self.PresetDumpResponse[1]         = "F0180F0055 10 0164005E0B0000380013001000140004001F0003000A002A0048000000F7"
    self.PresetDumpAck[1]              = "F0180F0055 7F 0000 F7"
    self.PresetDumpResponse[2]         =
    "F0180F0055 10 0201006869743A44616E6365203231202020207F000000000000000000500000003C0000001E00000000003C0004000E0000002E00620064002F00630064000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F000000070021000A00000001000100070000000000000000000000000000007F007F7F0E00000001002800600000000A000000000001000000030000000A0000000000000000007F7F000000000000000000007F0000007F007F7F000000000000000000007F0000007F000E000E00650400005EF7"
    self.PresetDumpAck[2]              = "F0180F0055 7F 0100 F7"
    self.PresetDumpResponse[3]         =
    "F0180F0055 10 02020000000000000000007F000000000000007F000000000000007F000000000000002600000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C003800000029001DF7"
    self.PresetDumpAck[3]              = "F0180F0055 7F 0200 F7"
    self.PresetDumpResponse[4]         =
    "F0180F0055 10 020300330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000006F7"
    self.PresetDumpAck[4]              = "F0180F0055 7F 0300 F7"
    self.PresetDumpResponse[5]         =
    "F0180F0055 10 02040014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F000000000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F01000000000001000100000064000000640059F7"
    self.PresetDumpAck[5]              = "F0180F0055 7F 0400 F7"
    self.PresetDumpResponse[6]         =
    "F0180F0055 10 020500140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068000C006000300000002C00380106002D00300026002D002F0006001600080064000000000000000000000000000000000000000000000000000000000000007F000000000000007F00000052F7"
    self.PresetDumpAck[6]              = "F0180F0055 7F 0500 F7"
    self.PresetDumpResponse[7]         =
    "F0180F0055 10 020600000000007F000000000000000000000000000000020000000000010000000000000000000E0000000000000040000000000000000000677F010000000000010001000000640000006400140000000000640000002300000000000100000064000000640000000000000064000000000000000000010000000000000063001400000000006400000064000000000000000000000014003800640015003900500050003800640020005100447F21005200447F22004900587F23004A00307F24004C00410025004B00307F0C00400000002800310150000C00380000002900330150006800410000002A00350164002B0068003DF7"
    self.PresetDumpAck[7]              = "F0180F0055 7F 0600 F7"
    self.PresetDumpResponse[8]         =
    "F0180F0055 10 0207000C006000300000002C00380106002D00300026002D002F00060016000800640000000000000000000000000000000000000011F7"
    self.PresetDumpAck[8]              = "F0180F0055 7F 0700 F7"
    self.PresetDumpResponse[9]         = "F0180F0055 7B F7"

    self.SetupDumpResponse             =
    "F0180F00551C1E00230010001500030020000900557365722053657475702020202020200001010000000000020000000100010000000100000002007F7F7F7F0000000000000E0000003E007F7F0100000005000100000000000000010001000200000000004A00470019001A0049004B005500480040004100420011001000010020014E004D001B001C00010003005200530001000000000000000000000000000100000001002800600000000A0014001E000100000003000000000000000000000000000100000000000A00000001000000010000000000000000000000000000007F000000030000000000000000007F7F1F0003017F0040007F7F0000010000000100000001007F0040007F7F0000010000000100000002007F0040007F7F0000010000000100000003007F0040007F7F0000010000000100000004007F0040007F7F0000010000000100000005007F0040007F7F0000010000000100000006007F0040007F7F0000010000000100000007007F0040007F7F0000010000000100000008007F0040007F7F0000010000000100000009007F0040007F7F000001000000010000000A007F0040007F7F000001000000010000000B007F0040007F7F000001000000010000000C007F0040007F7F000001000000010000000D007F0040007F7F000001000000010000000E007F0040007F7F000001000000010000000F007F0040007F7F0000010000000100000010007F0040007F7F0000010000000100000011007F0040007F7F0000010000000100000012007F0040007F7F0000010000000100000013007F0040007F7F0000010000000100000014007F0040007F7F0000010000000100000015007F0040007F7F0000010000000100000016007F0040007F7F0000010000000100000017007F0040007F7F0000010000000100000018007F0040007F7F0000010000000100000019007F0040007F7F000001000000010000001A007F0040007F7F000001000000010000001B007F0040007F7F000001000000010000001C007F0040007F7F000001000000010000001D007F0040007F7F000001000000010000001E007F0040007F7F000001000000010000001F007F0040007F7F00000100000001000000F7"
    self.SetupDumpResponseAck          = {}



    return self
end

local DataUtils = {}
function DataUtils:new(o)
    o = o or {}
    setmetatable({}, self)
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
        function self.ToString(value)
            return tostring(value)
        end

        --- coverts table to delimited string
        --- @param valueTable table table to convert to string
        --- @param separator string separator character
        --- @return string
        function self.TableToStringWithDelimiter(valueTable, separator)
            return table.concat(valueTable, separator)
        end

        --- coverts table to delimited string using separator ","
        --- @param valueTable table
        --- @return string
        function self.TableToString(valueTable)
            return self.TableToStringWithDelimiter(valueTable, ",")
        end

        ---string spaces from a string
        ---@param string string to operate on
        ---@return string result cleaned string
        function self.removeSpaces(string)
            local result = string.gsub(string, " ", "")
            return result
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

    do -- string operations returning data
        --- return substring of haystack by startIndex and field length
        function self.fetchDataUsingPositionAndLength(haystack, pointer, length)
            local last = pointer + length - 1
            return self.fetchDataUsingPositionStartEnd(haystack, pointer, last)
        end

        --- return substring of haystack by startIndex and field length

        ---comment
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

        ---format an integer to hex. Supports :sub() length argument
        --- "%.#"
        --->negative operats from Left>Right.<br/>
        ---+int: returns substring with lenth from start>end index<br/>
        ----int: returns substring with length from end>start
        ---%0#x: padds leading zeros to fill up # posistions
        ---%.#x:
        ---@param value integer value to convert
        ---@param length integer adjusts formatting length.
        ---@return string formattted hexString
        function self.formatValueToHex(value, length)
            if value ~= nil then
                return ""
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

        function self.Int2Hex128(valueInt128)
            return string.format("%2.x", valueInt128)
        end

        function self.Int2Hex2Byte(valueInt256)
            return string.format("%04x", valueInt256)
        end

        function self.Int2Char(value)
            return string.char(value)
        end

        --[[ Nibblize ]]
        --

        function self.nibblize14bit(nibbleInt)
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
            local nibbleTable = self.nibblize14bit(nibbleInt)
            local hexstring = string.format("%s %s", self.formatValueToHex256(nibbleTable.lsb),
                self.formatValueToHex256(nibbleTable.msb))
            local msg = string.format("Nibblized to Hexstring: Value:[%d] MSB:[%d] LSB:[%d] HexString:[%s]",
                nibbleInt, nibbleTable.lsb, nibbleTable.msb, hexstring)
            return hexstring, msg
        end

        --- nibblize a value into msb and lsb
        --- @param value integer to process
        --- @return table return table with msb,lsb
        function self.Nibblize(value)
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
        function self.DeNibblizeLSBMSB(lsb, msb)
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
        function self.DeNibblizeTable(nibble)
            if (#nibble == 2) then
                return self.DeNibblizeLSBMSB(nibble[1], nibble[2])
            else
                return 0
            end
        end
    end


    do -- bin/dec
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
        ---@return integer .return converted decimal number
        function self.bin2decInt(binNum)
            return bin2dec(binNum, 2)
        end
    end

    do -- bool/string
        --- convert boolean to string
        ---@param valueBoolean boolean boolean to parse
        ---@return string . returns 0 if false, 1 if true
        function self.boolToStr(valueBoolean)
            if valueBoolean == true then
                return "1"
            else
                return "0"
            end
        end

        ---convert string to boolean
        ---@param valueString string string to parse
        ---@return boolean . returns true if 1/"true", false if 0/"false"
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
        ---@param msg string - message to parse
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
        ---@param msg string - message to parse
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

        ---check that message is SysexUniversal, trim control bytes if true
        --- if error thrown, return the original message
        --->pattern = string, use string length for substring start
        --->pattern = integer, use value
        ---@param msg string - message to parse and clean
        ---@return string returnMsg return cleaned message
        ---@return string status return status message
        function self.cleanSysexUniversalMessage(msg, pattern)
            local status, returnMsg
            local originalMsg = msg -- save original msg in the event error occurs
            -- if msg = nil, do nothing & return it
            if (msg == nil) then return originalMsg, "NOTHING TODO: msg=nil, nothing to do" end

            -- check if SysexUniversal
            local isSysexUni = self.isSysexUniversal(msg)
            -- print(tostring(isSysexUni))

            -- stip SysexUniversal control bytes
            if (isSysexUni == true) then -- PROCESS MESSAGE
                local datatype = type(pattern)
                if (datatype == "string") then
                    -- if pattern is text
                    msg = string.sub(msg, #pattern + 1 --[[+1 position offset--]], #msg)
                elseif (datatype == "number") then
                    -- if pattern is number
                    msg = string.sub(msg, pattern + 1 --[[+1 position offset--]], #msg)
                end

                msg = string.sub(msg, 1, #msg - 2)
                -- check for something gone wrong
                if (msg == nil) then -- FAIL: if result = nil, assign return message to the orginal
                    status = string.format("Cleaned Message FAILED: original:[%s]", originalMsg)
                    returnMsg = originalMsg
                else -- SUCCESS: assign return msg the cleaned message
                    status = string.format("Cleaned Message: original:[%s] cleaned:[%s]", originalMsg, msg)
                    returnMsg = msg
                end
            else -- NOTHING TO DO: if not msg not SysexUniversal, assign return msg to the original
                status = string.format("msg is not SysexUniversal, nothing to do: [%s]", originalMsg)
                returnMsg = originalMsg
            end

            return returnMsg, status
        end
    end

    return self
end

---@type table
local MessageContracts = {}
---tables holding positions of elements in sysex messages
---@return table MessageContracts an instance of this MessageContract table
function MessageContracts:new()
    setmetatable({}, self)
    self.__index = self

    do -- Setup Dump By Position
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

    return self
end

---@type table MessageParser
local MessageParser = {}

---Function library table for managing sysex messages
---@return table MessageParser
function MessageParser:new()
    setmetatable({}, self)
    self.__index = self
    ---@type table
    local du = DataUtils:new()

    ---parse response message to byteTable then create mapped object table from it using MessageContract
    ---@param response string response message
    ---@return table MessageObject table of mapped paramIds -> hex value(s)
    function self.parseSetupDumpResponse(response)
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
        local MessageObject = {}
        for k, v in pairs(MessageContracts:new().SetupDump) do
            if (v[1] == v[2]) then
                MessageObject[k] = string.format("%s", byteTable[v[1]])
            else
                MessageObject[k] = string.format("%s%s", byteTable[v[1]], byteTable[v[2]])
            end
        end
        return MessageObject
    end

    return self
end



--[[ tests ]] --
local setupDumpResponse = RequestsTable:new().SetupDumpResponse
MessageParser:new().parseSetupDumpResponse(setupDumpResponse)


--[[ debug stop ]]--
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


]]
   --
