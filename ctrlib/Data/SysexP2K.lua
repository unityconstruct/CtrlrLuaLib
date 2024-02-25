#!/usr/bin/lua
SysexP2K = {}
-- local sysexemu = {}


--[[ DEVICE STATUS ]]--
local DEVICE_ID = 00
local BANK_ID = 00


--[[ SYSEX DEVICE INFO ]]--

local DEVICE_FAMILY = {
    MusicalInstrumentsMSB = 0x04,
    ROMPlayersLSB = 0x04
}

local DEVICE_MEMBERS = {
    Proteus2000SeriesMSB = 0x00,
    Audity2000LSB = 0x02,
    Proteus2000LSB = 0x03,
    B3LSB = 0x04,
    XL1LSB = 0x05,
    Virtuoso2000LSB = 0x06,
    MoPhattLSB = 0x07,
    B3TurboLSB = 0x08,
    XL1TurboLSB = 0x09,
    MoPhattTurboLSB = 0x0A,
    PlanetEarthLSB = 0x0B,
    PlanetEarthTurboLSB = 0x0C,
    XL7LSB = 0x0D,
    MP7LSB = 0x0E,
    Proteus2500LSB = 0x0F,
    Orbit3LSB = 0x10,
    PK6LSB = 0x11,
    XK6LSB = 0x12,
    MK6LSB = 0x13,
    HaloLSB = 0x14,
    Proteus1000LSB = 0x15,
    VintageProLSB = 0x16
}

--[[ ROMS/BANKS ]]--

local ROMS = {
    XL7 = 0x3e,
    USER = 0x00
}

local BANK_SELECT = {
    BANK_CURRENT = ROMS.USER,
    CC0 = "b000",
    CC32 = "00200",
--[[ CC0,CC32,ProgramChange Notes
-- xl7
b0 00 0e -- b0|00 => CC0
b0 20 00 -- b0|20 => CC32
c02 30 0 -- c0|   => Program Change
--
b0 00 0e
b0 20 00
c0 24 00
-- user
b0 00 00
b0 20 00
c0 24 00
-- user patch 64
b0 00 00
b0 20 00
c0 40 00
]]--
}


--[[ data tables ]]--

local SysexPresetDumpSpec = {}
function SysexPresetDumpSpec:new()
    setmetatable({},SysexPresetDumpSpec)
    self.PRESET_NAME_CHAR_0_899 = 1
    self.PRESET_NAME_CHAR_1_900 = 2
    self.PRESET_NAME_CHAR_2_901 = 3
    self.PRESET_NAME_CHAR_3_902 = 4
    self.PRESET_NAME_CHAR_4_903 = 5
    self.PRESET_NAME_CHAR_5_904 = 6
    self.PRESET_NAME_CHAR_6_905 = 7
    self.PRESET_NAME_CHAR_7_906 = 8
    self.PRESET_NAME_CHAR_8_907 = 9
    self.PRESET_NAME_CHAR_9_908 = 10
    self.PRESET_NAME_CHAR_10_909 = 11
    self.PRESET_NAME_CHAR_11_910 = 12
    self.PRESET_NAME_CHAR_12_911 = 13
    self.PRESET_NAME_CHAR_13_912 = 14
    self.PRESET_NAME_CHAR_14_913 = 15
    self.PRESET_NAME_CHAR_15_914 = 16
    self.PRESET_CTRL_A_915 = 17
    self.PRESET_CTRL_B_916 = 19
    self.PRESET_CTRL_C_917 = 21
    self.PRESET_CTRL_D_918 = 23
    self.PRESET_CTRL_E_919 = 25
    self.PRESET_CTRL_F_920 = 27
    self.PRESET_CTRL_G_921 = 29
    self.PRESET_CTRL_H_922 = 31
    self.PRESET_KBD_TUNE_923 = 33
    self.PRESET_CTRL_I_924 = 35
    self.PRESET_CTRL_J_925 = 37
    self.PRESET_CTRL_K_926 = 39
    self.PRESET_CTRL_L_927 = 41
    self.PRESET_CTRL_M_967 = 43
    self.PRESET_CTRL_N_968 = 45
    self.PRESET_CTRL_O_969 = 47
    self.PRESET_CTRL_P_970 = 49
    self.PRESET_RIFF_928 = 51
    self.PRESET_RIFF_ROM_ID_929 = 53
    self.PRESET_TEMPO_OFFSET_930 = 55
    self.PRESET_CORD_0_SOURCE_931 = 57
    self.PRESET_CORD_0_DEST_932 = 59
    self.PRESET_CORD_0_AMOUNT_933 = 61
    self.PRESET_CORD_1_SOURCE_934 = 63
    self.PRESET_CORD_1_DEST_935 = 65
    self.PRESET_CORD_1_AMOUNT_936 = 67
    self.PRESET_CORD_2_SOURCE_937 = 69
    self.PRESET_CORD_2_DEST_938 = 71
    self.PRESET_CORD_2_AMOUNT_939 = 73
    self.PRESET_CORD_3_SOURCE_940 = 75
    self.PRESET_CORD_3_DEST_941 = 77
    self.PRESET_CORD_3_AMOUNT_942 = 79
    self.PRESET_CORD_4_SOURCE_943 = 81
    self.PRESET_CORD_4_DEST_944 = 83
    self.PRESET_CORD_4_AMOUNT_945 = 85
    self.PRESET_CORD_5_SOURCE_946 = 87
    self.PRESET_CORD_5_DEST_947 = 89
    self.PRESET_CORD_5_AMOUNT_948 = 91
    self.PRESET_CORD_6_SOURCE_949 = 93
    self.PRESET_CORD_6_DEST_950 = 95
    self.PRESET_CORD_6_AMOUNT_951 = 97
    self.PRESET_CORD_7_SOURCE_952 = 99
    self.PRESET_CORD_7_DEST_953 = 101
    self.PRESET_CORD_7_AMOUNT_954 = 103
    self.PRESET_CORD_8_SOURCE_955 = 105
    self.PRESET_CORD_8_DEST_956 = 107
    self.PRESET_CORD_8_AMOUNT_957 = 109
    self.PRESET_CORD_9_SOURCE_958 = 111
    self.PRESET_CORD_9_DEST_959 = 113
    self.PRESET_CORD_9_AMOUNT_960 = 115
    self.PRESET_CORD_10_SOURCE_961 = 117
    self.PRESET_CORD_10_DEST_962 = 119
    self.PRESET_CORD_10_AMOUNT_963 = 121
    self.PRESET_CORD_11_SOURCE_964 = 123
    self.PRESET_CORD_11_DEST_965 = 125
    self.PRESET_CORD_11_AMOUNT_966 = 127

