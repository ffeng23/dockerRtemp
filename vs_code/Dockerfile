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


COPY workspace/renv.lock renv.lock
#COPY renv.lock /home/renv.lock
RUN  mkdir -p renv

COPY workspace/.Rprofile .Rprofile
COPY workspace/renv/activate.R renv/activate.R
COPY workspace/renv/settings.json renv/settings.json
#COPY renv/settings.dcf renv/settings.dcf
#COPY . ./
COPY workspace/*.R ./


#USER root

#RUN chown -R ${NB_USER} .

#USER ${NB_USER}
RUN R -e "install.packages(c('renv', 'languageserver'), repos = c(CRAN = 'https://cloud.r-project.org'))" && \
    R -e "renv::settings\$use.cache(FALSE);renv::restore()"

#RUN /app/code-server/lib/vscode/bin/remote-cli/code-server --install-extension 'reditorsupport.r'

RUN  quarto install tinytex

#RUN echo "renv::settings\$use.cache(FALSE)" > /home/${NB_USER}/.Rprofile
#install uv for python dependencies

#first time we need to run uv init to generate pyproject.toml and other files
# we also need to generate uv.lock (?) during the first time. "source .venv/bin/activate (?)
COPY workspace/pyproject.toml ./
COPY workspace/uv.lock ./


RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
  . $HOME/.local/bin/env && uv venv && uv sync

#RUN ls -la .. && pwd && ls -la . && id && ls -la ../.local/bin && 
#    ../.local/bin/uv --version 

RUN chown -R ${NB_USER} .
