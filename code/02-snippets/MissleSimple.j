library MissleSimple requires SnippetSimple
    
    struct MissleSimple extends SnippetSimple
        unit missle
        real beginx
        real beginy
        real targetx
        real targety
        real speed
        real d
        real a
        
        static method create takes unit u, unit m, real x1, real y1, real x2, real y2, real s returns thistype
            local thistype this = allocate()
            set caster = u
            set missle = m
            set beginx = x1
            set beginy = y1
            set targetx = x2
            set targety = y2
            set speed = s
            set d = Distance(beginx, beginy, targetx, targety)
            set a = Angle(targetx, targety, beginx, beginy)
            call AddFrame32(this, true)
            set u = null
            set m = null
            return this
        endmethod
        
        private method Update takes real per returns boolean
            if GetWidgetLife(missle) > 0. then
                call PolarProjection(targetx, targety, d, a)
                call SetUnitPosition(missle, Misc_X, Misc_Y)
                call runUpdate(per)
                set d = d - speed
                return d > 0
            endif
            return false
        endmethod
    endstruct
    
endlibrary