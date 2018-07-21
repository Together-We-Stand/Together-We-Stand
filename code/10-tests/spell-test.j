scope SpellTest
    globals
        private constant integer SPELL_ID = 'AHtc'
    endglobals
    
    private struct SpellTest extends abi
        private unit caster
        
        private method onDestroy takes nothing returns nothing
            call RemoveUnit(this.caster)
        endmethod
        
        private method end takes nothing returns nothing
            call this.destroy()
        endmethod
        
        private method update takes real period returns boolean
            call BJDebugMsg("runtime: " + R2S(runtime))
            return runtime < 10.00
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
			debug call CreateTestUnit('Hmkg', SPELL_ID, 1)
			debug call RegisterSpellEffectEvent(SPELL_ID, function thistype.run)
        endmethod
    endstruct
endscope