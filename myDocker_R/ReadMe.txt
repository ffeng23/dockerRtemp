this is a simply docker image using R to showcase the usage of docker for my own testing.

#commands

## to build with an arbitrary name at the current directory
docker build -t "simpler" .

## to run the built docker image.
docker run -it "simpler"

## to clean up/show/rm
docker images
docker image ls -a
docker container ls -a
docker container rm <id>
docker image rm <id>|<repo:tag>

## check the github repo at other/jupyter_docker.md for other related commands.
