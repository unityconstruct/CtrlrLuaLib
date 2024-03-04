SysexP3K = {}

--[[ DEVICE STATUS ]]--
local DEVICE_ID = 125
local BANK_ID = 0

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

























function SysexP3K:build()
    setmetatable({},SysexP3K)
    self.SysexPresetDumpSpec = SysexPresetDumpSpec:new()
    self.ROMS = ROMS
    self.DEVICE_FAMILY = DEVICE_FAMILY
    self.DEVICE_MEMBERS = DEVICE_MEMBERS
    self.BANK_SELECT = BANK_SELECT
    self.DEVICE_ID = DEVICE_ID
    self.BANK_ID = BANK_ID

    return self
end

sys = SysexP3K:build()
