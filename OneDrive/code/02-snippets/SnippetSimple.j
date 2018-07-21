library SnippetSimple requires Misc, ServerFrame
    
    private function interface TransferData takes integer data returns nothing
    
    //abstract class (dont create)
    struct SnippetSimple extends cframe
        unit caster
        integer customValue
        
        real interval
        private real interval_r
        
        integer slow
        private integer slow_r
        
        private TransferData OnUpdate
        private TransferData OnEnd
        
        private boolean isStop
        private boolean isDestroy
        private boolean isPause
        private boolean isActive
        
        private static method onInit takes nothing returns nothing
            local thistype this = 1
            loop
                set isActive = false
                set this = this + 1
                exitwhen this >= 8190
            endloop
        endmethod
        
        private static thistype array   alloc_removed
        private static integer          alloc_count
        static method create takes nothing returns thistype
            local thistype this
            set alloc_count = 0
            loop
                set this = allocate()
                exitwhen not isActive
                set alloc_removed[alloc_count] = this
                set alloc_count = alloc_count + 1
            endloop
            loop
                exitwhen alloc_count <= 0
                set alloc_count = alloc_count - 1
                call alloc_removed[alloc_count].destroy()
            endloop
            set caster = null
            set customValue = 0
            set interval = 0.
            set interval_r = 0.
            set slow = 0
            set slow_r = 0
            set OnUpdate = 0
            set OnEnd = 0
            set isStop = false 
            set isDestroy = false
            set isPause = false
            set isActive = true
            return this
        endmethod
        
        private stub method Update takes real per returns boolean
            return false
        endmethod
        private method update takes real per returns boolean
            if isStop or isDestroy then
                return false
            endif
            if isPause then
                return true
            endif
            if slow > 1 then
                set slow_r = slow_r - 1
                if slow_r <= 0 then
                    set slow_r = slow
                else
                    return true
                endif
            endif
            return Update(per)
        endmethod
        
        private stub method End takes nothing returns nothing
        endmethod
        private method end takes nothing returns nothing
            call End()
            call OnEnd.evaluate(this)
            if not isDestroy then
                call destroy()
            else
                set isActive = false
            endif
        endmethod
        
        private method onDestroy takes nothing returns nothing
            if isStop then
                set isActive = false
            endif
            set isStop = true
            set isDestroy = true
        endmethod
        
        method stop takes nothing returns nothing
            set isStop = true
        endmethod
        
        method pause takes nothing returns nothing
            set isPause = true
        endmethod
        
        method resume takes nothing returns nothing
            set isPause = false
        endmethod
        
        method setUpdateInterval takes real per returns nothing
            set interval = per
        endmethod
        
        method setUpdateSlow takes integer times returns nothing
            set slow = times
        endmethod
        
        method runUpdate takes real per returns nothing
            if interval_r <= 0. then
                call OnUpdate.evaluate(this)
                set interval_r = interval_r + interval
            endif
            set interval_r = interval_r - per
        endmethod
        
        method runEnd takes nothing returns nothing
            call OnEnd.evaluate(this)
        endmethod
        
        method operator IsStop takes nothing returns boolean
            return isStop
        endmethod
        
        method operator IsDestroy takes nothing returns boolean
            return isDestroy
        endmethod
        
        method operator IsPause takes nothing returns boolean
            return isPause
        endmethod
        
        method setUpdate takes TransferData func returns nothing
            set OnUpdate = func
        endmethod
        
        method setEnd takes TransferData func returns nothing
            set OnEnd = func
        endmethod
    endstruct
    
endlibrary