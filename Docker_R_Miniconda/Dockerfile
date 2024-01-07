Don't run for now!!!!


####this is the one to do read and write 
#    used in combination with compose.yml file.
#      (we don't have to do in combination, but we could)
#	https://www.robertmylesmcdonnell.com/content/posts/docker/
# but we do convert not to use yaml (docker compose)

#	but only use docker to add named volumes
FROM rocker/rstudio:4.1.3
#create a folder in container and entering it.
#something it is not working well at the root directory.
WORKDIR /app/miniconda
#note about directory, we use the bind volume to the container volum main
#we do this binding with the docker run command switches -w /main -v "$(pwd):/main" 
# At running time (not compiling/building time)
#  docker run \
#     -w /main -v "$(pwd):/main" \
#     -it "readwrite"
# #building:
# docker build -t readwrite .
#RUN touch little_script.R

#We add libxt6 for rstudio to do x11 related plotting.
RUN apt-get update && apt-get install -y --no-install-recommends libxt6

#Start doing conda 
RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install miniconda
# ref : https://fabiorosado.dev/blog/install-conda-in-docker/
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH 
#add current directory to show in the print.
#RUN echo "print('hi, every-body!$(pwd)')" >> little_script.R
#RUN echo "created an R file. now running.....!!\n"
#CMD ["Rscript", "readwrite.R"]
