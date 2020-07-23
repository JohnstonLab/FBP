#pragma rtGlobals=3		// Use modern global access method and strict wave access.

#include "GENERATE_PSTH"
#include "Temporal"
#include "FBP"

// Generate_radons takes the PSTH created by Generate_PSTH, and converts this to a radon transform of the receptive field

Function Generate_radons(w,s,e)

	wave w				// input wave, the PSTH
	variable s, e		// vairables for the region to measure, start and end, take account of the scaling of the PSTH wave

	variable i
	
	duplicate/o/R=(s,e)()() w, temp			
	matrixop/FREE/o temps=sumcols(temp)		
	matrixop/FREE/o tempr=transposevol(temps,3)
	matrixtranspose tempr
	
	string outname=nameofwave(w)+"R"
	Duplicate/o tempr, $outname		// outputs the radon transform named as the PSTH with "_R" appended
		
end