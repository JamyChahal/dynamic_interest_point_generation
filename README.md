# Dynamic interest point generation

For reviewers of the conference HICCS2023 : 

## MATLAB Version and dependencies : 

Matlab R2022a

Add-on used : 

* Parallel Computing Toolbox (v7.6)
* Image Processing Toolbox (v11.5)
* Computer Vision Toolbox (v10.2)

## Experience : Predefined vs dynamic interest point

Go to the folder "EXP_Predefined_Dynamic_IP"

Then execute *example_PIPvsDIP.m* within the parent folder. When executing, select "Add to the path". This algorithm generate several images of the predefined interest point and the dynamic interest point for a specific observation range. 

To obtain the probability density function of several observation range, execute the code *exp_PIPvsDIP.m*. To get the plot, execute *read_log_PIPvsDIP.m*

## Experience : Surface idleness with and without filtering the map

Go to the folder "EXP_Surface_Idleness"

Then execute *loop_surface_idleness.m* within the parent folder. The variable "result" will contains the experience's result, with and without filter (alone vs filter), regarding the idleness metric (idleness or surface idleness). 
