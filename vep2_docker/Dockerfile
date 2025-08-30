FROM clearlinux:latest AS builder

# Install a minimal versioned OS into /install_root, and bundled tools if any
ENV CLEAR_VERSION=43760
RUN swupd os-install --no-progress --no-boot-update --no-scripts \
    --version ${CLEAR_VERSION} \
    --path /install_root \
    --statedir /swupd-state \
    --bundles os-core-update,which

# Download and install conda into /usr/bin
ENV MINICONDA_VERSION=py38_23.11.0-2
RUN swupd bundle-add --no-progress curl && \
    curl -sL https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    sh /tmp/miniconda.sh -bfp /miniconda3  

#originally, miniconda itself were installed to /usr of builder, to make it callable
# in the builder. But be careful, here "/usr" of build will not be
# copied over to the deployer!!. 
#that is why here we installed it to a different folder
# "/miniconda3". and also copied it over to the deployer.
# NOte: again, the /minicond3 folder and the created 
# env were done in different location. In this case,
# this new env were into directly to /usr/local to make it
# callable/usable in the deployer!!!
    
# Use conda to install remaining tools/dependencies into /usr/local
ENV VEP_VERSION=102.0 \
    HTSLIB_VERSION=1.10.2 \
    BCFTOOLS_VERSION=1.10.2 \
    SAMTOOLS_VERSION=1.10 \
    LIFTOVER_VERSION=377 \
    SNAKEMAKE_VERSION=7.32.4

#this is another way to create new env, 
#using mamba
#we could also don't run source init, but only
# do 
#RUN /miniconda3/bin/conda create -qy -p /usr/local ....
RUN source /miniconda3/bin/activate && conda init --all && conda create -qy -p /usr/local \
    -c conda-forge \
    mamba

#this can also work for doing named env to install,
# then when we try to call it, we could set up env PATH variable to
# make the named env path the first on the search PATH, (need to verify later!!)
#
RUN /usr/local/bin/mamba install \
    -c conda-forge \
    -c bioconda \
    -c defaults \
    ensembl-vep=${VEP_VERSION} \
    htslib \
    bcftools \
    samtools \
    ucsc-liftover \
    snakemake

# Deploy the minimal OS and tools into a clean target layer
FROM scratch

LABEL maintainer="Cyriac Kandoth <ckandoth@gmail.com>"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
COPY data /opt/data
COPY *.pl /opt/
#WORKDIR /opt

#Adding users
ARG UID=2000
ARG GID=2000
ARG USER1=user1

#create a new user. this is necessary to make the file generated in docker to 
# have the permission (read/write) to the host
RUN groupadd --gid $GID $USER1 && useradd --uid $UID --gid $GID $USER1

USER user1
WORKDIR /home/${USER1}/vep 

#note this one is the project folder, holding snakemake files

#make three folders, first for project data, second for reference

#this works for user1, could this be the strategy?? for doing 
#system-wise conda? not necessarily installed to user folder!!
# will we have permission issues??? don;t know for now!! need to
# verify!!!
COPY --from=builder /miniconda3 /miniconda3
RUN source /miniconda3/bin/activate && conda init --all


RUN mkdir -p seq_data
RUN mkdir -p ref_seq

USER 0:0

# to run
## docker run -it --rm vep2 su - user1

# to compile/build
## docker build -f Dockerfile . -t vep2
