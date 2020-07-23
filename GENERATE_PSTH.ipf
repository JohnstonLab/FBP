#pragma rtGlobals=3		// Use modern global access method and strict wave access.

#include "Generate_Radons"
#include "FBP"
#include "Temporal"

// Generate_PSTH takes time series data reccored using a series of flashed bars designed to probe the neuron's receptive field  and generates a stack of PSTHs
// each row corresponds to the the PSTH in response to a flashed bar whose location is expressed on the y axis
// Each layer corresponds to the same data collected at different angles



function GENERATE_PSTH(w,orders,times,pre,win,bars,angs)

	wave w, orders,times		// input waves// w=data wave, order=the order of the flashes, times=the onset time of each flash
	variable pre, win, bars, angs			// input variables// pre=duration to display prior to flash, win= total duration to disaply including pre, bars=number of bars used, angs=number of angles used 
	
	variable scale =dimdelta(w,0)
	
	make/FREE/o/N=((win/scale),bars,angs) out		// generate output wave
	
	variable l,r, k, on				// counters
	
	
	/// the following loop extracts the data into a PSTH (but the data remains shuffled)
	for(r=0;r<angs;r+=1)			// loop for angles 
		for(l=0;l<bars;l+=1)		// loop for bars 
			on=times[l+(r*bars)]		// get the onset of the current bar
			
			
			duplicate/FREE/R=((on-pre),(on+(win-pre))) w, temp		// duplicate the appropriate region	
			redimension/n=(-1) temp									// redimension 
			SetScale/P x 0,scale,"", temp									//set scale to start at zero
			
			wavestats/R=[0,5]/Q temp									// zero the baseline
			temp-=V_avg
			
			out[][l][r]=temp[p]							//put the data into the the outputwave
		endfor
	endfor
	
	// the following loop deshuffles the PSTH 
	make/FREE/o/N=((win/scale),bars,angs) thisone	// wave to hold the deshuffled data
	
	for(k=0;k<angs;k+=1)		// loop to deshuffle
	
		Duplicate/o/R=[][][k] out, temp1		// get the data for the first angle 
		redimension/N=(-1,-1) temp1			// redimension
		matrixtranspose temp1					// rotate the matrix to sort
		matrixsort(orders,temp1)				// sort the PSTH based on the order in "Orders" 
		matrixtranspose temp1					// rotate the matris back
		
		thisone[][][k]=temp1[p][q]			// put the data in the out put wave

	endfor
	
	string outname=nameofwave(w)+"_T" 		// the name given to the output (the original name with "_T" appended)
	
	duplicate/o thisone, $outname

end




////sort 2D matrix using sort function
function matrixsort(order,  w)			
wave order, w					// inputs// order= the order to sort with, w= the wave to sort

variable ro = dimsize(w,0), co = dimsize(w,1),i

for (i=0;i<co;i+=1)
	matrixop/FREE /o ci=col(w,i)
	sort order, ci
	w[][i] = ci[p]
endfor
end