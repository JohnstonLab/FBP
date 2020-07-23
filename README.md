# FBP
Reconstruction of the spatio-temporal receptive fields of visual neurons with Filtered Back Projection


Full details of how to map the spatio-temporal receptive field of visual neurons using these procedures can be found in the accompanying methods paper published in the Journal of Physiology 2014.

[Rapid mapping of visual receptive fields by filtered back‐projection: application to multi‐neuronal electrophysiology and imaging](https://physoc.onlinelibrary.wiley.com/doi/full/10.1113/jphysiol.2014.276642) (DOI: 10.1113/jphysiol.2014.276642) 


Notes on generating an appropriate stimulus:

The width of the stimulus bar should be determined for each experimental setup, the bar should be less than half the width of the receptive field being measured. Thinner bars will give higher spatial resolution at the expense of increased stimulation time. 

A minimum of 5 angles should be used, this is sufficient to recover the receptive field centre. Using more angles it may be possible to reveal weak receptive field surrounds.

The function "Generate_PSTH" assumes that the complete stimulus sequence has been presented only once. To average multiple stimulus presentations will require modification of this function.
	

