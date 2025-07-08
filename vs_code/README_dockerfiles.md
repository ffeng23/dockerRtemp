# README for the docker files in this projects (for vs-code server IDE)
updated 2025-07-08

## Dockerfile and docker-compose.yml
This is most like a temperary testing combo. Currently it is for testing
docker in docker

7/8/2025

## Dockerfile_R and docker-compose_R.yml
 and also different versions (Dockerfile_R_v2 and
 docker-compose_R_v2.yml

This is for R IDE. This is a little different for other
language IDE (say python). Here we add renv library at
build time to the project, since the R renv takes quite
long to prepare. Don't know whether this is a good idea. Probably
good for delivery (?).

**This might not be a good idea, since we have decide to de-couple
the IDE with project (keep track of the project through git at
the workspace folder!!**

update: add r-rig in the docker so to manage different versions
of R

## Dockerfile_python and docker-compose_python.yml

IDE for python projects. The container contains uv to manage
the python versions and dependent libraries.

We do it at the run time after the container is running and
through vs-code command line.

Things to do after container is running,
+ . $HOME/.local/bin/env # to load the uv defaults.
+ uv init # to initialize the project (adding project.tyml)
+ uv venv # to set up virtual environment
+ . $HOME/.venv/bin/activate
+ uv install jupyter


AFter this , when we come back we assume we have both
project.yml and lock.uv.
we could restor everything withk

+ uv sync

assuming there are already lock.uv and project.yml



## Dockerfile_docker and docker-compose_docker.yml
This is the container doing d-in-d!!! 

we run docker at the command line!!!.

A couple things we need to be careful,

+ need to do something to enable docker in docker at
both build time and run time. (check the docker and docker compose
files)

+


