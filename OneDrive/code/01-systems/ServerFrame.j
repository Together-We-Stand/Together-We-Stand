/*====================================================================================================
//  ServerFrame   1.12    by  19101994    update  07/20/2017 (mm/dd/yyyy)
//====================================================================================================
//
//  Instal:
//      - Just copy
*/
//! textmacro SF_Instal
        private constant    integer     MAX_CLIENT_ON_A_SERVER  =   32 //default: 32
//! endtextmacro
/*
//
//  Functions:
//      AddFrameAuto(   cframe f,     real delay,     boolean instant  )
//      AddFrame01  (   cframe f,                     boolean instant  )
//      AddFrame02  (   cframe f,                     boolean instant  )
//      AddFrame04  (   cframe f,                     boolean instant  )
//      AddFrame08  (   cframe f,                     boolean instant  )
//      AddFrame16  (   cframe f,                     boolean instant  )
//      AddFrame32  (   cframe f,                     boolean instant  )
//      AddFrame64  (   cframe f,                     boolean instant  )
//
//
//  Demo:
*/
//! novjass
scope test initializer TEST
    struct demo extends cframe
        static method create takes nothing returns thistype
            local thistype this = allocate()
            call AddFrame64(this, true)
            return this
        endmethod
        
        private method update takes real per returns boolean
            return runtime < 30.00
        endmethod
        
        private method end takes nothing returns nothing
            call destroy()
        endmethod
    endstruct
endscope
//! endnovjass
/*
//
//  How to register a client with a new server?
//
*/
//! novjass
scope test initializer TEST
    struct demo extends cframe
        static method create takes nothing returns thistype
            local thistype this = allocate()
            call s.add(this, true)
            return this
        endmethod
        
        private method update takes real per returns boolean
            return runtime < 30.00
        endmethod
        
        private method end takes nothing returns nothing
            call destroy()
        endmethod
        
        private static sframe s
        private static method onInit takes nothing returns nothing
            set s = sframe.create(0.015625000)
        endmethod
    endstruct
endscope
//! endnovjass
/*
//
//  Notes:
//      You shouldn't register a client with a new server!
//
*/

library ServerFrame initializer init requires SFc
    globals
        private sframe Server_1_64
        private sframe Server_1_32
        private sframe Server_1_16
        private sframe Server_1_8
        private sframe Server_1_4
        private sframe Server_1_2
        private sframe Server_1_1
    endglobals
    
    function AddFrameAuto takes cframe f, real delay, boolean instant returns nothing
        if     delay/1.000000000 >= 152.00 then
            call Server_1_1.add(f, instant)
        elseif delay/0.500000000 >= 112.00 then
            call Server_1_2.add(f, instant)
        elseif delay/0.250000000 >= 80.00 then
            call Server_1_4.add(f, instant)
        elseif delay/0.125000000 >= 56.00 then
            call Server_1_8.add(f, instant)
        elseif delay/0.062500000 >= 40.00 then
            call Server_1_16.add(f, instant)
        elseif delay/0.031250000 >= 32.00 then
            call Server_1_32.add(f, instant)
        else
            call Server_1_64.add(f, instant)
        endif
    endfunction
    
    //! textmacro AddFrame_Single takes NAME, NAMEs
    function AddFrame$NAME$ takes cframe f, boolean instant returns nothing
        call Server$NAMEs$.add(f, instant)
    endfunction
    //! endtextmacro
    //! runtextmacro AddFrame_Single ("01", "_1_1")
    //! runtextmacro AddFrame_Single ("02", "_1_2")
    //! runtextmacro AddFrame_Single ("04", "_1_4")
    //! runtextmacro AddFrame_Single ("08", "_1_8")
    //! runtextmacro AddFrame_Single ("16", "_1_16")
    //! runtextmacro AddFrame_Single ("32", "_1_32")
    //! runtextmacro AddFrame_Single ("64", "_1_64")
    
    private function init takes nothing returns nothing
        set Server_1_64     =       sframe.create(0.015625000)
        set Server_1_32     =       sframe.create(0.031250000)
        set Server_1_16     =       sframe.create(0.062500000)
        set Server_1_8      =       sframe.create(0.125000000)
        set Server_1_4      =       sframe.create(0.250000000)
        set Server_1_2      =       sframe.create(0.500000000)
        set Server_1_1      =       sframe.create(1.000000000)
    endfunction
endlibrary

library SFc
    globals
        //! runtextmacro SF_Instal ()
        private constant integer        OFFSET = 0x100000
        private          integer array  data    [8190]
    endglobals
    
    interface cframe
        real runtime = 0
        method update   takes   real    whichFrame  returns boolean defaults    false
        method end      takes   nothing             returns nothing defaults    nothing
    endinterface
    
    struct sframe
        private cframe array frames [MAX_CLIENT_ON_A_SERVER]
        private integer num = 0
        private timer t
        private real per
        
        private thistype next = 0
        
        static method create takes real period returns thistype
            local thistype this = allocate()
            set t = CreateTimer()
            set data[GetHandleId(t) - OFFSET] = this
            set per = period
            return this
        endmethod
        private method onDestroy takes nothing returns nothing
            call DestroyTimer(t)
            set t = null
            call next.destroy()
        endmethod
        
        method add takes cframe f, boolean instant returns nothing
            if num >= MAX_CLIENT_ON_A_SERVER then
                if next == 0 then
                    set next = thistype.create(per)
                endif
                call next.add(f, instant)
                return
            endif
            //
            if num == 0 then
                call TimerStart(t, per, true, function thistype.act)
            endif
            if instant then
                if f.update(per) then
					set frames[num] = f
					set num = num + 1
				else
					call f.end.execute()
					if num == 0 then
                        call PauseTimer(t)
                    endif
				endif
			else
				set frames[num] = f
				set num = num + 1
            endif
        endmethod
        
        private static method act takes nothing returns nothing
            local thistype this = data[GetHandleId(GetExpiredTimer()) - OFFSET]
            local integer i = 0
            loop
                exitwhen i >= num
                set frames[i].runtime = frames[i].runtime + per
                if frames[i].update(per) then
                    set i = i + 1
                else
                    call frames[i].end.execute()
                    set num = num - 1
                    set frames[i] = frames[num]
                    if num == 0 then
                        call PauseTimer(t)
                        return
                    endif
                endif
            endloop
        endmethod
    endstruct
endlibrary