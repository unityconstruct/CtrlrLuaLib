

local NewClass = {}
function NewClass:new(o)
  o = o or {}
  setmetatable({},self)
  self.__index = self
  self.ClassName = "classname"
  local LocalClassName = "localclassname"
  self.SelfLocalClassName = "sefllocalclassname"

  local NewSubClass = {}
  function NewSubClass:new(o)
    o = o or {}
    setmetatable({},self)
    self.__index = self
    self.SubClassName = "subclass"
    local LocalSubClassName = "localsubclassname"
    self.SelfLocalSubClassName = "sefllocalsubclassname"
    local localbasename = LocalClassName
    self.selfbasename = NewClass.SelfLocalClassName
    return self
  end
  
--   self.MyNewSubClass = NewSubClass
  self.MyNewSubClassNew = NewSubClass:new()
  local result = self.MyNewSubClassNew.SubClassName



  return self
end







local newClassColon = NewClass:new()
local result = newClassColon.NewSubClassNew()

local newSubClassColon = newClassColon.NewSubClass:new()






print("stop")