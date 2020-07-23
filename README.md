# FBP
Reconstruction of the spatio-temporal receptive fields of visual neurons with Filtered Back Projection

![Reconstrcuted receptive field of a retinal ganglion cell](https://github.com/JohnstonLab/FBP/blob/master/RF.png)

This project provides [Igor Pro](https://www.wavemetrics.com/products/igorpro) procedures to reconstruct both the spatio and temporal receptive fields of visual neurons that have been stimulated with a series of flashed bars. 

A complete description of this method along with examples of its implementation has been published in a scientific paper in J Physiol (2014) [Rapid mapping of visual receptive fields by filtered back‐projection: application to multi‐neuronal electrophysiology and imaging](https://physoc.onlinelibrary.wiley.com/doi/full/10.1113/jphysiol.2014.276642) (DOI: 10.1113/jphysiol.2014.276642) 
Please cite this paper when publishing data using this method.

Also see http://onlinelibrary.wiley.com/doi/10.1113/JP272384/full for a good example of how this method can also reveal the time course of synaptic inputs across different regions of an amacrine cell's receptive field




Notes on generating an appropriate stimulus:

The width of the stimulus bar should be determined for each experimental setup, the bar should be less than half the width of the receptive field being measured. Thinner bars will give higher spatial resolution at the expense of increased stimulation time. 

A minimum of 5 angles should be used, this is sufficient to recover the receptive field centre. Using more angles it may be possible to reveal weak receptive field surrounds.

The function "Generate_PSTH" assumes that the complete stimulus sequence has been presented only once. To average multiple stimulus presentations will require modification of this function.
	

