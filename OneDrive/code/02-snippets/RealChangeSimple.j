library RealChangeSimple requires SnippetSimple
    
    struct RealChangeSimple extends SnippetSimple
        real value
        real endValue
        real deltaValue
        
        static method create takes unit u, real s, real e, real d returns thistype
            local thistype this = allocate()
            set caster = u
            set value = s
            set endValue = e
            set deltaValue = d
            call AddFrame32(this, false)
            set u = null
            return this
        endmethod
        
        private method Update takes real per returns boolean
            call runUpdate(per)
            set value = value + deltaValue
            if deltaValue > 0. then
                return value < endValue
            endif
            return value > endValue
        endmethod
    endstruct
    
endlibrary