library TimeSpanSimple requires SnippetSimple
    
    struct TimeSpanSimple extends SnippetSimple
        unit eft
        real time
        
        static method create takes unit u, unit e, real t returns thistype
            local thistype this = allocate()
            set caster = u
            set eft = e
            set time = t
            call AddFrame32(this, false)
            set u = null
            set e = null
            return this
        endmethod
        
        private method Update takes real per returns boolean
            if GetWidgetLife(eft) > 0. then
                call runUpdate(per)
                set time = time - per
                return time > 0
            endif
            return false
        endmethod
    endstruct
    
endlibrary