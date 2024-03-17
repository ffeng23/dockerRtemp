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


- 11) ffeng23/cloanalyst
dotnet3.1 debian 10 linux for running cloanalyst. It loaded with running apps and sample data. 
the original folder is 
P52 hg/package_cloanalyst/publish3.1_Jan262024

- 12) ffeng23/rpackage-dev
R package developing environment with r 4.3.1 and documenting/pdf , mainly with perl, wget,
qpdf, ghostscript. 
the hardest part is for tinytex (needs perl, wget etc). otherwise it will fail.
this is based on rocker/r-ver. 

P52 hg/docker_tutorial/Rpackage_develop (and also hg/ELISAtools)


- 13) ffeng23/sns101seq

this is the R studio project for doing data analysis of the SNS101 personalis sequencing data.!!!! 
The project folder is on E14 sensei laptop, SNS101Seq.

it has rocker with R 4.3.2. and this is the one start bind/volume separately for the whole folder and renv folders inside. Now the host and container are using different renv folders. We start having host and container separately and both works. Therefore, we can easily do incremental updateing of the docker image. This is because it seems BiocManager installed packages have some conflicting and can not install correctly. It fails because it can not update the pre-built packages. The error is caused by the permission, since we modify the container to be a user, the R user home .cache (even after disabling using renv cache) have packages linked to the system folders that were not corrected when switch to the user account. I wonder whether it will work if we don't swith to user (by USERID). But on the other hand, the container containing renv and R env were build and installed at the building time and somehow we don't have this problem!!! (weird, at that time we still try to do renv::restore on behalf of user). In addition, the host version of renv and packages were done with the cache pointing to conda environment packages which is owned by the user!!!

Anyway, it worked!! 

project folder: E14 sensei laptop
  
  hg/SNS101Seq

