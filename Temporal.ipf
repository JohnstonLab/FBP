#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#include "GENERATE_PSTH"
#include "Generate_Radons"
#include "FBP"

function Temporal(w, theta)

//Temporal(w, theta) takes a PSTH wave and constructs a series of receptive field (RF) reconstructions with a temporal 
// resolution defined by "res". "theta" specifies the number of angles used to generate the radon transform.

	wave w			/// PSTH wave
	variable theta	///	the number of angles for the reconstruction
	variable res=8	// the temporal resolution in ms
	
	variable s,e, i,xx,len
	
	xx=dimsize(w,1)
	len=dimsize(w,0)
	
	make/FREE/o/N=(xx,xx,(len/res)) temp	// create a temporary wave of teh correct dimensions to hold the RF reconstructions
	
	
	
	for(i=0;i<len;i+=res)  // loop through the discrete time bins to reconstruct the RFs
		
		s=i
		e=s+res
		Generate_lots_of_radons(w,s,e,i)			// calls Generate_lots_of_radons(w,s,e,i) to provide a radon transfor of the time bin 
		string name=nameofwave(w)+"Rs"+num2str(i)
		FBP($name, theta, 0.6)						// calls FBP to convert the Radon generated above into a RF, note the filter is set a 0.6	
		string name1=nameofwave(w)+"Rs"+num2str(i)+"F"
		wave t=$name1
		
		temp[][][i/res]=t[p][q]
		
		killwaves $name, $name1
		
	endfor
	
	setscale/P z, 0,(res), temp
	string outname=nameofwave(w)+"_RMAP"		
	duplicate/o temp, $outname				// outputs the data wave named as the original wave with "_RMAP" appended
end



Function Generate_lots_of_radons(w,s,e,i)		// used to generate to generate multiple radon transforms for the temporal procedure

	wave w				// input wave, the PSTH
	variable s, e,i		// vairables for the region to measure, start and end

	
	
	duplicate/o/R=(s,e)()() w, temp			
	matrixop/FREE/o temps=sumcols(temp)		
	matrixop/FREE/o tempr=transposevol(temps,3)
	matrixtranspose tempr
	
	string outname=nameofwave(w)+"Rs"+num2str(i)
	Duplicate/o tempr, $outname	
		
end