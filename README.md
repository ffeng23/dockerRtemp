# notes: about projects.

- Docker_RockerTF  (testing case ? Docker_KerasR_test)
    template for docker doing R with machine learning with keras with Rstudio
    
    It was built on top of KerasR_test (original on conda, see it at ../KerasR_test
    
    In this one, we have working r console, rstudio and also with 
    file permission set up correctly, renv and tensorflow.
    
    We could call it without gpu enabled (not sure about this part. how? Disable in docker-compose.yaml file?
            by not specify the device section?)

        updated 4/18/2025, figure out we could diable it by r at the starting of the r programe (even 
        before load the keras library, set system env 
            
                Sys.setenv("CUDA_VISIBLE_DEVICES" = -1) 
        
    
    This is the one on docker hub, 
        ffeng23/ml_rstudio_v01
            Description
                A container for rstudio testing project with R4.1.3. Built upon rocker/ml for using tensorflow

- myDocker_R series

    myDocker_R
    myDocker_R_ReadWriteCompose
    testDocker_R_ReadWriteCompose2
    myDocker_R_ReadWriteCompose2
    myDocker_R_ReadWrite

    R command line to test about file system and read/write, etc. Easy learning materials
    
- testR_docker
    template for R docker (rstudio) with renv and correct file permissions.
    

- testR_console
    template for R console with renv and correct file permissions.
    
    ** here the README file contains the calling code!!!
    show how to call docker compose up, docker compose down, docker compose build.

- myDocker_rstudio
    
    rocker rstudio without renv

    

- Docker_R_Miniconda 
    for code to install miniconda (need further testing)
    with rocker/rstudio

- docker_Miniconda3

    base image is ubuntu and two dockers
    + 1) then install miniconda and conda install R
    
    + 2) continuoumio continuumio/miniconda3
    
    NO rstudio
    
- myDocker_jupyter
    for testing jupyter, need further testing.
    
    + it works for
    continuumio/miniconda3  then conda install jupyter-lab
    (the image size after pull/extraction on local is 635M)
    
    + Added another projction: doing clearlinux and conda and then 
    install jupyter.
    (the base image size on local is 702MB, pretty good compared with continuumio/miniconda3)
    (the difference could come from he different base image)
    
    **This is the prefer one, because we can choose to select the version of installed components,
    say python, jupyterlab, ect.**\
    
    **Another benefit** is the adding the user and controlling file permission.
    
   + the third way could be start on ubuntu and then download miniconda and install/activate
    the conda and then install python jupyter-lab within conda. The benefit will be the host
    system is ubuntu and have a better control on conda and user accounts, ect. (similar to
    the first one (continuumio/miniconda3???) but with extra control. The downside would be
    too large the image (need to configure!!!).
    
    
- Rpackage_develop

    docker for developing my ELISATool package

- Jupyter_renv

    using jupyter/r-notebook on docker hub.
    two applications:
    
    jupyter r-notebook with renv
    
    there is another rstudio with renv (? which one?)
    
    **Note**: this should be working for jupyter python application too. 
    

- clearlinux_JupyterRstudio
    docker to try using clearlinux and manually copy to reduce the image size.
        it worked, but the size of image is not small compared to other available ones.
        
- docker_rstudio_miniconda3
    
    doesn't work. can not install rstudio with conda. 
    
    might need to install the application on the base image instead of conda.
    
    should work. will try later.
    

    
- all other projects are for testing and not fully functioning.

    
