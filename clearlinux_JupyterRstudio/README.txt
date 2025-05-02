## README about docker file and docker compose yaml


## 1) Dockerfile.orig 
this is the one used to do docker for running vcf to maf conversion.

This is originally from github.

## 2) Dockerfile_jupyterlab

this is my own docker based on Dockerfile.orig to prepare jupyterlab.

see the dockerfile for running and building. 

also there is a docker compose (see ## 3)) for details

## 3) docker-compose.yml
this is the docker compose file to call to run and building the ## 2) file

see the file for running and calling.


## 4) Dockerfile_rocker
this is the first one to host rstudio application.

It has TWO layers and run installation of rstudio from source

## 5) Dockerfile_rocker2

this is the second one, used as scrap paper to try out installation of some function in clearlinux 

## 5) Dockerfile_rokcer3

On top of Dockerfile_rocker, add another layer in order to reduce the size of image.
it does, but the size is still very huge, about 6G.

## 6) docker-compose_rstudio.yml 

this is the docker compose to call run the Dockerfile_rocker .


