; HEADER 

sr = 44100
kr = 44100
ksmps = 1
nchnls = 2

; GLOBAL VARIABLES

vbaplsinit   2, 2, -30.000, 30.000


; MACROS

#define vbap_copy_source #
asound1 = asound#
#define vbap_envelopes #
kxpos envelope ixpos_envelope, ixpos_frequency_envelope
kypos envelope iypos_envelope, iypos_frequency_envelope
kzpos envelope izpos_envelope, izpos_frequency_envelope
kspread envelope ispread_envelope, ispread_frequency_envelope#
#define vbap_trajectories #
kxpos trajectory ixpos_envelope, ktrajfrequency
kypos trajectory iypos_envelope, ktrajfrequency
kzpos trajectory izpos_envelope, ktrajfrequency
kspread trajectory ispread_envelope, ktrajfrequency#
#define xyz2aed_discrete #
iazimuth1, ielevation1, idistance1 xyz2aed_discrete ixpos, iypos, izpos#
#define attenuation_discrete #
asound1 attenuation_discrete asound1, idistance1, iattenfunction#
#define airabsorption_discrete #
asound1 airabsorption_discrete asound1, idistance1, iairfunction#
#define timeoftravel_discrete #
asound1 timeoftravel_discrete asound1, idistance1, itimefunction#
#define xyz2aed_continuous #
kazimuth1, kelevation1, kdistance1 xyz2aed_continuous kxpos, kypos, kzpos#
#define attenuation_continuous #
asound1 attenuation_continuous asound1, kdistance1, iattenfunction#
#define airabsorption_continuous #
asound1 airabsorption_continuous asound1, kdistance1, iairfunction#
#define timeoftravel_continuous #
asound1 timeoftravel_continuous asound1, kdistance1, itimefunction#


; USER-DEFINED OPCODES

opcode envelope, k, ii
 ifunction, ifreqfunction xin
	if ifreqfunction != 0 then	
		kfreqindex	phasor 1/p3
		kfrequency	tablei kfreqindex, ifreqfunction, 1, 0, 0
		else
		kfrequency = 1/p3
	endif
	kvalue poscil 1, kfrequency, ifunction
	xout kvalue
endop

opcode trajectory, k, ik
 ifunction, kfrequency xin
	kvalue poscil 1, kfrequency, ifunction
	xout kvalue
endop

opcode xyz2aed_discrete, iii, iii
 ixpos, iypos, izpos xin
	idistancexy = (ixpos^2+iypos^2)^0.5			;distance (2D)
	iradiansxy taninv2 iypos, ixpos 		;azimuth
	iazimuth = 90-(iradiansxy*57.29577951308)	;radians to degree
	idistancexyz = (idistancexy^2+izpos^2)^0.5	;distance (3D)
	iradiansxyz taninv2 izpos, idistancexy		;elevation
	ielevation = iradiansxyz*57.29577951308	;radians to degree
	xout iazimuth, ielevation, idistancexyz
endop

opcode attenuation_discrete, a, aii
 asound, idist, iattenfunction xin
	index = idist*0.02
	irolloff  tablei  index, iattenfunction, 1, 0, 0
	igain limit (10^(irolloff*0.05)), 0, 1
	asound = asound * igain
	xout asound
endop

opcode airabsorption_discrete, a, aii
 asound, idist, iairfunction xin
	index = idist*0.02
	icutoff  tablei  index, iairfunction, 1, 0, 0
	aspkfeed butterlp asound, icutoff		
	xout aspkfeed
endop

opcode timeoftravel_discrete, a, aii
 asound, idist, idopplerfunction xin
  	idelaytime  = idist*2.9411764705882353	
  	idelayindex = idelaytime*0.0068
  	idelaytime  tablei idelayindex, idopplerfunction, 1, 0, 0
	adelaytime  limit idelaytime, 128/sr, 0.3
	aspkfeed vdelayxw asound, adelaytime, 0.3, 256 
	xout aspkfeed
endop