end

SysexDeviceInquiryDumpSpec = {}
function SysexDeviceInquiryDumpSpec:new()
    setmetatable({},SysexDeviceInquiryDumpSpec)
    self.SysexDump = {}
    self.isSysexDumpPresent = false
    self.Request = "F07E000601F7"
    self.Response = "F07E00060218ffffddddssssssssF7"

    self.Command = "06"
    self.SubCommandResponse = "02"
    self.SubCommandRequest = "01"

    self.Param_ManufacturersSysexId_Index = 6
    self.Param_DeviceFamilycode_Index = 7
    self.Param_DeviceFamilyMemberCode_Index = 9
    self.Param_DeviceFamilyMemberCode_Index = 11
    self.Param_SoftwareRevisionLevel_Index = 13

    self.Param_ManufacturersSysexId_Size = 1
    self.Param_DeviceFamilycode_Size = 2
    self.Param_DeviceFamilyMemberCode_Size = 2
    self.Param_DeviceFamilyMemberCode_Size = 2
    self.Param_SoftwareRevisionLevel_Size = 4
    self.ManufacturersSysexId = "00"
    self.DeviceFamilycode = "0000"
    self.DeviceFamilyMemberCode = "0000"
    self.DeviceFamilyMemberCode = "0000"
    self.SoftwareRevisionLevel = "00000000"
    return self
end

