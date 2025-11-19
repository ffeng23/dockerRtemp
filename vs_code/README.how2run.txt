
# README on how to run the dockers.

##  Dockefile,

+ need to change the id and user name to match the host user id.
note: the default user name is 'abc', defined by vs-code server original docker image

Need to work on this later to see how to change the user id.

update 11/6/2025: No!!1 (need to confirm) we don't need to change at the Dockerfile.
but instead, vs code server docker has the way to change to match with host file permission.
by setting at the run time (through command line, e.g., docker run -d \
  --name=code-server \
  -e PUID=1000 \
  -e PGID=1000 \ .... or docker compose file) to
specify the user id and group id (but not user name!!!???)
see the readme for code server

+ if this is for R ide, we need to specify the R version.

##  docker-compose

+ change id and group id

+ specify the password.

+ take care of the disk volume (?)
