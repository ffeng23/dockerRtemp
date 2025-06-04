FROM lscr.io/linuxserver/code-server:latest


ARG NB_USER=1000

#now prepare the R and renv
WORKDIR /config/workspace

ADD https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.31/quarto-1.7.31-linux-amd64.deb ./quarto.deb


RUN apt-get update && apt-get install -qy --no-install-recommends r-base cmake \
pandoc gcc \
make libpng-dev libpng-tools zlib1g-dev \
python3 python3-pip jupyter-notebook python3-yaml \
pkg-config automake autoconf g++ libxml2-dev && \
apt-get clean

RUN dpkg -i quarto.deb
#RUN apt-get install -qy python3-jupyter-server python3-jupyterlab-server

RUN  quarto install tinytex


#########################
# this below section is used to prepare the R renv after the first time
# comment the below lines, if this is the first time run.
# uncomment them, if this is after the first run.
#########################
#COPY workspace/renv.lock renv.lock
#RUN  mkdir -p renv

#COPY workspace/.Rprofile .Rprofile
#COPY workspace/renv/activate.R renv/activate.R
#COPY workspace/renv/settings.json renv/settings.json
#COPY renv/settings.dcf renv/settings.dcf

#########USER ${NB_USER}
#first time
RUN R -e "install.packages(c('renv', 'languageserver'), repos = c(CRAN = 'https://cloud.r-project.org'))"

#COPY workspace/*.R ./
#USER ${NB_USER}

#RUN R -e "renv::init(bare=TRUE)"

#note, this renv::init(bare=TRUE) is to initialize ON THE CONTAINER the "renv" folder and generate
#  .Rprofile. so far this is enough, since we need to map the renv in the compose file. without this
# we have to also modify the compose file to distinguish first time from afterwards. (NOT nice!!!)
#
# The things to do for the first time for R and renv after container is up:
#  1) open the R terminal (assume you have finished install vs code extensions) by
#     run R: create R terminal in command palette (ctrl+shift p)
# 2) run renv::init(bare=TRUE) and renv::snapshot() to generate .Rprofile and renv.lock etc
#   in the host file system.
#     OK, it is a bit complicated, but the rationale is we have done the init on the container, but
#   we map the workspace with the "bind mount" format, so the renv.lock. .Rprofile, etc won't be
#   seen on the host, therefore we will need to "regerated" on the host and use them for the following
#   times. it is all about the named volume vs bind mount. !! these are largely true for uv uv.lock, etc.


#after first time
#RUN R -e "install.packages(c('renv', 'languageserver'), repos = c(CRAN = 'https://cloud.r-project.org'))" &&
#    R -e "renv::settings\$use.cache(FALSE);renv::restore()"

######################
##   END of section
######################




#USER root

#RUN chown -R ${NB_USER} .



#RUN /app/code-server/lib/vscode/bin/remote-cli/code-server --install-extension 'reditorsupport.r'


#RUN echo "renv::settings\$use.cache(FALSE)" > /home/${NB_USER}/.Rprofile
#install uv for python dependencies


#######################
## this below section is for update the python venv after the first time (similar to R renv)
#comment the below lines, if this is the first time run.
# uncomment them, if this is after the first run.
#
#ALSO NOTE: first time we need to run uv init to generate pyproject.toml and other files
# we also need to generate uv.lock (?) during the first time. "source .venv/bin/activate (?)
############################

#COPY workspace/pyproject.toml ./
#COPY workspace/uv.lock ./

#--> choose this one if this is after first time (uv sync)
#RUN curl -LsSf https://astral.sh/uv/install.sh | sh &&
#  . $HOME/.local/bin/env && uv venv && uv sync


#--->choose this one if this is the first time (no uv sync)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh #&& 
#  . $HOME/.local/bin/env && uv venv

#thins to do for the first time for uv venv for the first time after the container is running:
#
# in terminal run : . $HOME/.local/bin/env #to activate the uv path
#         uv init #generate pyproject.toml and structure and others
#         uv add jupyter # to add the jupyter to the environment and also generate the lockfile, vu.lock
#
#updated 6/1/2025, we decided not to any preparations for venv, since
#     1) it is fast to recreate
#     2) it seems vs-code has its own file system (ms?), it we prepare here at the system wise
#     and map later, we will has issues(warning) and reduce the performance.
#     so we will each time prepare only uv.lock or project.toml(?) by git and recreate venv in vs-code
# 
#######################

###########################
## END OF SECTION
##########################


#RUN ls -la .. && pwd && ls -la . && id && ls -la ../.local/bin && 
#    ../.local/bin/uv --version 

RUN chown -R ${NB_USER} .

