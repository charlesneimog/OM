; HEADER 

sr = 44100
kr = 44100
ksmps = 1
nchnls = 9

; GLOBAL VARIABLES

gidims  = 3
giorder  = 2


; MACROS

#define spat_copy_source #
asound1 = asound#
#define spat_envelopes #
kxpos envelope ixpos_envelope, ixpos_frequency_envelope
kypos envelope iypos_envelope, iypos_frequency_envelope
kzpos envelope izpos_envelope, izpos_frequency_envelope
korder envelope iorder_envelope, iorder_frequency_envelope#
#define spat_trajectories #
kxpos trajectory ixpos_envelope, ktrajfrequency
kypos trajectory iypos_envelope, ktrajfrequency
kzpos trajectory izpos_envelope, ktrajfrequency
korder trajectory iorder_envelope, ktrajfrequency#
#define xyz2aed_discrete #
iazimuth1, ielevation1, idistance1 xyz2aed_discrete ixpos, iypos, izpos#
#define attenuation_discrete #
asound1 attenuation_discrete asound1, idistance1, iattenfunction#
#define airabsorption_discrete #
asound1 airabsorption_discrete asound1, idistance1, iairfunction#
#define xyz2aed_continuous #
kazimuth1, kelevation1, kdistance1 xyz2aed_continuous kxpos, kypos, kzpos#
#define attenuation_continuous #
asound1 attenuation_continuous asound1, kdistance1, iattenfunction#
#define airabsorption_continuous #
asound1 airabsorption_continuous asound1, kdistance1, iairfunction#


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



;INSTRUMENTS

;==============
instr 1
;==============

;; SOUNDFILE PLAYER **********************************************************

idur			= p3
ifilename		= p4
igain			= (p5 > 0.0 ? (p5) : (10^(p5*0.05)))
igainenvelope	= p6
istartposition	= p7
ioscfrequency	= 1/idur

asoundfile		diskin2	ifilename, 1, istartposition, 0, 0, 512, 262144, 0
kgainenvelope 	poscil  igain, ioscfrequency, igainenvelope
asound 		= asoundfile * kgainenvelope

;; SPATIAL SOUND RENDERER *****************************************************

ixpos 		= p8
iypos			= p9
izpos			= p10

iattenfunction	= (p11 = 0 ? 200 : (p11 = 1 ? 201 : (p11 = 2 ? 202 : p11)))
iairfunction	= (p12 = 1 ? 301 : (p12 = 2 ? 302 : p12))
;itimefunction	= p13
icentersize		= p14

iorder		limit p15, 0, 3
ispatfunction	= (p16 = 1 ? 451 : p16)

;-----------------------------------------
denorm asound
;-----------------------------------------
;;--- COPY SOUND SOURCE

$spat_copy_source

;;--- Cartesian to Polar Coordinates

$xyz2aed_discrete

index = idistance1*0.0

;;--- PANNING ALGORITHM

panning:


; Order compensation inside center-zone
iorder = (idistance1 > icentersize ? iorder : iorder*idistance1*(1/icentersize))	
iordg1 limit iorder, 0, 1
;prints "iordg1 = %f, iordg2 = %f, iordg3 = %f\\n", iordg1, iordg2, iordg3

cggoto (gidims = 3), with_height
cggoto (giorder = 1), first_order_2d
cggoto (giorder = 0), uhj
with_height:
cggoto (giorder = 1), first_order_3d


first_order_2d:
aw, ax, ay, az  spat3d asound1, ixpos, iypos, izpos, icentersize, ispatfunction, 2, 8, 8	
outc aw, ax*iordg1, ay*iordg1
goto end

first_order_3d:
aw, ax, ay, az  spat3d asound1, ixpos, iypos, izpos, icentersize, ispatfunction, 3, 8, 8	
outc aw, ax*iordg1, ay*iordg1, az*iordg1
goto end

uhj:
aw, ax, ay, az  spat3d asound1, ixpos, iypos, izpos, icentersize, ispatfunction, 3, 8, 8
aWreal, aWimaginary	hilbert aw
aXreal, aXimaginary	hilbert ax
aYreal, aYimaginary	hilbert ay
aWXreal		=  0.0928*aXreal + 0.4699*aWreal
aWXimaginary	=  0.2550*aXimaginary - 0.1710*aWimaginary
aLeft			=  aWXreal + aWXimaginary + 0.3277*aYreal
aRight		=  aWXreal - aWXimaginary - 0.3277*aYreal
outc aLeft, aRight
goto end

end:

endin

