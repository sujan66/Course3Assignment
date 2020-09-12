## Course3assignment

Repository contains two script files, one codebook.md file and a copy of the tidy_data. It also 
contains the raw dataset directory.

The tidy_data.txt contains a data.frame of dimensions 180 X 68
(180 rows : 30 volunteers X 6 activities, 
68 columns : 1 subjectId, 1 Activity and 66 readings containing mean() and std() values.)

The run_analysis.r script sources the util.r script. The run_analysis.r is the main script file that
contain the r commands used for cleaning up the data. the util.r script contains r functions 
for reading and merging datasets.

For information about tidy_data.txt variables, see tidy_data.txt section in codebook.md

For information on the intermediary objects used in run_analysis.r, see run.analysis.r/data section
in codebook.md

Brief overview of each r command are shown in comments in each script file and is detailed in 
codebook.md