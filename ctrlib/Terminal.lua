


--[[
    local paramName = "PRESET_NAME_CHAR_0_899"
    local paramNameStart = "_PRESETNAMECHAR0899"
    local paramNameEnd = "PRESETNAMECHAR0899_"
    getStringStartToMatch(paramName)
    getStringMatchToEnd(paramName)

    local first = findLast(paramName,'_')+1
    if first then
        local last = #paramName
        local result = string.sub(paramName,first,last)
        print(tostring(result))
    end
    
    s='my.string.here.'
    print(findLast(s,"%."))
    print(findLast(s,"e"))
    print(findLast(paramName,'_'))
    print(findLast(paramNameStart,'_'))
    print(findLast(paramNameEnd,'_'))
]]--

--[[

--find last occurence of a search pattern in provided string <br/>
---for subsequent substring operations<br/>
--- from found index to string   end: string.sub(param,FOUND_INDEX+1,#haystack)<br/>
--- from found index to string start: string.sub(param,0,FOUND_INDEX-1)<br/>
--- default needle = '_'
---@param haystack any - value to search
---@param needle any - search term
---@return integer - . return the integer index integer of the last match found, if any. otherwise return 'nil'
function findLast(haystack, needle)
    needle = needle or '_'
    local i=haystack:match(".*"..needle.."()")
    if i==nil then return nil else return i-1 end
end

---Get end of string after LAST occurrence of a search term<br/>
---Used to extract a parameter number from a parameter identifier with the id appended (ie: PARAM_NAME_ID)<br/>
---peforms a find, adds+1 to found index, performs string.substring(haystack,FOUND+1,#haystack)<br/>
--- ex: (ie: PARAM_NAME_ID) => (ie: PARAM_NAME_ [ID])
---@param param any
function getStringMatchToEnd(param,delimeter)
    delimeter = delimeter or '_'
    local first = findLast(param,delimeter)+1
    if first then
        local last = #param
        local result = string.sub(param,first,last)
        print("Result: ["..tostring(result).."]")
    end
end

---Get started of string before LAST occurrence of a search term<br/>
---Used to extract a parameter name from a parameter identifier where its ID is appended after '_' (ie: PARAM_NAME_ID)<br/>
---peforms a find, subtracts '11' to found index, performs string.substring(haystack,0,FOUND-1)<br/>
--- ex: (ie: PARAM_NAME_ID) => (ie: [PARAM_NAME]_ID)
function getStringStartToMatch(param,delimeter)
    delimeter = delimeter or '_'
    local last = findLast(param,delimeter)-1
    if last then
        local first = 0
        local result = string.sub(param,first,last)
        print("Result: ["..tostring(result).."]")
    end
end

getStringStartToMatch(paramName)
getStringMatchToEnd(paramName)
]]--


