####this is the one to do read and write 
#    used in combination with compose.yml file.
#      (we don't have to do in combination, but we could)
#	https://www.robertmylesmcdonnell.com/content/posts/docker/
# but we do convert not to use yaml (docker compose)
#	but only use docker to add named volumes
FROM rocker/rstudio:4.1.3
#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /app/KerasR_test
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
    && apt-get install -y libxml2-dev

RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

#do this in the folder containing the renv.lockfile
COPY renv.lock renv.lock

# set up the local library at the docker folder (WORKDIR)
ENV RENV_PATHS_LIBRARY renv/library

#restore
RUN R -e "renv::restore()"

#this is for rstudio. so we need to change the ownership
RUN chown rstudio /app/KerasR_test

#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
