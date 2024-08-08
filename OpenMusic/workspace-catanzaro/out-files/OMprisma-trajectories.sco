;This synthesis process called OMprisma-trajectories started on 2021/05/07 2:11:30

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
f 1001 0 4097 -7     2.0   78.0  2.375   79.0   2.75   78.0  3.125   78.0    3.5   79.0  3.875   78.0   4.25   78.0  4.625   79.0    5.0   78.0  4.625   78.0   4.25   78.0  3.875   79.0    3.5   78.0  3.125   78.0   2.75   79.0  2.375   78.0    2.0   78.0  1.375   79.0   0.75   78.0  0.125   78.0   -0.5   79.0 -1.125   78.0  -1.75   78.0 -2.375   79.0   -3.0   78.0   -3.0   78.0   -3.0   78.0   -3.0   79.0   -3.0   78.0   -3.0   78.0   -3.0  157.0   -3.0   78.0 -2.857   79.0 -2.714   78.0 -2.571   78.0 -2.429   79.0 -2.286   78.0 -2.143  157.0   -2.0  963.0   -2.0
f 1002 0 4097 -7    -2.0   78.0 -1.625   79.0  -1.25   78.0 -0.875   78.0   -0.5   79.0 -0.125   78.0   0.25   78.0  0.625   79.0    1.0   78.0  1.375   78.0   1.75   78.0  2.125   79.0    2.5   78.0  2.875   78.0   3.25   79.0  3.625   78.0    4.0   78.0    4.0   79.0    4.0   78.0    4.0   78.0    4.0   79.0    4.0   78.0    4.0   78.0    4.0   79.0    4.0   78.0 3.4286   78.0 2.8571   78.0 2.2857   79.0 1.7143   78.0 1.1429   78.0 .57143  157.0 0.0000   78.0 -.1429   79.0 -.2857   78.0 -.4286   78.0 -.5714   79.0 -.7143   78.0 -.8571  157.0   -1.0  963.0   -1.0
f 1003 0 4097 -7  0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000  157.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000   78.0 0.0000   79.0 0.0000   78.0 0.0000  157.0 0.0000  963.0 0.0000
f 1004 0 513 -7  0.0000  512.0 0.0000
i1 0.000 5.230 "C:\\USERS\\CHARL\\ONEDRIVE - DESIGN.UFJF.BR\\DOCUMENTOS\\OM - WORKSPACE\\CATANZARO WORKSPACE\\in-files\\africa.aiff" 0.000 1000.000 0.000 1001.000 1002.000 1003.000 2.000 2.000 0.000 1.000 1004.000 


