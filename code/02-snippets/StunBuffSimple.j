library StunBuffSimple requires SnippetSimple
    
    globals
        private constant integer STUN_ID = 'B001'
    endglobals
    
    struct StunBuffSimple extends SnippetSimple
        private static thistype array manager
        private static integer count = 0
        
        unit target
        effect eft
        real time 
        
        static method create takes unit u, unit ta, real ti, string efx, string attachPoint returns thistype
            local thistype this
            if thistype.isUnitStunning(ta) then
                return 0
            endif
            set this = allocate()
            set manager[count] = this
            set count = count + 1
            set caster = u
            set target = ta
            set time = ti
            set eft = AddSpecialEffectTarget(efx, ta, attachPoint)
            call UnitAddAbility(ta, STUN_ID)
            call PauseUnit(ta, true)
            call AddFrame32(this, false)
            set u = null
            set ta = null
            return this
        endmethod
        
        private method Update takes real per returns boolean
            if GetWidgetLife(target) > 0. then
                call runUpdate(per)
                set time = time - per 
                return time > 0.
            endif
            return false
        endmethod
        
        private method End takes nothing returns nothing
            call PauseUnit(target, false)
            call UnitRemoveAbility(target, STUN_ID)
            call DestroyEffect(eft)
        endmethod
        
        static method isUnitStunning takes unit whichUnit returns boolean
            local integer i = 0
            loop
                exitwhen i >= count
                if manager[i].target == whichUnit then
                    set whichUnit = null
                    return true
                endif
                set i = i + 1
            endloop
            set whichUnit = null
            return false
        endmethod
    endstruct
    
endlibrary