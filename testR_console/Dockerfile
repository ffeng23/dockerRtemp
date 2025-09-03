
FROM docker.io/rocker/r-ver:4.1.3

#create a folder in container and entering it.
#something it is not working well at the root directory.

#note about directory, we use the bind volume to the container volum main
#we do this binding with the docker run command switches -w /main -v "$(pwd):/main" 
# At running time (not compiling/building time)
#  docker run \
#     -w /main -v "$(pwd):/main" \
#     -it "readwrite"
# #building:
# docker build -t readwrite .

#Run this in order to plot x11 figures
RUN apt-get update && apt-get install -y sudo \
    && apt-get install -y --no-install-recommends libxt6 \
    && apt-get install -y libz-dev \
    && apt-get install -y libpng-dev libfontconfig1-dev \
    && apt-get install -y libharfbuzz-dev libfribidi-dev \
    && apt-get install -y libfreetype6-dev libtiff5-dev libjpeg-dev \
    && apt-get install -y libxml2-dev

#here we define the newly created user
# this is necessary since it will be used by the docker compse 
# at run time to solve the file permission issues.
# UID/GID/ruser are all arbitrary. 
# we call it ruser to be a general name for easily used purpose
# UID and GID will be modified at the run time (in yaml compose file)
# depending on who is calling it.
ARG UID=2000
ARG GID=2000
ARG USER1=ruser

#create a new user. this is necessary to make the file generated in docker to 
# have the permission (read/write) to the host
RUN addgroup --gid $GID $USER1 
RUN adduser --uid $UID --gid $GID --gecos '' --disabled-password $USER1


WORKDIR /home/$USER1/project1 
#as stated in the docker compose file, it is better to keep the project under
#user's home direcotry. so when we change the UID, we don't have to go
#extra directory to change the ownership. easy to track and modify.

# is this necessary to call as the $USER? should it work if we call as the root???
# need to check later.
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# approach two
# to set up the 
COPY renv.lock renv.lock
#COPY renv.lock /home/renv.lock
RUN  mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
COPY code.R code.R
#COPY renv/settings.dcf renv/settings.dcf
# Note for above, we don't have renv/settings.json somehow (?),
# it is not necessary!!! we could just need .Rprofile and activate.R and renv.lock
#

RUN R -e "renv::settings\$use.cache(FALSE)"
#change owner ship to rstudio, RECURSIVELY with -R
# and then restor the renv library as the user "rstudio"
RUN chown -R $USER1 . \
  && sudo -u $USER1 R -e "renv::restore()"
#RUN chown rstudio /home/renv.lock

RUN sudo -u $USER1 echo "setwd(\"/home/${USER1}/project1\")" > /home/$USER1/.Rprofile

RUN sudo -u $USER1 echo "renv::load()" >> /home/$USER1/.Rprofile 

#    && echo ".rs.restartR()" >>/home/rstudio/.Rprofile 


#this is for rstudio. so we need to change the ownership
#RUN chown rstudio /app/KerasR_test

#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
