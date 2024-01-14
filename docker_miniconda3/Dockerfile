###!!!!! this one is working, but it starts with ubuntu and
#   then download to install miniconda
# now, we have another one to use continuumio/miniconda from hub
#  this later one is smaller. see at Dockerfile_continuoumHub

####this is the one to do read and write 
#    used in combination with compose.yml file.
#      (we don't have to do in combination, but we could)
#	https://www.robertmylesmcdonnell.com/content/posts/docker/
# but we do convert not to use yaml (docker compose)
#	but only use docker to add named volumes
FROM ubuntu

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


#RUN  apt-get update && apt-get install -y --no-install-recommends python3 pip

#here we define the newly created user
# this is necessary since it will be used by the docker compse 
# at run time to solve the file permission issues.
# UID/GID/ruser are all arbitrary. 
# we call it ruser to be a general name for easily used purpose
# UID and GID will be modified at the run time (in yaml compose file)
# depending on who is calling it.
ARG UID=2000
ARG GID=2000
ARG USER1=user1

#create a new user. this is necessary to make the file generated in docker to 
# have the permission (read/write) to the host
RUN addgroup --gid $GID $USER1 
RUN adduser --uid $UID --gid $GID --gecos '' --disabled-password $USER1

#Start doing conda 
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get install -y wget sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /home/$USER1/scomatic

# Install miniconda
# ref : https://fabiorosado.dev/blog/install-conda-in-docker/
ENV CONDA_DIR /home/$USER1/miniconda3
USER ${USER1}
#RUN echo "$PATH"

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p ~/miniconda3

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH 


COPY environment.yml environment.yml
COPY r_requirements_install*.R ./
RUN conda init
RUN conda env create -f environment.yml -v

SHELL ["/bin/bash", "-c"]

#RUN 
RUN source ${CONDA_DIR}/etc/profile.d/conda.sh \
    && conda activate SComatic && Rscript r_requirements_install.v3_6.R

#copy files and structures: We copy everthing one by one to avoid too huge the image

#COPY * ./ #this will copy evertyihg, but too huge

COPY README* ./
COPY Feng*.md ./

ADD docs ./docs
COPY PoNs ./PoNs
ADD bed_files_of_interest ./bed_files_of_interest
ADD RNAediting ./RNAediting
ADD scripts ./scripts


#change back to root, otherwise we will have trouble to 
# do things like change file owners (in yaml at the run time)
USER root


#COPY renv/settings.dcf renv/settings.dcf
# Note for above, we don't have renv/settings.json somehow (?),
# it is not necessary!!! we could just need .Rprofile and activate.R and renv.lock
#

#change owner ship to rstudio, RECURSIVELY with -R
# and then restor the renv library as the user "rstudio"
#RUN chown -R $USER1 ./
#RUN chown rstudio /home/renv.lock


#this is for rstudio. so we need to change the ownership
#RUN chown rstudio /app/KerasR_test

#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
