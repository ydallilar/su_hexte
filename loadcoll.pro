function loadcoll, fl, colname,ext=extension

if (n_params() eq 0) then begin
   print,'USAGE: data = loadcol(infile,colname,[ext=extension])'
   print,' INPUTS:  infile, array of input filenames'
   print,'          colname, string name of column'
   print,'          ext, extension'
   print,' OUTPUTS: data, output array'
   return,0
endif

;
; If we input a single filename instead of an array,
; convert it to an array so it will work in the routine
; that I wrote below
;
sz=size(fl)
if ( sz(0) eq 0 ) then begin
   fl=[fl]
   sz=size(fl)
endif

if (keyword_set(extension) eq 0) then begin
   extension = 1
endif

;
;Read in the data
;
FOR i=0,sz(1)-1 DO BEGIN
   IF (i EQ 0) THEN BEGIN            ; First file only
       ;Open and read the FITS file
       hd=headfits(fl(i),/silent)
       tab=readfits(fl(i),hd,ext=extension,/silent)
            
       data=fits_get(hd,tab,colname)

   ENDIF ELSE BEGIN                  ; All other files
       ;Open and read the FITS file            
       hd=headfits(fl(i))
       tab=readfits(fl(i),hd,ext=extension)
            
       data=[[data],[fits_get(hd,tab,colname)]]

   ENDELSE
ENDFOR


;
; And that should do it
;
;print,'fin'

return,data
end