local function parseDeviceInquiryResponse(sysexDeviceInquiryTable)
    sysexDeviceInquiryTable = sysexDeviceInquiryTable or {}
    local syx = sysexDeviceInquiryTable
    local sysexDeviceInquiry = SysexDeviceInquiryDumpSpec:new()
    local get = ""
    for i=0,sysexDeviceInquiry.Param_ManufacturersSysexId_Size-1,1 do
        get = get .. tostring(syx[sysexDeviceInquiry.Param_ManufacturersSysexId_Index+i])
    end
    sysexDeviceInquiry.SysexDump = syx
    sysexDeviceInquiry.ManufacturersSysexId = get
    -- sysexDeviceInquiry.ManufacturersSysexId = 

    -- if(#sysex % 2 ~= 0) then return {} end -- invalid message length
    -- sysexDeviceInquiry.ManufacturersSysexId = string.sub(
    --     sysex,
    --     sysexDeviceInquiry.Param_ManufacturersSysexId_Index,
    --     (sysexDeviceInquiry.Param_ManufacturersSysexId_Index+sysexDeviceInquiry.Param_ManufacturersSysexId_Size)
    -- )
    -- local dump = {}
    -- for i=1,#sysex,1 do
    --     dump[#dump+1] = 
    -- end
    return sysexDeviceInquiry
end

--[[ sysex dumps ]]--

SysexDeviceConfigurationDump = {}
function SysexDeviceConfigurationDump:new()
    setmetatable({},SysexDeviceConfigurationDump)

    return self
end

--[[ Response Message Spec for 10-1C ]]--
SysexSetupDumpSpec_1C = {}
function SysexSetupDumpSpec_1C:new()
    setmetatable({},SysexSetupDumpSpec_1C)
    self.SOX = 1
    self.EMU_ID = 2
    self.PROTEUS_ID = 3
    self.DEVICE_ID = 4
    self.SPECIAL_DESIGNATOR_BYTE = 5
    self.SYSEX_COMMAND = 6
    self.HEADER_01_Master_General_Params = 7
    self.HEADER_02_Master_MIDI_Params = 9
    self.HEADER_03_Master_Effects_Params = 11
    self.HEADER_04_Reserved_Params = 13
    self.HEADER_05_NonChannel_Params = 15
    self.HEADER_06_MIDI_Channels = 17
    self.HEADER_07_Params_Per_Channel = 19
    self.SETUP_NAME_CHAR0 = 21
    self.SETUP_NAME_CHAR1 = 22
    self.SETUP_NAME_CHAR2 = 23
    self.SETUP_NAME_CHAR3 = 24
    self.SETUP_NAME_CHAR4 = 25
    self.SETUP_NAME_CHAR5 = 26
    self.SETUP_NAME_CHAR6 = 27
    self.SETUP_NAME_CHAR7 = 28
    self.SETUP_NAME_CHAR8 = 29
    self.SETUP_NAME_CHAR9 = 30
    self.SETUP_NAME_CHAR10 = 31
    self.SETUP_NAME_CHAR11 = 32
    self.SETUP_NAME_CHAR12 = 33
    self.SETUP_NAME_CHAR13 = 34
    self.SETUP_NAME_CHAR14 = 35
    self.SETUP_NAME_CHAR15 = 36
    self.MASTER_CLOCK_TEMPO = 37
    self.MASTER_FX_BYPASS = 39
    self.MASTER_TRANSPOSE = 41
    self.MASTER_TUNE = 43
    self.MASTER_BEND_RANGE = 45
    self.MASTER_VEL_CURVE = 47
    self.MASTER_OUTPUT_FORMAT = 49
    self.MASTER_KNOB_EDIT = 51
    self.DEEP_EDIT = 53
    self.EDIT_ALL_LAYERS = 55
    self.MASTER_DEMO_MODE_ENABLE = 57
    self.UNKNOWN_59 = 59
    self.UNKNOWN_61 = 61
    self.UNKNOWN_63 = 63
    self.UNKNOWN_65 = 65
    self.UNKNOWN_67 = 67
    self.UNKNOWN_69 = 69
    self.UNKNOWN_71 = 71
    self.UNKNOWN_73 = 73
    self.UNKNOWN_75 = 75
    self.UNKNOWN_77 = 77
    self.UNKNOWN_79 = 79
    self.UNKNOWN_81 = 81
    self.UNKNOWN_83 = 83
    self.UNKNOWN_85 = 85
    self.UNKNOWN_87 = 87
    self.UNKNOWN_89 = 89
    self.UNKNOWN_91 = 91
    self.UNKNOWN_93 = 93
    self.UNKNOWN_95 = 95
    self.MIDI_MODE = 97
    self.MIDI_MODE_CHANGE = 99
    self.MIDI_ID = 101
    self.MIDI_A_CONTROL = 103
    self.MIDI_B_CONTROL = 105
    self.MIDI_C_CONTROL = 107
    self.MIDI_D_CONTROL = 109
    self.MIDI_E_CONTROL = 111
    self.MIDI_F_CONTROL = 113
    self.MIDI_G_CONTROL = 115
    self.MIDI_H_CONTROL = 117
    self.MIDI_FS1_CONTROL = 119
    self.MIDI_FS2_CONTROL = 121
    self.MIDI_FS3_CONTROL = 123
    self.MIDI_TEMPO_CTRL_UP = 125
    self.MIDI_TEMPO_CTRL_DOWN = 127
    self.MIDI_KNOB_OUT = 129
    self.MIDI_SYSEX_DELAY = 131
    self.MIDI_I_CONTROL = 133
    self.MIDI_J_CONTROL = 135
    self.MIDI_K_CONTROL = 137
    self.MIDI_L_CONTROL = 139
    self.MASTER_MIDI_M_CONTROL = 141
    self.MASTER_MIDI_N_CONTROL = 143
    self.MASTER_MIDI_O_CONTROL = 145
    self.MASTER_MIDI_P_CONTROL = 147
    self.MIDI_KBD_XMIT = 149
    self.MIDI_CLOCK_XMIT = 151
    self.MIDI_MERGE_OUT_A = 153
    self.MIDI_MERGE_OUT_B = 155
    self.MIDI_USE_A_CHANS = 157
    self.MIDI_USE_B_CHANS = 159
    self.MIDI_USE_TRACK_CHAN = 161
    self.MIDI_ALLOW_LOCAL_ON_OFF = 163
    self.UNKNOWN = 165
    self.MASTER_FX_A_ALGORITHM = 167
    self.MASTER_FX_A_DECAY = 169
    self.MASTER_FX_A_HFDAMP = 171
    self.MASTER_FXB_SEND_FXA = 173
    self.MASTER_FX_A_MIX_SEND1 = 175
    self.MASTER_FX_A_MIX_SEND2 = 177
    self.MASTER_FX_A_MIX_SEND3 = 179
    self.MASTER_FX_B_ALGORITHM = 181
    self.MASTER_FX_B_FEEDBACK = 183
    self.MASTER_FX_B_LFO_RATE = 185
    self.MASTER_FX_B_DELAY = 187
    self.MASTER_FX_B_MIX_SEND1 = 189
    self.MASTER_FX_B_MIX_SEND2 = 191
    self.MASTER_FX_B_MIX_SEND3 = 193
    self.MASTER_FX_A_MIX_SEND4 = 195
    self.MASTER_FX_B_MIX_SEND4 = 197
    self.MASTER_ARP_STATUS = 199
    self.MASTER_ARP_MODE = 201
    self.MASTER_ARP_PATTERN = 203
    self.MASTER_ARP_NOTE = 205
    self.MASTER_ARP_VEL = 207
    self.MASTER_ARP_GATE_TIME = 209
    self.MASTER_ARP_EXT_COUNT = 211
    self.MASTER_ARP_EXT_INT = 213
    self.MASTER_ARP_SYNC = 215
    self.MASTER_ARP_PREDELAY = 217
    self.MASTER_ARP_DURATION = 219
    self.MASTER_ARP_RECYCLE = 221
    self.MASTER_ARP_KBD_THRU = 223
    self.MASTER_ARP_LATCH = 225
    self.MASTER_ARP_KR_LOW = 227
    self.MASTER_ARP_KR_HIGH = 229
    self.MASTER_ARP_XMIT_MIDI = 231
    self.MASTER_ARP_SONG_START = 233
    self.MASTER_ARP_PATTERN_SPEED = 235
    self.ARP_POST_DELAY = 237
    self.RESERVED_239 = 239
    self.MULTIMODE_BASIC_CHANNEL = 241
    self.MULTIMODE_FX_CTRL_CHANNEL = 243
    self.MULTIMODE_TEMPO_CTRL_CHAN = 245
    self.CH01_MULTIMODE_PRESET = 247
    self.CH01_MULTIMODE_VOLUME = 249
    self.CH01_MULTIMODE_PAN = 251
    self.CH01_MULTIMODE_MIX_OUTPUT = 253
    self.CH01_MULTIMODE_ARP = 255
    self.CH01_MULTIMODE_CHANNEL_ENABLE = 257
    self.CH01_MULTIMODE_BANK_MAP = 259
    self.CH01_MULTIMODE_RCV_PROG_CHANGE = 261
    self.CH01_ROM_ID = 263
    self.CH02_MULTIMODE_PRESET = 265
    self.CH02_MULTIMODE_VOLUME = 267
    self.CH02_MULTIMODE_PAN = 269
    self.CH02_MULTIMODE_MIX_OUTPUT = 271
    self.CH02_MULTIMODE_ARP = 273
    self.CH02_MULTIMODE_CHANNEL_ENABLE = 275
    self.CH02_MULTIMODE_BANK_MAP = 277
    self.CH02_MULTIMODE_RCV_PROG_CHANGE = 279
    self.CH02_ROM_ID = 281
    self.CH03_MULTIMODE_PRESET = 283
    self.CH03_MULTIMODE_VOLUME = 285
    self.CH03_MULTIMODE_PAN = 287
    self.CH03_MULTIMODE_MIX_OUTPUT = 289
    self.CH03_MULTIMODE_ARP = 291
    self.CH03_MULTIMODE_CHANNEL_ENABLE = 293
    self.CH03_MULTIMODE_BANK_MAP = 295
    self.CH03_MULTIMODE_RCV_PROG_CHANGE = 297
    self.CH03_ROM_ID = 299
    self.CH04_MULTIMODE_PRESET = 301
    self.CH04_MULTIMODE_VOLUME = 303
    self.CH04_MULTIMODE_PAN = 305
    self.CH04_MULTIMODE_MIX_OUTPUT = 307
    self.CH04_MULTIMODE_ARP = 309
    self.CH04_MULTIMODE_CHANNEL_ENABLE = 311
    self.CH04_MULTIMODE_BANK_MAP = 313
    self.CH04_MULTIMODE_RCV_PROG_CHANGE = 315
    self.CH04_ROM_ID = 317
    self.CH05_MULTIMODE_PRESET = 319
    self.CH05_MULTIMODE_VOLUME = 321
    self.CH05_MULTIMODE_PAN = 323
    self.CH05_MULTIMODE_MIX_OUTPUT = 325
    self.CH05_MULTIMODE_ARP = 327
    self.CH05_MULTIMODE_CHANNEL_ENABLE = 329
    self.CH05_MULTIMODE_BANK_MAP = 331
    self.CH05_MULTIMODE_RCV_PROG_CHANGE = 333
    self.CH05_ROM_ID = 335
    self.CH06_MULTIMODE_PRESET = 337
    self.CH06_MULTIMODE_VOLUME = 339
    self.CH06_MULTIMODE_PAN = 341
    self.CH06_MULTIMODE_MIX_OUTPUT = 343
    self.CH06_MULTIMODE_ARP = 345
    self.CH06_MULTIMODE_CHANNEL_ENABLE = 347
    self.CH06_MULTIMODE_BANK_MAP = 349
    self.CH06_MULTIMODE_RCV_PROG_CHANGE = 351
    self.CH06_ROM_ID = 353
    self.CH07_MULTIMODE_PRESET = 355
    self.CH07_MULTIMODE_VOLUME = 357
    self.CH07_MULTIMODE_PAN = 359
    self.CH07_MULTIMODE_MIX_OUTPUT = 361
    self.CH07_MULTIMODE_ARP = 363
    self.CH07_MULTIMODE_CHANNEL_ENABLE = 365
    self.CH07_MULTIMODE_BANK_MAP = 367
    self.CH07_MULTIMODE_RCV_PROG_CHANGE = 369
    self.CH07_ROM_ID = 371
    self.CH08_MULTIMODE_PRESET = 373
    self.CH08_MULTIMODE_VOLUME = 375
    self.CH08_MULTIMODE_PAN = 377
    self.CH08_MULTIMODE_MIX_OUTPUT = 379
    self.CH08_MULTIMODE_ARP = 381
    self.CH08_MULTIMODE_CHANNEL_ENABLE = 383
    self.CH08_MULTIMODE_BANK_MAP = 385
    self.CH08_MULTIMODE_RCV_PROG_CHANGE = 387
    self.CH08_ROM_ID = 389
    self.CH09_MULTIMODE_PRESET = 391
    self.CH09_MULTIMODE_VOLUME = 393
    self.CH09_MULTIMODE_PAN = 395
    self.CH09_MULTIMODE_MIX_OUTPUT = 397
    self.CH09_MULTIMODE_ARP = 399
    self.CH09_MULTIMODE_CHANNEL_ENABLE = 401
    self.CH09_MULTIMODE_BANK_MAP = 403
    self.CH09_MULTIMODE_RCV_PROG_CHANGE = 405
    self.CH09_ROM_ID = 407
    self.CH10_MULTIMODE_PRESET = 409
    self.CH10_MULTIMODE_VOLUME = 411
    self.CH10_MULTIMODE_PAN = 413
    self.CH10_MULTIMODE_MIX_OUTPUT = 415
    self.CH10_MULTIMODE_ARP = 417
    self.CH10_MULTIMODE_CHANNEL_ENABLE = 419
    self.CH10_MULTIMODE_BANK_MAP = 421
    self.CH10_MULTIMODE_RCV_PROG_CHANGE = 423
    self.CH10_ROM_ID = 425
    self.CH11_MULTIMODE_PRESET = 427
    self.CH11_MULTIMODE_VOLUME = 429
    self.CH11_MULTIMODE_PAN = 431
    self.CH11_MULTIMODE_MIX_OUTPUT = 433
    self.CH11_MULTIMODE_ARP = 435
    self.CH11_MULTIMODE_CHANNEL_ENABLE = 437
    self.CH11_MULTIMODE_BANK_MAP = 439
    self.CH11_MULTIMODE_RCV_PROG_CHANGE = 441
    self.CH11_ROM_ID = 443
    self.CH12_MULTIMODE_PRESET = 445
    self.CH12_MULTIMODE_VOLUME = 447
    self.CH12_MULTIMODE_PAN = 449
    self.CH12_MULTIMODE_MIX_OUTPUT = 451
    self.CH12_MULTIMODE_ARP = 453
    self.CH12_MULTIMODE_CHANNEL_ENABLE = 455
    self.CH12_MULTIMODE_BANK_MAP = 457
    self.CH12_MULTIMODE_RCV_PROG_CHANGE = 459
    self.CH12_ROM_ID = 461
    self.CH13_MULTIMODE_PRESET = 463
    self.CH13_MULTIMODE_VOLUME = 465
    self.CH13_MULTIMODE_PAN = 467
    self.CH13_MULTIMODE_MIX_OUTPUT = 469
    self.CH13_MULTIMODE_ARP = 471
    self.CH13_MULTIMODE_CHANNEL_ENABLE = 473
    self.CH13_MULTIMODE_BANK_MAP = 475
    self.CH13_MULTIMODE_RCV_PROG_CHANGE = 477
    self.CH13_ROM_ID = 479
    self.CH14_MULTIMODE_PRESET = 481
    self.CH14_MULTIMODE_VOLUME = 483
    self.CH14_MULTIMODE_PAN = 485
    self.CH14_MULTIMODE_MIX_OUTPUT = 487
    self.CH14_MULTIMODE_ARP = 489
    self.CH14_MULTIMODE_CHANNEL_ENABLE = 491
    self.CH14_MULTIMODE_BANK_MAP = 493
    self.CH14_MULTIMODE_RCV_PROG_CHANGE = 495
    self.CH14_ROM_ID = 497
    self.CH15_MULTIMODE_PRESET = 499
    self.CH15_MULTIMODE_VOLUME = 501
    self.CH15_MULTIMODE_PAN = 503
    self.CH15_MULTIMODE_MIX_OUTPUT = 505
    self.CH15_MULTIMODE_ARP = 507
    self.CH15_MULTIMODE_CHANNEL_ENABLE = 509
    self.CH15_MULTIMODE_BANK_MAP = 511
    self.CH15_MULTIMODE_RCV_PROG_CHANGE = 513
    self.CH15_ROM_ID = 515
    self.CH16_MULTIMODE_PRESET = 517
    self.CH16_MULTIMODE_VOLUME = 519
    self.CH16_MULTIMODE_PAN = 521
    self.CH16_MULTIMODE_MIX_OUTPUT = 523
    self.CH16_MULTIMODE_ARP = 525
    self.CH16_MULTIMODE_CHANNEL_ENABLE = 527
    self.CH16_MULTIMODE_BANK_MAP = 529
    self.CH16_MULTIMODE_RCV_PROG_CHANGE = 531
    self.CH16_ROM_ID = 533
    self.CH17_MULTIMODE_PRESET = 535
    self.CH17_MULTIMODE_VOLUME = 537
    self.CH17_MULTIMODE_PAN = 539
    self.CH17_MULTIMODE_MIX_OUTPUT = 541
    self.CH17_MULTIMODE_ARP = 543
    self.CH17_MULTIMODE_CHANNEL_ENABLE = 545
    self.CH17_MULTIMODE_BANK_MAP = 547
    self.CH17_MULTIMODE_RCV_PROG_CHANGE = 549
    self.CH17_ROM_ID = 551
    self.CH18_MULTIMODE_PRESET = 553
    self.CH18_MULTIMODE_VOLUME = 555
    self.CH18_MULTIMODE_PAN = 557
    self.CH18_MULTIMODE_MIX_OUTPUT = 559
    self.CH18_MULTIMODE_ARP = 561
    self.CH18_MULTIMODE_CHANNEL_ENABLE = 563
    self.CH18_MULTIMODE_BANK_MAP = 565
    self.CH18_MULTIMODE_RCV_PROG_CHANGE = 567
    self.CH18_ROM_ID = 569
    self.CH19_MULTIMODE_PRESET = 571
    self.CH19_MULTIMODE_VOLUME = 573
    self.CH19_MULTIMODE_PAN = 575
    self.CH19_MULTIMODE_MIX_OUTPUT = 577
    self.CH19_MULTIMODE_ARP = 579
    self.CH19_MULTIMODE_CHANNEL_ENABLE = 581
    self.CH19_MULTIMODE_BANK_MAP = 583
    self.CH19_MULTIMODE_RCV_PROG_CHANGE = 585
    self.CH19_ROM_ID = 587
    self.CH20_MULTIMODE_PRESET = 589
    self.CH20_MULTIMODE_VOLUME = 591
    self.CH20_MULTIMODE_PAN = 593
    self.CH20_MULTIMODE_MIX_OUTPUT = 595
    self.CH20_MULTIMODE_ARP = 597
    self.CH20_MULTIMODE_CHANNEL_ENABLE = 599
    self.CH20_MULTIMODE_BANK_MAP = 601
    self.CH20_MULTIMODE_RCV_PROG_CHANGE = 603
    self.CH20_ROM_ID = 605
    self.CH21_MULTIMODE_PRESET = 607
    self.CH21_MULTIMODE_VOLUME = 609
    self.CH21_MULTIMODE_PAN = 611
    self.CH21_MULTIMODE_MIX_OUTPUT = 613
    self.CH21_MULTIMODE_ARP = 615
    self.CH21_MULTIMODE_CHANNEL_ENABLE = 617
    self.CH21_MULTIMODE_BANK_MAP = 619
    self.CH21_MULTIMODE_RCV_PROG_CHANGE = 621
    self.CH21_ROM_ID = 623
    self.CH22_MULTIMODE_PRESET = 625
    self.CH22_MULTIMODE_VOLUME = 627
    self.CH22_MULTIMODE_PAN = 629
    self.CH22_MULTIMODE_MIX_OUTPUT = 631
    self.CH22_MULTIMODE_ARP = 633
    self.CH22_MULTIMODE_CHANNEL_ENABLE = 635
    self.CH22_MULTIMODE_BANK_MAP = 637
    self.CH22_MULTIMODE_RCV_PROG_CHANGE = 639
    self.CH22_ROM_ID = 641
    self.CH23_MULTIMODE_PRESET = 643
    self.CH23_MULTIMODE_VOLUME = 645
    self.CH23_MULTIMODE_PAN = 647
    self.CH23_MULTIMODE_MIX_OUTPUT = 649
    self.CH23_MULTIMODE_ARP = 651
    self.CH23_MULTIMODE_CHANNEL_ENABLE = 653
    self.CH23_MULTIMODE_BANK_MAP = 655
    self.CH23_MULTIMODE_RCV_PROG_CHANGE = 657
    self.CH23_ROM_ID = 659
    self.CH24_MULTIMODE_PRESET = 661
    self.CH24_MULTIMODE_VOLUME = 663
    self.CH24_MULTIMODE_PAN = 665
    self.CH24_MULTIMODE_MIX_OUTPUT = 667
    self.CH24_MULTIMODE_ARP = 669
    self.CH24_MULTIMODE_CHANNEL_ENABLE = 671
    self.CH24_MULTIMODE_BANK_MAP = 673
    self.CH24_MULTIMODE_RCV_PROG_CHANGE = 675
    self.CH24_ROM_ID = 677
    self.CH25_MULTIMODE_PRESET = 679
    self.CH25_MULTIMODE_VOLUME = 681
    self.CH25_MULTIMODE_PAN = 683
    self.CH25_MULTIMODE_MIX_OUTPUT = 685
    self.CH25_MULTIMODE_ARP = 687
    self.CH25_MULTIMODE_CHANNEL_ENABLE = 689
    self.CH25_MULTIMODE_BANK_MAP = 691
    self.CH25_MULTIMODE_RCV_PROG_CHANGE = 693
    self.CH25_ROM_ID = 695
    self.CH26_MULTIMODE_PRESET = 697
    self.CH26_MULTIMODE_VOLUME = 699
    self.CH26_MULTIMODE_PAN = 701
    self.CH26_MULTIMODE_MIX_OUTPUT = 703
    self.CH26_MULTIMODE_ARP = 705
    self.CH26_MULTIMODE_CHANNEL_ENABLE = 707
    self.CH26_MULTIMODE_BANK_MAP = 709
    self.CH26_MULTIMODE_RCV_PROG_CHANGE = 711
    self.CH26_ROM_ID = 713
    self.CH27_MULTIMODE_PRESET = 715
    self.CH27_MULTIMODE_VOLUME = 717
    self.CH27_MULTIMODE_PAN = 719
    self.CH27_MULTIMODE_MIX_OUTPUT = 721
    self.CH27_MULTIMODE_ARP = 723
    self.CH27_MULTIMODE_CHANNEL_ENABLE = 725
    self.CH27_MULTIMODE_BANK_MAP = 727
    self.CH27_MULTIMODE_RCV_PROG_CHANGE = 729
    self.CH27_ROM_ID = 731
    self.CH28_MULTIMODE_PRESET = 733
    self.CH28_MULTIMODE_VOLUME = 735
    self.CH28_MULTIMODE_PAN = 737
    self.CH28_MULTIMODE_MIX_OUTPUT = 739
    self.CH28_MULTIMODE_ARP = 741
    self.CH28_MULTIMODE_CHANNEL_ENABLE = 743
    self.CH28_MULTIMODE_BANK_MAP = 745
    self.CH28_MULTIMODE_RCV_PROG_CHANGE = 747
    self.CH28_ROM_ID = 749
    self.CH29_MULTIMODE_PRESET = 751
    self.CH29_MULTIMODE_VOLUME = 753
    self.CH29_MULTIMODE_PAN = 755
    self.CH29_MULTIMODE_MIX_OUTPUT = 757
    self.CH29_MULTIMODE_ARP = 759
    self.CH29_MULTIMODE_CHANNEL_ENABLE = 761
    self.CH29_MULTIMODE_BANK_MAP = 763
    self.CH29_MULTIMODE_RCV_PROG_CHANGE = 765
    self.CH29_ROM_ID = 767
    self.CH30_MULTIMODE_PRESET = 769
    self.CH30_MULTIMODE_VOLUME = 771
    self.CH30_MULTIMODE_PAN = 773
    self.CH30_MULTIMODE_MIX_OUTPUT = 775
    self.CH30_MULTIMODE_ARP = 777
    self.CH30_MULTIMODE_CHANNEL_ENABLE = 779
    self.CH30_MULTIMODE_BANK_MAP = 781
    self.CH30_MULTIMODE_RCV_PROG_CHANGE = 783
    self.CH30_ROM_ID = 785
    self.CH31_MULTIMODE_PRESET = 787
    self.CH31_MULTIMODE_VOLUME = 789
    self.CH31_MULTIMODE_PAN = 791
    self.CH31_MULTIMODE_MIX_OUTPUT = 793
    self.CH31_MULTIMODE_ARP = 795
    self.CH31_MULTIMODE_CHANNEL_ENABLE = 797
    self.CH31_MULTIMODE_BANK_MAP = 799
    self.CH31_MULTIMODE_RCV_PROG_CHANGE = 801
    self.CH31_ROM_ID = 803
    self.CH32_MULTIMODE_PRESET = 805
    self.CH32_MULTIMODE_VOLUME = 807
    self.CH32_MULTIMODE_PAN = 809
    self.CH32_MULTIMODE_MIX_OUTPUT = 811
    self.CH32_MULTIMODE_ARP = 813
    self.CH32_MULTIMODE_CHANNEL_ENABLE = 815
    self.CH32_MULTIMODE_BANK_MAP = 817
    self.CH32_MULTIMODE_RCV_PROG_CHANGE = 819
    self.CH32_ROM_ID = 821
    self.EOX = 823
    return self
end

--[[ ALL DUMPS OBJECT ]]--

SysexDumps = {}
---common object to house ALL data dump tables
---sysex should be parsed a table, with each cell holding one hex value (2chars): ie: 'F7'
---data can then be read using the index as a position locator in the sysex dump
---@return table - table storing all dump tables
function SysexDumps:new()
    setmetatable({},SysexDumps)

    --[[ field notes
        for each dump type, there's 2 fields:
         1. dump data in a table
         2. isDump function to return true if table has data
    ]]--

    --[[ setup ]]--
    self.SysexSetupDump_1C = {}
    self.isSysexSetupDump_1C = function() return #self.SysexSetupDump_1C > 0 end
    self.SysexSetupDumpSpec_1C = SysexSetupDumpSpec_1C:new() -- instantiate the table


    --[[ Sysex non-realtime ]]--
    self.SysexDeviceInquiryDump_0601 = {}
    self.isSysexDeviceInquiryDump_0601 = function() return #self.SysexDeviceInquiryDump_0601 > 0 end
    --[[ sysex parameter ]]--
    self.ParameterValue_0201 = {}
    self.isSysexParameterValue_0201 = function() return #self.ParameterValue_0201 > 0 end
    self.ParameterMinMax_03 = {}
    self.isSysexParameterMinMax_03 = function() return #self.ParameterMinMax_03 > 0 end
    --[[ configuration ]]--
    self.SysexHardwareConfigurationDump_09 = {}
    self.isSysexHardwareConfigurationDump_09 = function() return #self.SysexHardwareConfigurationDump_09 > 0 end
    --[[ sysem name ]]--
    self.SysexGenericNameDump_0B = {}
    self.isSysexGenericNameDump_0B = function() return #self.SysexGenericNameDump_0B > 0 end
    --[[ prest dump closed loop ]]--
    self.SysexPresetDumpHeaderClosedDump_1001 = {}
    self.isSysexPresetDumpHeaderClosedDump_1001 = function() return #self.SysexPresetDumpHeaderClosedDump_1001 > 0 end
    self.SysexPresetDumpMessageClosedDump_1002 = {}
    self.isSysexPresetDumpMessageClosedDump_1002 = function() return #self.SysexPresetDumpMessageClosedDump_1002 > 0 end
    --[[ prest dump open loop ]]--
    self.SysexPresetDumpHeaderOpenDump_1003 = {}
    self.isSysexPresetDumpHeaderOpenDump_1003 = function() return #self.SysexPresetDumpHeaderOpenDump_1003 > 0 end
    self.SysexPresetDumpMessageOpenDump_1004 = {}
    self.isSysexPresetDumpMessageOpenDump_1004 = function() return #self.SysexPresetDumpMessageOpenDump_1004 > 0 end
    --[[ preset common ]]--
    self.SysexPresetCommonParamsDump_1010 = {}
    self.isSysexPresetCommonParamsDump_1010 = function() return #self.SysexPresetCommonParamsDump_1010 > 0 end
    self.SysexPresetCommonGeneralParamsDump_1011 = {}
    self.isSysexPresetCommonGeneralParamsDump_1011 = function() return #self.SysexPresetCommonGeneralParamsDump_1011 > 0 end
    self.SysexPresetCommonArpParamsDump_1012 = {}
    self.isSysexPresetCommonArpParamsDump_1012 = function() return #self.SysexPresetCommonArpParamsDump_1012 > 0 end
    self.SysexPresetCommonEffectsParamsDump_1013 = {}
    self.isSysexPresetCommonEffectsParamsDump_1013 = function() return #self.SysexPresetCommonEffectsParamsDump_1013 > 0 end
    self.SysexPresetCommonLinkParamsDump_1014 = {}
    self.isSysexPresetCommonLinkParamsDump_1014 = function() return #self.SysexPresetCommonLinkParamsDump_1014 > 0 end
    --[[ preset layer ]]--
    self.SysexPresetLayerParametersDump_1020 = {}
    self.isSysexPresetLayerParametersDump_1020 = function() return #self.SysexPresetLayerParametersDump_1020 > 0 end
    self.SysexPresetLayerCommonParamsDump_1021 = {}
    self.isSysexPresetLayerCommonParamsDump_1021 = function() return #self.SysexPresetLayerCommonParamsDump_1021 > 0 end
    self.SysexPresetLayerFilterParamsDump_1022 = {}
    self.isSysexPresetLayerFilterParamsDump_1022 = function() return #self.SysexPresetLayerFilterParamsDump_1022 > 0 end
    self.SysexPresetLayerLFOParamsDump_1023 = {}
    self.isSysexPresetLayerLFOParamsDump_1023 = function() return #self.SysexPresetLayerLFOParamsDump_1023 > 0 end
    self.SysexPresetLayerEnvelopeParamsDump_1024 = {}
    self.isSysexPresetLayerEnvelopeParamsDump_1024 = function() return #self.SysexPresetLayerEnvelopeParamsDump_1024 > 0 end
    self.SysexPresetLayerPatchcordParamsDump_1035 = {}
    self.isSysexPresetLayerPatchcordParamsDump_1035 = function() return #self.SysexPresetLayerPatchcordParamsDump_1035 > 0 end

    --[[ not used 
    -- self.GenericDumpRequest_61000100 = {}
    -- self.PresetDumpRequest = {}
    -- self.isSysexDumpRequest = function() return #self.DumpRequest > 0 end
    ]]--

    return self
end


return {
    SysexDumps = SysexDumps:new()


}