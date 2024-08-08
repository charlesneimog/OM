;This synthesis process called OMprisma-position-continuous started on 2021/05/07 2:08:38

; Global Variables: sr = 44100, kr = 44100, ksmps = 1, nchnls = 2

; Defined by chroma classes:
; LOOKUP-tables *****
; 
; Distance functions
f200 0 513 -7 0 512; no distance attenuation
f201 0 513 -27 0 -6  10 0  512 -75 ; appr. 1.5 db/m exponential rolloff as function of distance
f202 0 32769 -6 -6  640 0  10000 -30 22129 -36 ; approx 6 db/doubledistance inverse square-law rolloff
; 
; Airabsorption functions
f301 0 32769 -6 20048 640 20048 10284 4000 10922 3000 10923 2000 ; approximation of D.Valente's air-absorption curve
f302 0 32769 -25 0 20048 640 20048 32768 2000 ; exponential frequency rolloff as function of distance (100000/distance)
; 
; Time functions
f401 0 4097 -7 0 4096 0.1470588 ; linear function 
; 

; Loaded tables:

; Generated tables:


;------ Lines for event n. 1 --------

f 1000 0 513 -7     1.0  512.0    1.0
f 1001 0 513 -7  0.0000  512.0 0.0000
f 1002 0 513 -7  0.0000  512.0 0.0000
f 1003 0 513 -7  0.0000  512.0 0.0000
f 1004 0 513 -7  0.0000  512.0 0.0000
i1 0.000 5.230 "C:\\USERS\\CHARL\\ONEDRIVE - DESIGN.UFJF.BR\\DOCUMENTOS\\OM - WORKSPACE\\CATANZARO WORKSPACE\\in-files\\africa.aiff" 0.000 1000.000 0.000 1001.000 1002.000 1003.000 0.000 0.000 0.000 1.000 0.000 0.000 1.000 1004.000 0.000 