opcode xyz2aed_continuous, kkk, kkk
 kxpos, kypos, kzpos xin
	kdistancexy = (kxpos^2+kypos^2)^0.5		;distance (2D)
	kradiansxy taninv2 kypos, kxpos 			;azimuth
	kazimuth = 90-(kradiansxy*57.29577951308)	;radians to degree 
	kdistancexyz = (kdistancexy^2+kzpos^2)^0.5	;distance (3D)  
	kradiansxyz taninv2 kzpos, kdistancexy		;elevation
	kelevation = kradiansxyz*57.29577951308	;radians to degree
	xout kazimuth, kelevation, kdistancexyz
endop

opcode attenuation_continuous, a, aki
 asound, kdist, iattenfunction xin
	kindex = kdist*0.02
	krolloff  tablei  kindex, iattenfunction, 1, 0, 0
	kgain limit (10^(krolloff*0.05)), 0, 1
	asound = asound * kgain
	xout asound
endop

opcode airabsorption_continuous, a, aki
 asound, kdist, iairfunction xin
	kindex = kdist*0.02
	kcutoff tablei kindex, iairfunction, 1, 0, 0
	aspkfeed butterlp asound, kcutoff		
	xout aspkfeed
endop

opcode timeoftravel_continuous, a, aki
 asound, kdist, idopplerfunction xin
  	kdelaytime = kdist*2.9411764705882353	
  	kdelayindex = kdelaytime*0.0068
  	kdelaytime tablei kdelayindex, idopplerfunction, 1, 0, 0
	adelaytime limit kdelaytime, 128/sr, 0.3
	aspkfeed vdelayxw asound, adelaytime, 0.3, 256 
	xout aspkfeed
endop



;INSTRUMENTS

;==============
instr 1
;==============

;; SOUNDFILE PLAYER *****************

idur			= p3
ifilename		= p4
igain			= (p5 > 0.0 ? (p5) : (10^(p5*0.05)))
igainenvelope	= p6
istartposition	= p7
ioscfrequency	= 1/idur

asoundfile		diskin2	ifilename, 1, istartposition, 0, 0, 512, 262144, 0
kgainenvelope 	poscil  igain, ioscfrequency, igainenvelope
asound 		= asoundfile * kgainenvelope

;; SPATIAL SOUND RENDERER ***********

ixpos_envelope 		= p8
iypos_envelope 		= p9
izpos_envelope		= p10

iattenfunction		= (p11 = 0 ? 200 : (p11 = 1 ? 201 : (p11 = 2 ? 202 : p11)))
iairfunction		= (p12 = 1 ? 301 : (p12 = 2 ? 302 : p12))
itimefunction		= (p13 = 1 ? 401 : p13)
icentersize			= p14

ispread_envelope		= p15

ktrajfrequency		= 1/p3

;;--- COPY SOUND SOURCE

$vbap_copy_source

;;--- TRAJECTORIES

$vbap_trajectories

;;--- Cartesian to Polar Coordinates

$xyz2aed_continuous

;;---DISTANCE CUES

timeoftravel:
cggoto (itimefunction = 0), airabsorption
$timeoftravel_continuous
;asound1 timeoftravel_continuous asound1, kdistance1, itimefunction

airabsorption:
cggoto (iairfunction = 0), attenuation
$airabsorption_continuous
;asound1 airabsorption_continuous asound1, kdistance1, iairfunction

attenuation:
cggoto (iattenfunction = 0), panning
$attenuation_continuous
;asound1 attenuation_continuous asound1, kdistance1, iattenfunction

panning:
;;--- PANNING ALGORITHM

; spread-control (increase spread of soundsource within center-zone)
if (kdistance1 < icentersize) then
kfactor= kdistance1/icentersize
kspread scale kfactor, kspread, 100 ;linear scaling... might be changed
else
kspread = kspread
endif

ch4:
cggoto (nchnls > 4), ch8
a1, a2, a3, a4 vbap4 asound1, kazimuth1, kelevation1, kspread
outc a1, a2, a3, a4
goto end

ch8:
cggoto (nchnls > 8), ch16
a1, a2, a3, a4, a5, a6, a7, a8 vbap8 asound1, kazimuth1, kelevation1, kspread
outc a1, a2, a3, a4, a5, a6, a7, a8
goto end

ch16:
a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16 vbap16 asound1, kazimuth1, kelevation1, kspread
outc a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16

end:

endin

