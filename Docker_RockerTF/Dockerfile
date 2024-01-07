####this is the one to do read and write 
#    used in combination with compose.yml file.
#      (we don't have to do in combination, but we could)
#	https://www.robertmylesmcdonnell.com/content/posts/docker/
# but we do convert not to use yaml (docker compose)
#	but only use docker to add named volumes
FROM rocker/ml:4.1.3-cuda10.1
#FROM rocker/cuda:4.1.3-cuda10.1

#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /home/rstudio/testR
#note about directory, we use the bind volume to the container volum main
#we do this binding with the docker run command switches -w /main -v "$(pwd):/main" 
# At running time (not compiling/building time)
#  docker run \
#     -w /main -v "$(pwd):/main" \
#     -it "readwrite"
# #building:
# docker build -t readwrite .
#RUN touch little_script.R
#Run this in order to plot x11 figures
RUN apt-get update && apt-get install -y --no-install-recommends libxt6 \
    && apt-get install -y libz-dev \
    && apt-get install -y libpng-dev libfontconfig1-dev \
    && apt-get install -y libharfbuzz-dev libfribidi-dev \
    && apt-get install -y libfreetype6-dev libtiff5-dev libjpeg-dev \
    && apt-get install -y libxml2-dev \
    && apt-get install -y python3-venv wget

#RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
#    /bin/bash ~/miniconda.sh -b -p /home/rstudio/miniconda3
    #-b is for batch mode without human intervention

#RUN ln -s /home/rstudio/miniconda3/bin/conda /usr/bin/conda && conda init

#RUN . ~/.bashrc

#RUN conda create -n tf3.7 -c conda-forge python=3.7 mamba


#RUN conda init 

#RUN . ~/.bashrc && conda activate tf3.7

# %>% 
#  use_condaenv(conda_list()[[1]][2], required = TRUE)

#Checking python

#platform<-import("platform")
#print(platform$python_version())




#do this in the folder containing the renv.lockfile
COPY renv.lock renv.lock

RUN  mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.dcf renv/settings.dcf

#COPY code.R code.R

# set up the local library at the docker folder (WORKDIR)
#ENV RENV_PATHS_LIBRARY renv/library

#RUN sudo  R -e "install.packages('renv')"

RUN chown -R rstudio . \
    && sudo -u rstudio R -e "renv::restore()"

#USER rstudio

#
RUN sudo -u rstudio R -e "install.packages(c('keras', 'tensorflow','reticulate'))"

#Sys.setenv(RENV_PATHS_CACHE = '/home/rstudio/testR/renv/cache')
#renv::use_python(type = 'conda', name = 'tf3.7', required=T)
#path_to_python <- "/home/rstudio/miniconda3/envs/tf3.7/bin/python" 
#RUN  sudo -u rstudio R -e "install.packages(c('renv'), repos = c(CRAN = 'https://cloud.r-project.org'))"
#install tensorflow
RUN  sudo -u rstudio R -e "reticulate::install_miniconda()"

RUN  sudo -u rstudio R -e "reticulate::conda_install(envname='r-reticulate',packages = 'python=3.7')"

#RUN  sudo -u rstudio R -e "install.packages('tensorflow')"

#RUN  sudo -u rstudio R -e "tensorflow::install_tensorflow(version='2.3')"
#tensorflow::install_tensorflow(version='2.2', method="conda", envname="tf3.7",conda="auto")


RUN sudo -u rstudio echo "setwd(\"/home/rstudio/testR/\")" > /home/rstudio/.Rprofile

RUN sudo -u rstudio echo "renv::load()" >> /home/rstudio/.Rprofile 


#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
