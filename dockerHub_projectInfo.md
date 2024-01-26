# Information about the projects (repositories) on docker hub


- 1) ffeng23/scomatic

This is the python project for doing scRNASeq mutation analysis.
It have only the code and running environment. Base image is miniconda. User has to provide/map the
local reference data, genome reference, PON etc.
The project fold is P52s Feng/hg/SComatic.

    *** need to work more on this one.
    
- 2) and 3) ffeng23/ihc_proximity

R docker for doing ihc. It is not testing and not supposed to be fully functioning. Need to test more.
the project folder is E14 feng/hg/IHC_proximity.

    https://hub.docker.com/repository/docker/ffeng23/ihc_proximity_jupyter/general
        
        ffeng23/ihc_proximity_jupyter -- for jupyter environment with r-notebook 4.1.3
    
    https://hub.docker.com/repository/docker/ffeng23/ihc_proximity/general
        
        ffeng23/ihc_proximity -- for rstudio image R4.1.3

           

- 4) ffeng23/ml_rstudio_v01

This is more like a template for doing machine learning using R keras running on
tensorflow. Base image is rocker/ml:4.1.3-cuda10.1. The project folder is
P52s Feng/hg/docker_tutorial/docker_kera

- 5) (**private**) clinicaltrial 6) (public) clinicaltrial_jupyter
 
This is the one doing Rstudio used to do analysis on clinical trial. There is only code and environment, but
no data. 

Also this one shows we can do incremental update on image, so not to waste time on restore the R renv 
libraries.

  tags: latest-- this is the first one, doing the everything from scratch. (Dockerfile)
  
      :incr.01--first incremental from latest one. (this is the latest one). (Dockerfile_incremental) 
  
  project folder:    E14 hg/clinicalTrial
  
2nd one is jupyter r-notebook application. this one is public
    E14 hg/clinicalTrial
  
- 7) ffeng23/docker_r_readwritecompose2
This is to demo how to use the beginner level of R with read and write volume and commandline.
This is the first one and for testing only. Check the folder on
P52s hg/docker_tutorials/docker_r_readwritecompose2.


- 8) ffeng23/igseq_r3
this is docker images for IgSeq R3 for r studio application used to run R codes

P52 hg/IgSeqR3 folder

- 9) ffeng23/umi_merge
miniconda for run umi_merge. It is a separate folder. Part of code were copied to IgSeqR3 git hub code base.
this one runs on env based on scc1 bu account.
P52 hg/merge.

- 10) ffeng23/localalign

gcc 8 on debian 10 for localalign project.
original folder 
P52 hg/LocalAlign


- 10) ffeng23/cloanalyst
dotnet3.1 debian 10 linux for running cloanalyst. It loaded with running apps and sample data. 
the original folder is 
P52 hg/package_cloanalyst/publish3.1_Jan262024
