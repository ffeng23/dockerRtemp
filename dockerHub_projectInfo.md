# Information about the projects (repositories) on docker hub


- 1) ffeng23/scomatic

This is the python project for doing scRNASeq mutation analysis.
It have only the code and running environment. Base image is miniconda. User has to provide/map the
local reference data, genome reference, PON etc.
The project fold is P52s Feng/hg/SComatic.

- 2) ffeng23/ihc_proximity

R docker for doing ihc. It is not testing and not supposed to be fully functioning. Need to test more.
the project folder is E14 feng/hg/IHC_proximity.

- 3) ffeng23/ml_rstudio_v01

This is more like a template for doing machine learning using R keras running on
tensorflow. Base image is rocker/ml:4.1.3-cuda10.1. The project folder is
P52s Feng/hg/docker_tutorial/docker_kera

- 4) (**private**) clinicaltrial
 
This is the one doing Rstudio used to do analysis on clinical trial. There is only code and environment, but
no data. 

Also this one shows we can do incremental update on image, so not to waste time on restore the R renv 
libraries.

  tags: latest-- this is the first one, doing the everything from scratch. (Dockerfile)
  
      :incr.01--first incremental from latest one. (this is the latest one). (Dockerfile.incremental) 
  
  project folder:    E14 hg/clinicalTrial
  
- 5) ffeng23/docker_r_readwritecompose2

This is the first one and for testing only. Check the folder on
P52s hg/docker_tutorials/docker_r_readwritecompose2.
