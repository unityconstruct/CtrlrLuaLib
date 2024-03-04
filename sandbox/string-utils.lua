
---search a string for string value
  ---@param haystack any - value to search in
  ---@param needle any - value to search for
  ---@param boolPlain any - true = use 'plain' text search, false = use 'pattern matching'
  ---@return boolean - . return true if needle is found in haystack
  local isStartsWith = function(haystack,needle,boolPlain)
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
  local isEndsWith = function(haystack,needle,boolPlain)
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

--[[ tests ]]--
local result = isEndsWith("aabbcc", "cc", true)
print(tostring(result)) -- true
result = isEndsWith("aabbcc", "bc", true)
print(tostring(result)) -- false
result = isEndsWith("aabbcc", "bcc", true)
print(tostring(result)) -- true
result = isEndsWith("aabbcc", "bbcc", true)
print(tostring(result)) -- true
result = isEndsWith("aabbcc", "bbc", true)
print(tostring(result)) -- false