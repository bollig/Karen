To get rid of the background from paraview (probably VTK too) we need to do a two-step auto trimming process with imagemagick: 


#!/bin/bash 

convert  -density 400 -trim +repage $1 out.pdf
convert  -density 400 -trim +repage out.pdf $1 

Then use the quartz filter to compress the PDF
/System/Library/Printers/Libraries/quartzfilter big.pdf /System/Library/Filters/Reduce\ File\ Size.qfilter small.pdf
