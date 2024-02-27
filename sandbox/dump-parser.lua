
local dump = "F0180F00550A010100F7"

local requestTypeEnum = {
    SysexNonRealtime = "F07E",
    Sysex = "F0aa0Fbbcc"
}

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
    if (result == "nil") then return ""
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



--[[ RequestModel holding ALL requests & builder/util functions ]]--

local RequestModel = {}

function RequestModel:new(o)
    o = o or {}
    setmetatable({},self)
    self.__index = self

    --[[ request/response tables]]
    do
        self.ParameterEditRequestCommands = {}
        self.ParameterEditRequestCommands[0] = {"0102aaaabbbb","Mask"}
        self.ParameterEditRequestCommands[1] = {"01","Command"}
        self.ParameterEditRequestCommands[2] = {"02","SubCommand"}
        self.ParameterEditRequestCommands[3] = {"aaaa","ParamId"}
        self.ParameterEditRequestCommands[4] = {"bbbb","ParamValue"}
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
        self.ParameterEditRequest = {}
        self.ParameterEditRequest[0] = {"0102aaaabbbb","Mask"}
        self.ParameterEditRequest[1] = {"01","Command"}
        self.ParameterEditRequest[2] = {"02","SubCommand"}
        self.ParameterEditRequest[3] = {"aaaa","Parameter ID (LSB first)"}
        self.ParameterEditRequest[4] = {"bbbb","Parameter Data"}
        self.ParameterValueRequest = {}
        self.ParameterValueRequest[0] = {"0201aaaa","Mask"}
        self.ParameterValueRequest[1] = {"02","Command"}
        self.ParameterValueRequest[2] = {"01","SubCommand"}
        self.ParameterValueRequest[3] = {"aaaa","Parameter ID (LSB first)"}
        self.ParamMinMaxDefaultValueResponse = {}
        self.ParamMinMaxDefaultValueResponse[0] = {"03aaaabbbbccccddddee","Mask"}
        self.ParamMinMaxDefaultValueResponse[1] = {"03","Command"}
        self.ParamMinMaxDefaultValueResponse[2] = {"aaaa","Parameter ID"}
        self.ParamMinMaxDefaultValueResponse[3] = {"bbbb","Parameter minimum value"}
        self.ParamMinMaxDefaultValueResponse[4] = {"cccc","Parameter maximum value"}
        self.ParamMinMaxDefaultValueResponse[5] = {"dddd","Parameter default value"}
        self.ParamMinMaxDefaultValueResponse[6] = {"ee","Read Only (0 = Read/Write, 1 = Read Only, values above 1 reserved)"}
        self.ParamMinMaxDefaultValueRequest = {}
        self.ParamMinMaxDefaultValueRequest[0] = {"04aaaa","Mask"}
        self.ParamMinMaxDefaultValueRequest[1] = {"04","Command"}
        self.ParamMinMaxDefaultValueRequest[2] = {"aaaa","Parameter ID"}
        self.HardwareConfigurationResponse = {}
        self.HardwareConfigurationResponse[0] = {"09aabbbbccdd[eeeeffffgggg]","Mask"}
        self.HardwareConfigurationResponse[1] = {"09","Command"}
        self.HardwareConfigurationResponse[2] = {"aa","Number of General Information Bytes"}
        self.HardwareConfigurationResponse[3] = {"bbbb","Number of User Presets"}
        self.HardwareConfigurationResponse[4] = {"cc","Number of Simms Installed"}
        self.HardwareConfigurationResponse[5] = {"dd","Number of Information Bytes per Sim"}
        self.HardwareConfigurationResponse[6] = {"eeee","Simm ID"}
        self.HardwareConfigurationResponse[7] = {"ffff","Number of Sim Presets"}
        self.HardwareConfigurationResponse[8] = {"gggg","Number of Sim Instruments"}
        self.HardwareConfigurationRequest = {}
        self.HardwareConfigurationRequest[0] = {"0A","Mask"}
        self.HardwareConfigurationRequest[1] = {"0A","Command"}
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


    --[[ utility methods ]]--

    --- Fetches a substring from HAYSTACK, using a MASK/NEEDLE as a lookup table<br/>
    --- searches MASK for NEED for START, END positions<br/>
    --- returns substring from HAYSTACK of START, END<br/>
    --- <br/>
    --- example: <br/>
    --- local requestSetParameter = {}<br/>
    --- requestSetParameter[0] = "0201aaaabbbb"<br/>
    --- requestSetParameter[1] = {"aaaa","paramname"}<br/>
    --- requestSetParameter[2] = {"bbbb","paramvalue"}<br/>
    --- request = setDataUsingMask(request,requestSetMultiModeRomId[1][1],"0A01")<br/>
    --- ["0201aaaabbbb"] ==> ["02010A01bbbb"]<br/>
    --- @param haystack string source to fetch data
    --- @param mask string indexing string searched for needle to get substring first/last positions in haystack
    --- @param needle string search term for mask
    --- @return string - . return the haystack with replaced values
    self.fetchDataUsingMask = function(haystack,mask,needle)
        local first,last = string.find(mask,needle,1,true)
        local result = string.sub(haystack,first,last)
        local msg = string.format("Search dump:[%s] using mask:[%s] on needle: [%s] Found start:[%d] end:[%d] result:[%s]",haystack,mask,needle,first,last,result)
        print(msg)
        if (result == "nil") then return ""
        else return result
        end
    end

    --- Replaces a needle in a haystack with passed data
    --- @param haystack string - string to operated string replacement on
    --- @param needle string - needle to search for in haystack
    --- @param replaceWithData string - replacees the needle value in the haystack
    --- @return string - . returns the haystack with replacements made
    self.setDataUsingMask = function(haystack,needle,replaceWithData)
        local result = string.gsub(haystack,needle,replaceWithData,1)
        local msg = string.format("Update dump:[%s] replacing:[%s] with data: [%s] result:[%s]",haystack,needle,replaceWithData,result)
        print(msg)
        if (result == "nil") then return ""
        else return haystack -- return the data without changes
        end
    end


    self.buildPaParameterEditRequest = function(paramId,paramValue)
        local result = self.setDataUsingMask(self.ParameterEditRequestCommands[0][1],self.ParameterEditRequestCommands[3][1],paramId)
        result = self.setDataUsingMask(result,self.ParameterEditRequestCommands[4][1],paramValue)
        return result

    end


    self.buildSetMultiModeRomId = function()
        -- local request = self.[0]
        -- request = self.setDataUsingMask(request,requestSetMultiModeRomId[1][1],"0A01")
        -- request = self.setDataUsingMask(request,requestSetMultiModeRomId[2][1],"0101")
        -- print(string.format("Built Request: [%s]",request))
        -- return request
    end
    
    

    return self
end

--[[ tests ]]--


--[[ RequestModel Tests]]
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


local msg = reqModel.buildPaParameterEditRequest("0A01","0109")
print(msg)




--[[ PoC model for creating a request tables that can be used to creat messages or parse responses ]]--



