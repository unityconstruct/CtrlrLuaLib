# CtrlrLuaLib
Lua Library targeting the Ctrlr MIDI Environment



## Conventions


### Identifiers
- Global Vars: UPPER_SNAKE_CASE
- Local Vars: pascalCaseName or lower_snake_case
- Global Functions: UpperCamelCase
- Local Functions: lowerCamelCase


### Functions: 

- code outside functions seems to get executed immediately on compile
  - not sure if it will be executed thereafer
  - So only initialization & CONSTANTS seem safe
- function dependencies must be defined in advance




### debug
`pause(message)`


### Patterns


### Classes

```lua

--- @module myproject.myclass
local myclass = {}

-- class table
local MyClass = {}

function MyClass:some_method()
   -- code
end

function MyClass:another_one()
   self:some_method()
   -- more code
end

function myclass.new()
   local self = {}
   setmetatable(self, { __index = MyClass })
   return self
end

return myclass



```