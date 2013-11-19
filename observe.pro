PRO observe, back_r, xuld_r, dur, dt, eff, lc 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Yigit Dallilar          18.11.2013
; 
;  Returns observed light curve.
;
; PURPOSE  
;   - Modelling of light curve observation
;
; INPUT 
;   - back_r    background count rate (real)
;   - xuld_r    XULD count rate
;   - dur       Duration of the observation time in seconds
;   - dt        0.5^dt time resolution of the curve
;
; OUTPUT
;   - lc        light curve array with range of dur*2^dt 
;
; NOTES
;
; PROCEDURES
;   - poissonlc.pro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

back_r=back_r/4
xuld_r=xuld_r/4

poissonlc, back_r, dur, dt, back_lc
poissonlc, xuld_r, dur, dt, xuld_lc
lc = back_lc
lc[where(xuld_lc ne 0)]=lc[where(xuld_lc ne 0)]*eff[0]
lc[1+where(xuld_lc ne 0)]=lc[1+where(xuld_lc ne 0)]*eff[1]
lc[2+where(xuld_lc ne 0)]=lc[2+where(xuld_lc ne 0)]*eff[2]
lc[3+where(xuld_lc ne 0)]=lc[3+where(xuld_lc ne 0)]*eff[3]

poissonlc, back_r, dur, dt, back_lc
poissonlc, xuld_r, dur, dt, xuld_lc
back_lc[where(xuld_lc ne 0)]=back_lc[where(xuld_lc ne 0)]*eff[0]
back_lc[1+where(xuld_lc ne 0)]=back_lc[1+where(xuld_lc ne 0)]*eff[1]
back_lc[2+where(xuld_lc ne 0)]=back_lc[2+where(xuld_lc ne 0)]*eff[2]
back_lc[3+where(xuld_lc ne 0)]=back_lc[3+where(xuld_lc ne 0)]*eff[3]
lc=lc+back_lc

poissonlc, back_r, dur, dt, back_lc
poissonlc, xuld_r, dur, dt, xuld_lc
back_lc[where(xuld_lc ne 0)]=back_lc[where(xuld_lc ne 0)]*eff[0]
back_lc[1+where(xuld_lc ne 0)]=back_lc[1+where(xuld_lc ne 0)]*eff[1]
back_lc[2+where(xuld_lc ne 0)]=back_lc[2+where(xuld_lc ne 0)]*eff[2]
back_lc[3+where(xuld_lc ne 0)]=back_lc[3+where(xuld_lc ne 0)]*eff[3]
lc=lc+back_lc

poissonlc, back_r, dur, dt, back_lc
poissonlc, xuld_r, dur, dt, xuld_lc
back_lc[where(xuld_lc ne 0)]=back_lc[where(xuld_lc ne 0)]*eff[0]
back_lc[1+where(xuld_lc ne 0)]=back_lc[1+where(xuld_lc ne 0)]*eff[1]
back_lc[2+where(xuld_lc ne 0)]=back_lc[2+where(xuld_lc ne 0)]*eff[2]
back_lc[3+where(xuld_lc ne 0)]=back_lc[3+where(xuld_lc ne 0)]*eff[3]
lc=lc+back_lc


END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;