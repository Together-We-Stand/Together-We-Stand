/*====================================================================================================
            M A K E   B Y   1 9 1 0 1 9 9 4
                Update: 3/17/2018
    Instal:
        Just Copy code
    Requires:
        Newgen or X Design
        Warcraft 1.24e+
====================================================================================================
                                    F U N C T I O N S
            GetLocZ                     (real x, real y)                                                -> real
            GetUnitZ                    (unit w)                                                        -> real
            SetUnitZ                    (unit w, real z)                                                -> boolean
            SetUnitPositionEx           (unit u, real x, real y, real z)                                -> boolean
            PolarX                      (real x, real dist, real angle)                                 ->  real
            PolarY                      (real y, real dist, real angle)                                 ->  real
            PolarProjection             (real x, real y, real dist, real angle)
                |___    You can use Misc_X and Misc_Y <=> returns of PolarX and PolarY
            IsPositionPathable          (real x, real y, real z)                                        ->  boolean
            RAbs                        (real)                                                          ->  real
            IAbs                        (integer)                                                       ->  integer
            Distance                    (real x1, real y1, real x2, real y2)                            ->  real
            Angle                       (real x1, real y1, real x2, real y2)                            ->  real
            Fibonacci                   (integer)                                                       ->  integer
            UnitHasItemId               (unit whichUnit, integer itemId)                                ->  boolean
            ParabolZ                    (real distance, real dist_run, real height)                     ->  real
            LineZ                       (real dist_run, real alpha)                                     ->  real
            CircleZ                     (real distance, real dist_run)                                  ->  real
            NUnitInGroup                (group)                                                         ->  integer
            AddGroup                    (group dest, group source)
            RemoveGroup                 (group dest, group source)
constant    ConvertATtoINT              (attacktype)                                                    ->  integer
constant    ConvertDTtoINT              (damagetype)                                                    ->  integer
            GetRectFromCircle           (real x, real y, real aoe returns rect)
            EnumDestructablesInCircle   (real x, real y, real radius, code actionFunc)
            GetMinimumInteger           (integer x, integer LIMIT)
            GetMinimumReal              (real x, real LIMIT)
            GetMaximumInteger           (integer x, integer LIMIT)
            GetMaximumReal              (real x, real LIMIT)
            PauseAllUnits               (boolean pause)
            OpenGate                    (destructable whichGate)
            CloseGate                   (destructable whichGate)
            DestroyGate                 (destructable whichGate)
            CountPlayersInForce         (force whichForce)
            GetUnitLevelFromId          (integer unitid)                                                ->  integer
constant    notI                        (integer)                                                       ->  integer
                |___    1 => 0 and 0 => 1
constant    I2B                         (integer)                                                       ->  boolean
                |___    1 => true and 0 => false
constant    B2I                         (boolean)                                                       ->  integer
                |___    false => 0 and true => 1
            DestroyEffectAfter          (effect a, real time)
            DestroyLightningAfter       (lightning a, real time)
            DestroyGroupAfter           (group a, real time)
            DestroyImageAfter           (image a, real time)
            DestroyTimerAfter           (timer a, real time)
            DestroyTextTagAfter         (texttag a, real time)
            RemoveUnitAfter             (unit a, real time)
            RemoveItemAfter             (item a, real time)
            RemoveLocationAfter         (location a, real time)
            RemoveDestructableAfter     (destructable a, real time)
            RemoveRectAfter             (rect a, real time)
            RemoveRegionAfter           (region a, real time)
            RemoveWeatherEffectAfter    (weathereffect a, real time)
            Round                       (real value, integer level)                                     -> real
            Surd                        (real)                                                          -> real
            KMP_Search                  (string source, string find)                                    -> integer
            Print                       (string msg)
            PrintError                  (string msg)
            IsCharNumber                (string char)                                                   -> boolean
            IsCharString                (string char)                                                   -> boolean
            IsNumber                    (string str)                                                    -> boolean
            IsString                    (string str)                                                    -> boolean
====================================================================================================*/
library Misc initializer init
    
    globals
        public  real                    X      =       0
        public  real                    Y      =       0
                location                FREELOC =       Location(0,0)
                string      array       ASCII           [128]
    endglobals
    
    private function init takes nothing returns nothing
        set ASCII[0] = ""
        set ASCII[1] = ""
        set ASCII[2] = ""
        set ASCII[3] = ""
        set ASCII[4] = ""
        set ASCII[5] = ""
        set ASCII[6] = ""
        set ASCII[7] = ""
        set ASCII[8] = ""
        set ASCII[9] = ""
        set ASCII[10] = ""
        set ASCII[11] = ""
        set ASCII[12] = ""
        set ASCII[13] = ""
        set ASCII[14] = ""
        set ASCII[15] = ""
        set ASCII[16] = ""
        set ASCII[17] = ""
        set ASCII[18] = ""
        set ASCII[19] = ""
        set ASCII[20] = ""
        set ASCII[21] = ""
        set ASCII[22] = ""
        set ASCII[23] = ""
        set ASCII[24] = ""
        set ASCII[25] = ""
        set ASCII[26] = ""
        set ASCII[27] = ""
        set ASCII[28] = ""
        set ASCII[29] = ""
        set ASCII[30] = ""
        set ASCII[31] = ""
        set ASCII[32] = " "
        set ASCII[33] = "!"
        set ASCII[34] = "\""
        set ASCII[35] = "#"
        set ASCII[36] = "$"
        set ASCII[37] = "%"
        set ASCII[38] = "&"
        set ASCII[39] = "'"
        set ASCII[40] = "("
        set ASCII[41] = ")"
        set ASCII[42] = "*"
        set ASCII[43] = "+"
        set ASCII[44] = ","
        set ASCII[45] = "-"
        set ASCII[46] = "."
        set ASCII[47] = "/"
        set ASCII[48] = "0"
        set ASCII[49] = "1"
        set ASCII[50] = "2"
        set ASCII[51] = "3"
        set ASCII[52] = "4"
        set ASCII[53] = "5"
        set ASCII[54] = "6"
        set ASCII[55] = "7"
        set ASCII[56] = "8"
        set ASCII[57] = "9"
        set ASCII[58] = ":"
        set ASCII[59] = ";"
        set ASCII[60] = "<"
        set ASCII[61] = "="
        set ASCII[62] = ">"
        set ASCII[63] = "?"
        set ASCII[64] = "@"
        set ASCII[65] = "A"
        set ASCII[66] = "B"
        set ASCII[67] = "C"
        set ASCII[68] = "D"
        set ASCII[69] = "E"
        set ASCII[70] = "F"
        set ASCII[71] = "G"
        set ASCII[72] = "H"
        set ASCII[73] = "I"
        set ASCII[74] = "J"
        set ASCII[75] = "K"
        set ASCII[76] = "L"
        set ASCII[77] = "M"
        set ASCII[78] = "N"
        set ASCII[79] = "O"
        set ASCII[80] = "P"
        set ASCII[81] = "Q"
        set ASCII[82] = "R"
        set ASCII[83] = "S"
        set ASCII[84] = "T"
        set ASCII[85] = "U"
        set ASCII[86] = "V"
        set ASCII[87] = "W"
        set ASCII[88] = "X"
        set ASCII[89] = "Y"
        set ASCII[90] = "Z"
        set ASCII[91] = "["
        set ASCII[92] = "\\"
        set ASCII[93] = "]"
        set ASCII[94] = "^"
        set ASCII[95] = "_"
        set ASCII[96] = "`"
        set ASCII[97] = "a"
        set ASCII[98] = "b"
        set ASCII[99] = "c"
        set ASCII[100] = "d"
        set ASCII[101] = "e"
        set ASCII[102] = "f"
        set ASCII[103] = "g"
        set ASCII[104] = "h"
        set ASCII[105] = "i"
        set ASCII[106] = "j"
        set ASCII[107] = "k"
        set ASCII[108] = "l"
        set ASCII[109] = "m"
        set ASCII[110] = "n"
        set ASCII[111] = "o"
        set ASCII[112] = "p"
        set ASCII[113] = "q"
        set ASCII[114] = "r"
        set ASCII[115] = "s"
        set ASCII[116] = "t"
        set ASCII[117] = "u"
        set ASCII[118] = "v"
        set ASCII[119] = "w"
        set ASCII[120] = "x"
        set ASCII[121] = "y"
        set ASCII[122] = "z"
        set ASCII[123] = "{"
        set ASCII[124] = "|"
        set ASCII[125] = "}"
        set ASCII[126] = "~"
        set ASCII[127] = ""
    endfunction
    
    function GetLocZ takes real x, real y returns real
        call MoveLocation(FREELOC, x, y)
        return GetLocationZ(FREELOC)
    endfunction
    
    function  GetUnitZ takes unit w returns real
        call MoveLocation(FREELOC, GetWidgetX(w), GetWidgetY(w))
        return GetLocationZ(FREELOC) + GetUnitFlyHeight(w)
    endfunction
    
    function SetUnitZ takes unit w, real z returns boolean
        local real locz = GetLocZ(GetWidgetX(w), GetWidgetY(w))
        if z < locz then
            return false
        endif
        call SetUnitFlyHeight(w, z - locz, 0.00)
        return true
    endfunction
    
    function SetUnitPositionEx takes unit u, real x, real y, real z returns boolean
        local real locz = GetLocZ(x, x)
        if z < locz then
            return false
        endif
        call SetUnitPosition(u, x, y)
        call SetUnitFlyHeight(u, z - locz, 0.00)
        return true
    endfunction
    
