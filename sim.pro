PRO sim, back_r, xuld_r, dur, dt, f_dt, times, freq, psd, $
         nsig, $
         pure=vpure,$
         dead=vdead,$
         pow=vpow,min_d=vmin_d,max_d=vmax_d,step=vstep,$
         ndet=vndet,$
         logf=vlogf, high=vhigh,$
         chatty=chatty 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Yigit Dallilar            27.11.2013
;
; Peforms the same observation n times considering options given. For
; each light curve, PSD function is calculated separately. Then mean value
; of the psd function in each discrete frequency is rebinned.  
;
; PURPOSE
;   - Modelling HEXTE ligth curves with dead time events.
;
; INPUT
;   - back_r    Background count rate (real)
;   - xuld_r    XULD count rate
;   - dur       Duration of the observation time in seconds
;   - dt        Time resolution of the curve in us
;   - f_dt      Rebin interval of the light curve in seconds
;   - times     # of observation in PSD 
;
; OPTIONAL INPUTS
;   - ndet      # of detectors included into observation
;
;   - For pure poisson light curve
;   1 :  pure      KEYWORD
;         
;   - For constant deadtime simulation
;   2 :  dead      Constant deadtime
;
;   - For power law distributed cosmic background
;   3 :  pow       Power of the power law distribution
;     :  min_d     Minimum deadtime
;     :  max_d     Maximum deadtime
;     :  step      Step size to calculate distribution
;
;   - Frequency binning options
;     : linf       Linear binning interval (default=0.12)
;     : high       High frequency limit (default=128D0)
;
; OUTPUT
;   - freq     Frequence array
;   - psd      Binned PSD function
;
; PROCEDURES
;   - observe1.pro
;   - freqrebin.pro (exclusive)
;   - randomnumbergenerator_define.pro (exclusive)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  print,'--------------------------------------'
  print,'Background rate :',float(back_r),' cts/s'
  print,'Cosmic ev. rate :',float(xuld_r),' cts/s'
  print,'Duration        :',float(dur),' sec'
  print,'Time Res (inst.):',float(dt),' us'
  print,'Time Res (lc.)  :',float(f_dt*1e3),' msec'
  print,'# of sim        :',times

  IF keyword_set(vpure) THEN BEGIN
     pure=vpure
     print,'Pure poisson curve...'
  ENDIF ELSE pure=0
  IF keyword_set(vdead) THEN BEGIN
     dead=vdead
     print,'Constant deadtime :',vdead,' msec...'
  ENDIF ELSE dead=0
  IF keyword_set(vpow) THEN BEGIN
     pow=vpow 
     print,'Power law deadtime distribution'
     print,'alpha  :',pow
  ENDIF ELSE pow=0
  IF keyword_set(vmin_d) THEN BEGIN
     min_d=vmin_d
     print,'Minimum deadtime :',min_d,' msec...'
  ENDIF ELSE min_d=0
  IF keyword_set(vmax_d) THEN BEGIN
     max_d=vmax_d 
     print,'Maximum deadtime :',max_d,' msec...'
  ENDIF ELSE max_d=0
  IF keyword_set(vstep) THEN BEGIN 
     step=vstep
     print,'Distribution stepping :',step,' msec...'
  ENDIF ELSE step=0
  IF keyword_set(vndet) THEN BEGIN
     ndet=vndet
     print,'# of detectors :',ndet
  ENDIF ELSE ndet=0

  start=systime(1)

  DefSysV, '!RNG', Obj_New('RandomNumberGenerator',systime(1))

  FOR i=0,times DO BEGIN
    
     observe1, back_r, xuld_r, dur, dt, f_dt, !RNG, rblc, psd, $
               pure=pure,$
               dead=dead,$
               pow=pow,min_d=min_d,max_d=max_d,step=step,$
               ndet=ndet,$
               chatty=0
    
     IF i EQ 0 THEN BEGIN
        psd_t=psd
     ENDIF ELSE BEGIN
        psd_t=(psd_t*i+psd)/(i+1)
     ENDELSE

     progressbar,i,times,start,2L

  ENDFOR

  psd_t=psd_t[1:floor(n_elements(psd)*0.5)+1]
  length=floor(n_elements(psd)*0.5)
  f=(findgen(length)+1)/(dur)

  freqrebin,f,psd_t,freq,psd,nsig,osig,logf=0.12,high=128D0

END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
