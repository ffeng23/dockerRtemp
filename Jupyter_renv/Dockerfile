FROM jupyter/r-notebook:x86_64-ubuntu-22.04
#jupyter/r-notebook:r-4.3.1
#create a folder in container and entering it.
#something it is not working well at the root directory.



#note about directory, we use the bind volume to the container volum main

#USER root

RUN mamba install --yes pkg-config make pandoc cmake && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"



RUN R -e "install.packages(c('renv'), repos = c(CRAN = 'https://cloud.r-project.org'))"
#RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/curl/curl_5.1.0.tar.gz')"
# approach two
# to set up the 

WORKDIR /home/${NB_USER}/jupyter_renv
COPY renv.lock renv.lock
#COPY renv.lock /home/renv.lock
RUN  mkdir -p renv

COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
#COPY renv/settings.dcf renv/settings.dcf
#COPY . ./
COPY *.ipynb ./
COPY subfolder ./subfolder
COPY READ* ./
COPY *.R ./
COPY DESCRIPTION ./

# Note for above, we don't have renv/settings.json somehow (?),
# it is not necessary!!! we could just need .Rprofile and activate.R and renv.lock
#

#change owner ship to rstudio, RECURSIVELY with -R
# and then restor the renv library as the user "rstudio"
#RUN chown -R rstudio .
USER root
RUN chown -R ${NB_USER} .

USER ${NB_USER}
RUN R -e "renv::restore()"
 

#RUN sudo -u rstudio echo "setwd(\"/home/rstudio/IHC_proximity/\")" > /home/rstudio/.Rprofile

#RUN sudo -u rstudio echo "renv::load()" >> /home/rstudio/.Rprofile 
#    && echo ".rs.restartR()" >>/home/rstudio/.Rprofile 
#COPY * ./

