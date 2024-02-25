
The original post goes back a bit, but I also wanted to do this and searched for (what seemed like) hours through the source code until I finally found the solution:

```lua
lua function .def("getPanelEditor", &CtrlrPanel::getPanelEditor) in:
https://github.com/RomanKubiak/ctrlr/blob/de28dc3ad3591a5832f1e38ce8adabc9369b1011/Source/Lua/CtrlrLuaPanel.cpp


panel:getPanelEditor():setProperty("uiPanelImageResource","my_replacement_image",true)
```


The original post goes back a bit, but I also wanted to do this and searched for (what seemed like) hours through the source code until I finally found the solution:

lua function .def("getPanelEditor", &CtrlrPanel::getPanelEditor) in:
https://github.com/RomanKubiak/ctrlr/blob/de28dc3ad3591a5832f1e38ce8adabc9369b1011/Source/Lua/CtrlrLuaPanel.cpp


panel:getPanelEditor():setProperty("uiPanelImageResource","my_replacement_image",true)