scope Tutorial
    globals
        private constant integer SPELL_ID = 'AHtc'
    endglobals
    
    private struct Tutorial extends abi
        private unit caster
        
        private method onDestroy takes nothing returns nothing
            call RemoveUnit(this.caster)
        endmethod
        
        private method end takes nothing returns nothing
            call this.destroy()
        endmethod
        
        private method update takes real period returns boolean
            call BJDebugMsg("update")
            return false
        endmethod
        
        private static method create takes unit whichUnit returns thistype
            local thistype this = allocate()
            set this.caster = whichUnit
            call AddFrame01(this, false)
            return this
        endmethod
        
        private static method run takes nothing returns boolean
            if GetSpellAbilityId() == SPELL_ID then
                call thistype.create(GetTriggerUnit())
            endif
            return false
        endmethod
        
        private static method onInit takes nothing returns nothing
            local trigger t = CreateTrigger()
            local integer i = 0
            loop
                exitwhen i >= 18
                call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST, null)
                set i = i + 1
            endloop
            call TriggerAddCondition(t, function thistype.run)
            set t = null
        endmethod
    endstruct
endscope