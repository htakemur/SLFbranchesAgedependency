# SLFbranchesAgedependency

This repository houses data and code for reproducing figures and statistical analyses performed in the following paper.

Amemiya, K., Naito, E. & Takemura, H. (2021)
Age dependency and lateralization in the three branches of the human superior longitudinal fasciculus. Accepted for publication in Cortex.

The code was written in MATLAB2019a and tested on Ubuntu 14.04 LTS. 

The part of the function has been incorporated from the following GitHub Repository (by Jason Yeatman): https://github.com/jyeatman/lifespan

The aformentioned repository houses codes for replicating analysis of a following article:

Yeatman JD, Wandell BA & Mezer AM (2014). 
Lifespan maturation and degeneration of human brain white matter. 
Nature Communications, 5, 4932.

The part of the function has been also incorporated from MATLAB file exchange (by Ruggero Bettinardi): https://jp.mathworks.com/matlabcentral/fileexchange/62957-computecohen_d-x1-x2-varargin

Dependency: MATLAB Statistics and Machine Learning Toolbox.

##Organization of folders and code

Codes_YeatmanLifespanrepository: Codes incoportated from Jason Yeatman's repository (https://github.com/jyeatman/lifespan)

Data/Datasetinfo: Anonymized data on participant's age, sex and handedness

Data/TractVolume_Main: Data of tract volume in the main analysis

Data/TractVolume_ExclusiveROI: Data of tract volume identified by exclusive ROI analysis

Data/TractVolume_variedthreshold: Data of tract volume identified by varying streamline density threshold

Data/TractVolume_Dice: Data on spatial overlap of SLF branches

Data/FAqR1_Main: Data on FA/qR1 in the main analysis

Data/FAqR1_ExclusiveROI: Data on FA/qR1 in exclusive ROI analysis

SupplementaryFigures: Codes for replicating figures in Supplementary Information

README.md: This document

s_figure2 ~ s_figure7: Codes for replicating figures in the main document of the article

##Contacting information
 
Hiromasa Takemura

Center for Information and Neural Networks (CiNet),
National Institute of Information and Communications Technology

E-Mail: htakemur [XXX] nict.go.jp (Replace [XXX] to @)