/**/function PolarX takes real x, real dist, real angle returns real
        return x + dist*Cos(angle*bj_DEGTORAD)
    endfunction
     
/**/function PolarY takes real y, real dist, real angle returns real
        return y + dist*Sin(angle*bj_DEGTORAD)
    endfunction
    
/**/function PolarProjection takes real x, real y, real dist, real angle returns nothing
        set X = x + dist*Cos(angle*bj_DEGTORAD)
        set Y = y + dist*Sin(angle*bj_DEGTORAD)
    endfunction
    
    //! textmacro Abs takes A, B
/**/function $A$ takes $B$ a returns $B$
        if a < 0 then
            return -a
        endif
        return a
    endfunction
    //! endtextmacro
    //! runtextmacro Abs("RAbs","real")
    //! runtextmacro Abs("IAbs","integer")
    
/**/function Distance takes real x1, real y1, real x2, real y2 returns real
        return SquareRoot((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
    endfunction
    
/**/function Angle takes real x1, real y1, real x2, real y2 returns real
        return Atan2(y2-y1,x2-x1)*bj_RADTODEG
    endfunction
    
/**/function ParabolZ takes real distance, real dist_run, real height returns real
        return ((4*height*dist_run)/distance)*(1-(dist_run/distance))
    endfunction
    
/**/function LineZ takes real dist_run, real alpha returns real
        return Tan(alpha*bj_DEGTORAD)*dist_run
    endfunction
    
/**/function CircleZ takes real distance, real dist_run returns real
        return SquareRoot(((distance/2)*(distance/2))-(RAbs((distance/2)-dist_run)*RAbs((distance/2)-dist_run)))
    endfunction
    
/**/function Fibonacci takes integer n returns integer
        local integer array i
        if n <= 1 then
            return n
        endif
        set i[0] = 0
        set i[1] = 1
        set i[3] = 2
        loop
            set i[2]=i[0]+i[1]
            set i[0]=i[1]
            set i[1]=i[2]
            set i[3]=i[3]+1
            exitwhen i[3]>n
        endloop
        return i[2]
    endfunction
    
/**/function UnitHasItemId takes unit whichUnit, integer itemId returns boolean
        local integer index = 0
        loop
            if GetItemTypeId(UnitItemInSlot(whichUnit, index)) == itemId then
                return true
            endif
            set index = index + 1
            exitwhen index >= 6
        endloop
        set whichUnit = null
        return false
    endfunction
    
/**/function NUnitInGroup takes group g returns integer
        set bj_groupCountUnits = 0
        call ForGroup(g,function CountUnitsInGroupEnum)
        set g = null
        return bj_groupCountUnits
    endfunction
    
/**/function AddGroup takes group dest, group source returns nothing
        set bj_groupAddGroupDest = dest
        call ForGroup(source, function GroupAddGroupEnum)
        set source = null
        set dest = null
    endfunction
    
/**/function RemoveGroup takes group dest, group source returns nothing
        set bj_groupAddGroupDest = dest
        call ForGroup(source, function GroupAddGroupEnum)
        set source = null
        set dest = null
    endfunction
    
/**/constant function ConvertATtoINT takes attacktype at returns integer
        if at == ATTACK_TYPE_HERO then
            return 6
        elseif at == ATTACK_TYPE_MELEE then
            return 1
        elseif at == ATTACK_TYPE_PIERCE then
            return 2
        elseif at == ATTACK_TYPE_SIEGE then
            return 3
        elseif at == ATTACK_TYPE_MAGIC then
            return 4
        elseif at == ATTACK_TYPE_CHAOS then
            return 5
        endif
        return 0 //NORMAL
    endfunction
    
/**/constant function ConvertDTtoINT takes damagetype dt returns integer
        if dt == DAMAGE_TYPE_ACID then
            return 16
        elseif dt == DAMAGE_TYPE_COLD then
            return 9
        elseif dt == DAMAGE_TYPE_DEATH then
            return 18
        elseif dt == DAMAGE_TYPE_DEFENSIVE then
            return 21
        elseif dt == DAMAGE_TYPE_DEMOLITION then
            return 22
        elseif dt == DAMAGE_TYPE_DISEASE then
            return 12
        elseif dt == DAMAGE_TYPE_DIVINE then
            return 13
        elseif dt == DAMAGE_TYPE_ENHANCED then
            return 5
        elseif dt == DAMAGE_TYPE_FIRE then
            return 8
        elseif dt == DAMAGE_TYPE_FORCE then
            return 17
        elseif dt == DAMAGE_TYPE_LIGHTNING then
            return 10
        elseif dt == DAMAGE_TYPE_MAGIC then
            return 14
        elseif dt == DAMAGE_TYPE_MIND then
            return 19
        elseif dt == DAMAGE_TYPE_UNKNOWN then
            return 0
        elseif dt == DAMAGE_TYPE_PLANT then
            return 20
        elseif dt == DAMAGE_TYPE_POISON then
            return 11
        elseif dt == DAMAGE_TYPE_SHADOW_STRIKE then
            return 25
        elseif dt == DAMAGE_TYPE_SLOW_POISON then
            return 23
        elseif dt == DAMAGE_TYPE_SONIC then
            return 15
        elseif dt == DAMAGE_TYPE_SPIRIT_LINK then
            return 24
        elseif dt == DAMAGE_TYPE_UNIVERSAL then
            return 26
        endif
        return 4//NORMAL
    endfunction
    
/**/function GetRectFromCircle takes real x, real y, real aoe returns rect
        return Rect(x - aoe, y - aoe, x + aoe, y + aoe)
    endfunction
    
/**/function EnumDestructablesInCircle takes real x, real y, real radius, code actionFunc returns nothing
        local rect r
        if (radius > 0) then
            set r = GetRectFromCircle(x,y,radius)
            call EnumDestructablesInRect(r,null,actionFunc)
            call RemoveRect(r)
            set r = null
        endif
        set actionFunc = null
    endfunction
    
    //! textmacro Minimum takes A, B, C
    function GetMinimum$A$ takes $B$ returns $C$
        if a < b then
            return a
        endif
        return b
    endfunction
    //! endtextmacro
    //! runtextmacro Minimum ("Integer","integer a, integer b","integer")
    //! runtextmacro Minimum ("Real","real a, real b","real")
    
    //! textmacro Maximum takes A, B, C
    function GetMaximum$A$ takes $B$ returns $C$
        if a > b then
            return a
        endif
        return b
    endfunction
    //! endtextmacro
    //! runtextmacro Maximum ("Integer","integer a, integer b","integer")
    //! runtextmacro Maximum ("Real","real a, real b","real")
    
    function PauseAllUnits takes boolean pause returns nothing
        local group g = CreateGroup()
        local unit f
        call GroupEnumUnitsInRect(g,bj_mapInitialPlayableArea,null)
        loop
            set f = FirstOfGroup(g)
            exitwhen f==null
            call PauseUnit(f,pause)
            call GroupRemoveUnit(g,f)
        endloop
        call DestroyGroup(g)
        set g = null
    endfunction
    
    function OpenGate takes destructable d returns nothing
        call KillDestructable(d)
        call SetDestructableAnimation(d,"death alternate")
        set d=null
    endfunction
    
    function DestroyGate takes destructable d returns nothing
        call KillDestructable(d)
        call SetDestructableAnimation(d,"death")
        set d=null
    endfunction
    
    function CloseGate takes destructable d returns nothing
        call DestructableRestoreLife(d,GetDestructableMaxLife(d),true)
        call SetDestructableAnimation(d,"stand")
        set d=null
    endfunction
    
    function CountPlayersInForce takes force f returns integer
        set bj_forceCountPlayers = 0
        call ForForce(f, function CountPlayersInForceEnum)
        set f = null
        return bj_forceCountPlayers
    endfunction
    
    function GetUnitLevelFromId takes integer unitid returns integer
        local unit u = CreateUnit(Player(15),unitid,0,0,0)
        local integer level = GetUnitLevel(u)
        call RemoveUnit(u)
        set u = null
        return level
    endfunction
    
    constant function notI takes integer i returns integer
        if i==0 then
            return 1
        endif
        return 0
    endfunction
    
    //! textmacro IntAndBool takes A, B, C, D, E, F
    constant function $A$ takes $B$ returns $C$
        if $D$ then
            return $E$
        endif
        return $F$
    endfunction
    //! endtextmacro
    //! runtextmacro IntAndBool ("I2B","integer i","boolean","i==1","true","false")
    //! runtextmacro IntAndBool ("B2I","boolean b","integer","b==false","0","1")
    
    private function destroyeffectafter takes effect a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyEffect(a)
        set a=null
    endfunction
    function DestroyEffectAfter takes effect a, real time returns nothing
        call destroyeffectafter.execute(a,time)
        set a=null
    endfunction
    
    private function removeunitafter takes unit a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveUnit(a)
        set a=null
    endfunction
    function RemoveUnitAfter takes unit a, real time returns nothing
        call removeunitafter.execute(a,time)
        set a=null
    endfunction
    
    private function removeitemafter takes item a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveItem(a)
        set a=null
    endfunction
    function RemoveItemAfter takes item a, real time returns nothing
        call removeitemafter.execute(a,time)
        set a=null
    endfunction
    
    private function destroylightningafter takes lightning a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyLightning(a)
        set a=null
    endfunction
    function DestroyLightningAfter takes lightning a, real time returns nothing
        call destroylightningafter.execute(a,time)
        set a=null
    endfunction
    
    private function removelocationafter takes location a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveLocation(a)
        set a=null
    endfunction
    function RemoveLocationAfter takes location a, real time returns nothing
        call removelocationafter.execute(a,time)
        set a=null
    endfunction
    
    private function removedestructableafter takes destructable a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveDestructable(a)
        set a=null
    endfunction
    function RemoveDestructableAfter takes destructable a, real time returns nothing
        call removedestructableafter.execute(a,time)
        set a=null
    endfunction
    
    private function removerectafter takes rect a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveRect(a)
        set a=null
    endfunction
    function RemoveRectAfter takes rect a, real time returns nothing
        call removerectafter.execute(a,time)
        set a=null
    endfunction
    
    private function removeregionafter takes region a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveRegion(a)
        set a=null
    endfunction
    function RemoveRegionAfter takes region a, real time returns nothing
        call removeregionafter.execute(a,time)
        set a=null
    endfunction
    
    private function removeweathereffectafter takes weathereffect a, real time returns nothing
        call TriggerSleepAction(time)
        call RemoveWeatherEffect(a)
        set a=null
    endfunction
    function RemoveWeatherEffectAfter takes weathereffect a, real time returns nothing
        call removeweathereffectafter.execute(a,time)
        set a=null
    endfunction
    
    private function destroygroupafter takes group a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyGroup(a)
        set a=null
    endfunction
    function DestroyGroupAfter takes group a, real time returns nothing
        call destroygroupafter.execute(a,time)
        set a=null
    endfunction
    
    private function destroyimageafter takes image a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyImage(a)
        set a=null
    endfunction
    function DestroyImageAfter takes image a, real time returns nothing
        call destroyimageafter.execute(a,time)
        set a=null
    endfunction
    
    private function destroytimerafter takes timer a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyTimer(a)
        set a=null
    endfunction
    function DestroyTimerAfter takes timer a, real time returns nothing
        call destroytimerafter.execute(a,time)
        set a=null
    endfunction
    
    private function destroytexttagafter takes texttag a, real time returns nothing
        call TriggerSleepAction(time)
        call DestroyTextTag(a)
        set a=null
    endfunction
    function DestroyTextTagAfter takes texttag a, real time returns nothing
        call destroytexttagafter.execute(a,time)
        set a=null
    endfunction
    
    function IsPositionPathable takes real x, real y, real z returns boolean
        local item it = CreateItem('mort', x, y)
        local real it_x = GetWidgetX(it)
        local real it_y = GetWidgetY(it)
        call RemoveItem(it)
        set it = null
        return x == it_x and y == it_y and GetLocZ(x, y) <= z
    endfunction
    
    function Round takes real value, integer level returns real
        local real a = value * Pow(10., level)
        local real b = I2R(R2I(value * Pow(10., level)))
        if a < b + 0.50000 then
            return b * Pow(10., -level)
        else
            return (b + 1.00000) * Pow(10., -level)
        endif
    endfunction
    
    function Surd takes real value returns real
        return value - R2I(value)
    endfunction
    
    globals
        private integer pos
        private integer array T
    endglobals
    private function KMP_table takes string data, integer len returns nothing
        local integer cnd = 0
        set pos = 2
        set T[0] = -1
        set T[1] = 0
        loop
            exitwhen pos >= len
            if SubString(data, pos - 1, pos) == SubString(data, cnd, cnd + 1) then
                set T[pos] = cnd + 1
                set pos = pos + 1
                set cnd = cnd + 1
            elseif cnd > 0 then
                set cnd = T[cnd]
            else
                set T[pos] = 0
                set pos = pos + 1
            endif
        endloop
    endfunction
    function KMP_Search takes string source, string find returns integer
        local integer m = 0
        local integer i = 0
        local integer lenS = StringLength(source)
        local integer lenF = StringLength(find)
        //
        call KMP_table(find, lenF)
        //
        loop
            exitwhen m + i >= lenS
            if SubString(find, i, i + 1) == SubString(source, m + i, m + i + 1) then
                set i = i + 1
                if i == lenF then
                    return m
                endif
            else
                if T[i] > -1 then
                    set i = T[i]
                    set m = m + i - T[i]
                else
                    set i = 0
                    set m = m + 1
                endif
            endif
        endloop
        return -1
    endfunction
    
    function Print takes string msg returns nothing
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.00, 0.00, 8.00, msg)
    endfunction
    
    function PrintError takes string msg returns nothing
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.52, 0.96, 4.00, msg)
    endfunction
    
    private function interface UnitDamage takes unit whichUnit, unit target, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType returns nothing
    globals
        private unit dg_caster = null
        private real dg_amount = 0
        private boolean dg_attack = true
        private boolean dg_ranged = false
        private attacktype dg_attacktype = null
        private damagetype dg_damagetype = null
        private weapontype dg_weapontype = null
        private UnitDamage dg_action = 0
    endglobals
    private function UnitDamageGroup_Exe takes nothing returns nothing
        local unit e = GetEnumUnit()
        call UnitDamageTarget(dg_caster, e, dg_amount, dg_attack, dg_ranged, dg_attacktype, dg_damagetype, dg_weapontype)
        call dg_action.evaluate(dg_caster, e, dg_amount, dg_attack, dg_ranged, dg_attacktype, dg_damagetype, dg_weapontype)
        set e = null
    endfunction
    function UnitDamageGroup takes unit whichUnit, group g, real amount, boolean attack, boolean ranged, attacktype attackType, damagetype damageType, weapontype weaponType, UnitDamage action returns nothing
        set dg_caster = whichUnit
        set dg_amount = amount
        set dg_attack = attack 
        set dg_ranged = ranged
        set dg_attacktype = attackType
        set dg_damagetype = damageType
        set dg_weapontype = weaponType
        set dg_action = action
        call ForGroup(g, function UnitDamageGroup_Exe)
        set whichUnit = null
        set attackType = null
        set damageType = null
        set weaponType = null
        set g = null
    endfunction
    
    function IsCharNumber takes string s returns boolean
        return s == ASCII[48] or /*
            */ s == ASCII[49] or /*
            */ s == ASCII[50] or /*
            */ s == ASCII[51] or /*
            */ s == ASCII[52] or /*
            */ s == ASCII[53] or /*
            */ s == ASCII[54] or /*
            */ s == ASCII[55] or /*
            */ s == ASCII[56] or /*
            */ s == ASCII[57]
    endfunction
    
    function IsCharString takes string s returns boolean
        return not IsCharNumber(s)
    endfunction
    
    function IsNumber takes string s returns boolean
        local integer i = 0
        local integer j = StringLength(s)
        local string t
        loop
            exitwhen i >= j
            set t = SubString(s, i, i+1)
            if not IsCharNumber(t) then
                return false
            endif
            set i = i + 1
        endloop
        return true
    endfunction
    
    function IsString takes string s returns boolean 
        return not IsNumber(s)
    endfunction 
endlibrary
